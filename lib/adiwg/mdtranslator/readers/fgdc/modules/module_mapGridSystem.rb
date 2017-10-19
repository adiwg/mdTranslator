# Reader - fgdc to internal data structure
# unpack fgdc map grid coordinate system

# History:
#  Stan Smith 2017-10-04 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
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

                  # grid system 4.1.2.2.1 (gridsysn) - grid coordinate system name
                  # -> ReferenceSystemParameters.projection.projectionIdentifier.identifier
                  name = xMapGrid.xpath('./gridsysn').text
                  unless name.empty?
                     hIdentifier = intMetadataClass.newIdentifier
                     hIdentifier[:identifier] = name
                     hProjection[:projectionIdentifier] = hIdentifier
                  end

                  # grid system 4.1.2.2.2 (utm) - universal transverse mercator
                  xUTM = xMapGrid.xpath('./utm')
                  unless xUTM.empty?

                     # grid system 4.1.2.2.2.1 (utmzone) - utm zone number {-60..-1, 1..60}
                     # -> ReferenceSystemParameters.projection.zone
                     zone = xUTM.xpath('./utmzone').text
                     unless zone.empty?
                        hProjection[:zone] = zone
                     end

                     # + transverse mercator
                     xTransMer = xUTM.xpath('./transmer')
                     unless xTransMer.empty?
                        return TransverseMercatorProjection.unpack(xTransMer, hProjection, hResponseObj)
                     end

                  end

                  # grid system 4.1.2.2.3 (ups) - universal polar stereographic
                  xUSP = xMapGrid.xpath('./ups')
                  unless xUSP.empty?

                     # grid system 4.1.2.2.3.1 (upszone) - utm zone number {-60..-1, 1..60}
                     # -> ReferenceSystemParameters.projection.zone
                     zone = xUSP.xpath('./upszone').text
                     unless zone.empty?
                        hProjection[:zone] = zone
                     end

                     # + polar stereographic
                     xPolarS = xUSP.xpath('./polarst')
                     unless xPolarS.empty?
                        return PolarStereoProjection.unpack(xPolarS, hProjection, hResponseObj)
                     end

                  end

                  # grid system 4.1.2.2.4 (spcs) - state plane coordinate system
                  xStateP = xMapGrid.xpath('./spcs')
                  unless xStateP.empty?

                     # grid system 4.1.2.2.4.1 (spcszone) - state plane zone number {nnnn}
                     # -> ReferenceSystemParameters.projection.zone
                     zone = xStateP.xpath('./spcszone').text
                     unless zone.empty?
                        hProjection[:zone] = zone
                     end

                     # + [ lambert conformal conic | transverse mercator | oblique mercator | polyconic ]
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

                  end

                  # grid system 4.1.2.2.5 (arcsys) - equal arc-second coordinate system
                  xArc = xMapGrid.xpath('./arcsys')
                  unless xArc.empty?

                     # grid system 4.1.2.2.5.1 (arcszone) - state plane zone number {1..18}
                     # -> ReferenceSystemParameters.projection.zone
                     zone = xArc.xpath('./arczone').text
                     unless zone.empty?
                        hProjection[:zone] = zone
                     end

                     # + [ equirectangular | azimuthal equidistant ]
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

                  end

                  # grid system 4.1.2.2.6 (othergrd) - other coordinate system {text}
                  otherG = xMapGrid.xpath('./othergrd').text
                  unless otherG.empty?
                     hProjection[:otherGrid] = otherG
                     hProjection[:projectionName] = 'other grid system'
                     return hProjection
                  end

                  return nil

               end

            end

         end
      end
   end
end
