# Reader - fgdc to internal data structure
# unpack fgdc map grid coordinate system

# History:
#  Stan Smith 2018-10-04 original script

require 'nokogiri'
require_relative '../mapProjections/projection_transverseMercator'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module MapGridUtm

               def self.unpack(xUTM, hProjection, hResponseObj)

                  # grid system 4.1.2.2.2 (utm) - universal transverse mercator

                  hGridSystemId = hProjection[:gridIdentifier]
                  hProjectionId = hProjection[:projectionIdentifier]

                  hGridSystemId[:identifier] = 'utm'
                  hGridSystemId[:name] = 'Universal Transverse Mercator' if hGridSystemId[:name].nil?

                  # grid system 4.1.2.2.2.1 (utmzone) - utm zone number {-60..-1, 1..60} (required)
                  # -> ReferenceSystemParameters.projection.gridZone
                  zone = xUTM.xpath('./utmzone').text
                  unless zone.empty?
                     hProjection[:gridZone] = zone
                  end
                  if zone.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: UTM zone number is missing'
                  end

                  # + transverse mercator (required)
                  xTransMer = xUTM.xpath('./transmer')
                  unless xTransMer.empty?
                     hProjectionId[:identifier] = 'transverseMercator'
                     hProjectionId[:name] = 'Transverse Mercator'
                     return TransverseMercatorProjection.unpack(xTransMer, hProjection, hResponseObj)
                  end

                  # error message
                  hResponseObj[:readerExecutionMessages] <<
                     'WARNING: FGDC reader: UTM transverse mercator definition is missing'

                  return hProjection

               end

            end

         end
      end
   end
end
