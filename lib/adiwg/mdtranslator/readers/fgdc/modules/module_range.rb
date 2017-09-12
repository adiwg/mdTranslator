# Reader - fgdc to internal data structure
# unpack fgdc entity range domain

# History:
#  Stan Smith 2017-09-06 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module Range

               def self.unpack(xRange, hAttribute, hResponseObj)

                  # entity attribute 5.1.2.4.2.1 (rdommin) - range minimum
                  # -> dataDictionary.entities.attributes.minValue
                  min = xRange.xpath('./rdommin').text
                  unless min.empty?
                     hAttribute[:minValue] = min
                  end

                  # entity attribute 5.1.2.4.2.2 (rdommax) - range maximum
                  # -> dataDictionary.entities.attributes.maxValue
                  max = xRange.xpath('./rdommax').text
                  unless max.empty?
                     hAttribute[:maxValue] = max
                  end

                  # entity attribute 5.1.2.4.2.3 (attrunit) - units of measure
                  # -> dataDictionary.entities.attributes.unitOfMeasure
                  units = xRange.xpath('./attrunit').text
                  unless units.empty?
                     hAttribute[:unitOfMeasure] = units
                  end

                  # entity attribute 5.1.2.4.2.4 (attrmres) - measurement resolution
                  # -> not mapped

               end

            end

         end
      end
   end
end
