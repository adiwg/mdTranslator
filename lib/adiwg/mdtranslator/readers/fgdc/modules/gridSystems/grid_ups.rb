# Reader - fgdc to internal data structure
# unpack fgdc map grid coordinate system

# History:
#  Stan Smith 2018-10-04 original script

require 'nokogiri'
require_relative '../mapProjections/projection_polarStereo'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module MapGridUps

               def self.unpack(xUPS, hProjection, hResponseObj)

                  # grid system 4.1.2.2.3 (ups) - universal polar stereographic

                  hGridSystemId = hProjection[:gridIdentifier]
                  hProjectionId = hProjection[:projectionIdentifier]

                  hGridSystemId[:identifier] = 'ups'
                  hGridSystemId[:name] = 'Universal Polar Stereographic' if hGridSystemId[:name].nil?

                  # grid system 4.1.2.2.3.1 (upszone) - utm zone number {-60..-1, 1..60} (required)
                  # -> ReferenceSystemParameters.projection.gridZone
                  zone = xUPS.xpath('./upszone').text
                  unless zone.empty?
                     hProjection[:gridZone] = zone
                  end
                  if zone.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: UPS zone number is missing'
                  end

                  # + polar stereographic (required)
                  xPolarS = xUPS.xpath('./polarst')
                  unless xPolarS.empty?
                     hProjectionId[:identifier] = 'polarStereo'
                     hProjectionId[:name] = 'Polar Stereographic'
                     return PolarStereoProjection.unpack(xPolarS, hProjection, hResponseObj)
                  end

                  # error message
                  hResponseObj[:readerExecutionMessages] <<
                     'WARNING: FGDC reader: UPS polar stereographic definition is missing'

                  return hProjection

               end

            end

         end
      end
   end
end
