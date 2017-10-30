# Reader - fgdc to internal data structure
# unpack fgdc entity range domain

# History:
#  Stan Smith 2017-10-30 added range domain
#  Stan Smith 2017-09-06 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module Range

               def self.is_number?(str)
                  return true if str =~ /\A\d+\Z/
                  true if Float(str) rescue false
               end

               def self.unpack(xRange, hAttribute, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hRange = intMetadataClass.newValueRange

                  # entity attribute 5.1.2.4.2.1 (rdommin) - range minimum
                  # -> dataDictionary.entities.attributes.minValue
                  # -> dataDictionary.entities.attributes.rangeOfValues.minRangeValue
                  min = xRange.xpath('./rdommin').text
                  unless min.empty?
                     min = min.to_f if is_number?(min)
                     hRange[:minRangeValue] = min
                     if hAttribute[:minValue].nil?
                        hAttribute[:minValue] = min
                     else
                        hAttribute[:minValue] = [hAttribute[:minValue], min].min
                     end
                  end

                  # entity attribute 5.1.2.4.2.2 (rdommax) - range maximum
                  # -> dataDictionary.entities.attributes.maxValue
                  # -> dataDictionary.entities.attributes.rangeOfValues.maxRangeValue
                  max = xRange.xpath('./rdommax').text
                  unless max.empty?
                     max = max.to_f if is_number?(max)
                     hRange[:maxRangeValue] = max
                     if hAttribute[:maxValue].nil?
                        hAttribute[:maxValue] = max
                     else
                        hAttribute[:maxValue] = [hAttribute[:maxValue], max].max
                     end
                  end

                  # entity attribute 5.1.2.4.2.3 (attrunit) - units of measure
                  # -> dataDictionary.entities.attributes.unitOfMeasure
                  units = xRange.xpath('./attrunit').text
                  unless units.empty?
                     hAttribute[:unitOfMeasure] = units
                  end

                  # entity attribute 5.1.2.4.2.4 (attrmres) - measurement resolution
                  # -> dataDictionary.entities.attributes.measureResolution
                  resolution = xRange.xpath('./attrmres').text
                  unless resolution.empty?
                     if is_number?(resolution)
                        hAttribute[:measureResolution] = resolution.to_f
                     end
                  end

                  hAttribute[:rangeOfValues] << hRange
                  return hAttribute

               end

            end

         end
      end
   end
end
