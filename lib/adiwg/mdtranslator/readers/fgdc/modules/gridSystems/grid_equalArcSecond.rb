# Reader - fgdc to internal data structure
# unpack fgdc map grid coordinate system

# History:
#  Stan Smith 2018-10-04 original script

require 'nokogiri'
require_relative '../mapProjections/projection_equirectangular'
require_relative '../mapProjections/projection_azimuthEquidistant'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module MapGridEqualArcSecond

               def self.unpack(xArc, hProjection, hResponseObj)

                  # grid system 4.1.2.2.5 (arcsys) - equal arc-second coordinate system

                  hGridSystemId = hProjection[:gridSystemIdentifier]
                  hProjectionId = hProjection[:projectionIdentifier]

                  hGridSystemId[:identifier] = 'arcsys'
                  hGridSystemId[:name] = 'Equal Arc-Second Coordinate System' if hGridSystemId[:name].nil?

                  # grid system 4.1.2.2.5.1 (arcszone) - state plane zone number {1..18} (required)
                  # -> ReferenceSystemParameters.projection.gridZone
                  zone = xArc.xpath('./arczone').text
                  unless zone.empty?
                     hProjection[:gridZone] = zone
                  end
                  if zone.empty?
                     hResponseObj[:readerExecutionMessages] <<
                        'WARNING: FGDC reader: equal arc-second zone number is missing'
                  end

                  # + [ equirectangular | azimuthal equidistant ] (required)
                  # + equirectangular
                  xEquiR = xArc.xpath('./equirect')
                  unless xEquiR.empty?
                     hProjectionId[:identifier] = 'equirectangular'
                     hProjectionId[:name] = 'Equirectangular'
                     return EquirectangularProjection.unpack(xEquiR, hProjection, hResponseObj)
                  end

                  # + azimuthal equidistant
                  xAzimuthE = xArc.xpath('./azimequi')
                  unless xAzimuthE.empty?
                     hProjectionId[:identifier] = 'azimuthalEquidistant'
                     hProjectionId[:name] = 'Azimuthal Equidistant'
                     return AzimuthEquidistantProjection.unpack(xAzimuthE, hProjection, hResponseObj)
                  end

                  # error message
                  hResponseObj[:readerExecutionMessages] <<
                     'WARNING: FGDC reader: UPS equal arc-second projection definition is missing'

                  return hProjection

               end

            end

         end
      end
   end
end
