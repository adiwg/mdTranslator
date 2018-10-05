# Reader - fgdc to internal data structure
# unpack fgdc map grid coordinate system

# History:
#  Stan Smith 2018-10-04 original script

require 'nokogiri'
require_relative '../mapProjections/projection_transverseMercator'
require_relative '../mapProjections/projection_lambertConic'
require_relative '../mapProjections/projection_obliqueMercator'
require_relative '../mapProjections/projection_polyconic'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module MapGridStatePlane

               def self.unpack(xStateP, hProjection, hResponseObj)

                  # grid system 4.1.2.2.4 (spcs) - state plane coordinate system

                  hGridSystemId = hProjection[:gridSystemIdentifier]
                  hProjectionId = hProjection[:projectionIdentifier]

                  hGridSystemId[:identifier] = 'spcs'
                  hGridSystemId[:name] = 'State Plane Coordinate System' if hGridSystemId[:name].nil?

                  # grid system 4.1.2.2.4.1 (spcszone) - state plane zone number {nnnn} (required)
                  # -> ReferenceSystemParameters.projection.gridZone
                  zone = xStateP.xpath('./spcszone').text
                  unless zone.empty?
                     hProjection[:gridZone] = zone
                  end
                  if zone.empty?
                     hResponseObj[:readerExecutionMessages] <<
                        'WARNING: FGDC reader: state plane zone number is missing'
                  end

                  # + [ lambert conformal conic | transverse mercator | oblique mercator | polyconic ] (required)
                  # + lambert conformal conic
                  xLambert = xStateP.xpath('./lambertc')
                  unless xLambert.empty?
                     hProjectionId[:identifier] = 'lambertConic'
                     hProjectionId[:name] = 'Lambert Conformal Conic'
                     return LambertConicProjection.unpack(xLambert, hProjection, hResponseObj)
                  end

                  # + transverse mercator
                  xTransMer = xStateP.xpath('./transmer')
                  unless xTransMer.empty?
                     hProjectionId[:identifier] = 'transverseMercator'
                     hProjectionId[:name] = 'Transverse Mercator'
                     return TransverseMercatorProjection.unpack(xTransMer, hProjection, hResponseObj)
                  end

                  # + oblique mercator
                  xObliqueM = xStateP.xpath('./obqmerc')
                  unless xObliqueM.empty?
                     hProjectionId[:identifier] = 'obliqueMercator'
                     hProjectionId[:name] = 'Oblique Mercator'
                     return ObliqueMercatorProjection.unpack(xObliqueM, hProjection, hResponseObj)
                  end

                  # + polyconic
                  xPolyCon = xStateP.xpath('./polycon')
                  unless xPolyCon.empty?
                     hProjectionId[:identifier] = 'polyconic'
                     hProjectionId[:name] = 'Polyconic'
                     return PolyconicProjection.unpack(xPolyCon, hProjection, hResponseObj)
                  end

                  # error message
                  hResponseObj[:readerExecutionMessages] <<
                     'WARNING: FGDC reader: UPS state plane projection definition is missing'

                  return hProjection

               end

            end

         end
      end
   end
end
