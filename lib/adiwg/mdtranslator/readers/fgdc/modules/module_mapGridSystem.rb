# Reader - fgdc to internal data structure
# unpack fgdc map grid coordinate system

# History:
#  Stan Smith 2017-10-04 original script

require 'nokogiri'
require_relative 'mapProjections/projection_transverseMercator'
require_relative 'mapProjections/projection_polarStereo'
require_relative 'mapProjections/projection_lambertConic'
require_relative 'mapProjections/projection_obliqueMercator'
require_relative 'mapProjections/projection_polyconic'
require_relative 'mapProjections/projection_equirectangular'
require_relative 'mapProjections/projection_azimuthEquidistant'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module MapGridSystem

               def self.unpack(xMapGrid, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hProjection = intMetadataClass.newProjection

                  # grid system 4.1.2.2.1 (gridsysn) - grid coordinate system name (required)
                  # -> ReferenceSystemParameters.projection.projectionIdentifier.identifier
                  gridName = xMapGrid.xpath('./gridsysn').text
                  unless gridName.empty?
                     hProjection[:gridSystemName] = gridName
                  end
                  if gridName.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC grid system name is missing'
                  end

                  haveGrid = false
                  # grid system 4.1.2.2.2 (utm) - universal transverse mercator
                  xUTM = xMapGrid.xpath('./utm')
                  unless xUTM.empty?

                     haveGrid = true
                     hProjection[:gridSystem] = 'utm'
                     hProjection[:gridSystemName] = 'Universal Transverse Mercator (UTM)' if gridName.empty?

                     # grid system 4.1.2.2.2.1 (utmzone) - utm zone number {-60..-1, 1..60} (required)
                     # -> ReferenceSystemParameters.projection.gridZone
                     zone = xUTM.xpath('./utmzone').text
                     unless zone.empty?
                        hProjection[:gridZone] = zone
                     end
                     if zone.empty?
                        hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC UTM zone number is missing'
                     end

                     # + transverse mercator (required)
                     xTransMer = xUTM.xpath('./transmer')
                     unless xTransMer.empty?
                        return TransverseMercatorProjection.unpack(xTransMer, hProjection, hResponseObj)
                     end
                     if xTransMer.empty?
                        hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC UTM transverse mercator definition is missing'
                     end

                  end

                  # grid system 4.1.2.2.3 (ups) - universal polar stereographic
                  xUSP = xMapGrid.xpath('./ups')
                  unless xUSP.empty?

                     haveGrid = true
                     hProjection[:gridSystem] = 'ups'
                     hProjection[:gridSystemName] = 'Universal Polar Stereographic (UPS)' if gridName.empty?

                     # grid system 4.1.2.2.3.1 (upszone) - utm zone number {-60..-1, 1..60} (required)
                     # -> ReferenceSystemParameters.projection.gridZone
                     zone = xUSP.xpath('./upszone').text
                     unless zone.empty?
                        hProjection[:gridZone] = zone
                     end
                     if zone.empty?
                        hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC UPS zone number is missing'
                     end

                     # + polar stereographic (required)
                     xPolarS = xUSP.xpath('./polarst')
                     unless xPolarS.empty?
                        return PolarStereoProjection.unpack(xPolarS, hProjection, hResponseObj)
                     end
                     if xPolarS.empty?
                        hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC UPS polar stereographic definition is missing'
                     end

                  end

                  # grid system 4.1.2.2.4 (spcs) - state plane coordinate system
                  xStateP = xMapGrid.xpath('./spcs')
                  unless xStateP.empty?

                     hProjection[:gridSystem] = 'spcs'
                     hProjection[:gridSystemName] = 'State Plane Coordinate System (SPCS)' if gridName.empty?

                     haveGrid = true
                     # grid system 4.1.2.2.4.1 (spcszone) - state plane zone number {nnnn} (required)
                     # -> ReferenceSystemParameters.projection.gridZone
                     zone = xStateP.xpath('./spcszone').text
                     unless zone.empty?
                        hProjection[:gridZone] = zone
                     end
                     if zone.empty?
                        hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC state plane zone number is missing'
                     end

                     # + [ lambert conformal conic | transverse mercator | oblique mercator | polyconic ] (required)
                     # + lambert conformal conic
                     xLambert = xStateP.xpath('./lambertc')
                     unless xLambert.empty?
                        return LambertConicProjection.unpack(xLambert, hProjection, hResponseObj)
                     end

                     # + transverse mercator
                     xTransMer = xStateP.xpath('./transmer')
                     unless xTransMer.empty?
                        return TransverseMercatorProjection.unpack(xTransMer, hProjection, hResponseObj)
                     end

                     # + oblique mercator
                     xObliqueM = xStateP.xpath('./obqmerc')
                     unless xObliqueM.empty?
                        return ObliqueMercatorProjection.unpack(xObliqueM, hProjection, hResponseObj)
                     end

                     # + polyconic
                     xPolyCon = xStateP.xpath('./polycon')
                     unless xPolyCon.empty?
                        return PolyconicProjection.unpack(xPolyCon, hProjection, hResponseObj)
                     end

                     # error message
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC UPS state plane projection definition is missing'

                  end

                  # grid system 4.1.2.2.5 (arcsys) - equal arc-second coordinate system
                  xArc = xMapGrid.xpath('./arcsys')
                  unless xArc.empty?

                     haveGrid = true
                     hProjection[:gridSystem] = 'arcsys'
                     hProjection[:gridSystemName] = 'Equal Arc-second Coordinate System (ARC)' if gridName.empty?

                     # grid system 4.1.2.2.5.1 (arcszone) - state plane zone number {1..18} (required)
                     # -> ReferenceSystemParameters.projection.gridZone
                     zone = xArc.xpath('./arczone').text
                     unless zone.empty?
                        hProjection[:gridZone] = zone
                     end
                     if zone.empty?
                        hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC equal arc-second zone number is missing'
                     end

                     # + [ equirectangular | azimuthal equidistant ] (required)
                     # + equirectangular
                     xEquiR = xArc.xpath('./equirect')
                     unless xEquiR.empty?
                        return EquirectangularProjection.unpack(xEquiR, hProjection, hResponseObj)
                     end

                     # + azimuthal equidistant
                     xAzimuthE = xArc.xpath('./azimequi')
                     unless xAzimuthE.empty?
                        return AzimuthEquidistantProjection.unpack(xAzimuthE, hProjection, hResponseObj)
                     end

                     # error message
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC UPS equal arc-second projection definition is missing'
                  end

                  # grid system 4.1.2.2.6 (othergrd) - other coordinate system {text}
                  # -> ReferenceSystemParameters.projection.otherGridDescription
                  otherG = xMapGrid.xpath('./othergrd').text
                  unless otherG.empty?

                     haveGrid = true
                     hProjection[:gridSystem] = 'other'
                     hProjection[:gridSystemName] = 'other grid coordinate system' if gridName.empty?

                     hProjection[:otherGridDescription] = otherG
                     return hProjection
                  end

                  # error message
                  unless haveGrid
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC grid system is missing'
                  end

                  return nil

               end

            end

         end
      end
   end
end
