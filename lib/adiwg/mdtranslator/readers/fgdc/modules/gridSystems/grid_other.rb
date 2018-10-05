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
                  # -> ReferenceSystemParameters.projection.gridSystemIdentifier.description

                  hGridSystemId = hProjection[:gridSystemIdentifier]

                  hGridSystemId[:identifier] = 'other'
                  hGridSystemId[:name] = 'other grid coordinate system' if hGridSystemId[:name].nil?
                  hGridSystemId[:description] = other

                  return hProjection

               end

            end

         end
      end
   end
end
