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

            module MapGridOther

               def self.unpack(other, hProjection)

                  # grid system 4.1.2.2.6 (othergrd) - other coordinate system {text}
                  # -> ReferenceSystemParameters.projection.gridIdentifier.description

                  hProjectionId = hProjection[:projectionIdentifier]
                  hGridSystemId = hProjection[:gridIdentifier]

                  hGridSystemId[:identifier] = 'other'
                  hGridSystemId[:name] = 'Other Grid Coordinate System' if hGridSystemId[:name].nil?
                  hGridSystemId[:description] = other

                  hProjectionId[:identifier] = 'other'
                  hProjectionId[:name] = 'Other Projection'
                  hProjectionId[:description] = 'for description see grid system description'

                  return hProjection

               end

            end

         end
      end
   end
end
