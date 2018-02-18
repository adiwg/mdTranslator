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
                  return true if str =~ /[-+]?[0-9]*\.?[0-9]+/
                  true if Float(str) rescue false
               end

               def self.unpack(xRange, hAttribute, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  axRanges = xRange.xpath('./rdom')
                  unless axRanges.empty?
                     axRanges.each do |xRange|

                        hRange = intMetadataClass.newValueRange
                        hAttribute[:valueRange] << hRange

                        # entity attribute 5.1.2.4.2.1 (rdommin) - range minimum (required)
                        # -> dataDictionary.entities.attributes.minValue
                        # -> dataDictionary.entities.attributes.valueRange.minRangeValue
                        min = xRange.xpath('./rdommin').text
                        unless min.empty?
                           hRange[:minRangeValue] = min
                           a = [min]
                           a << hAttribute[:minValue] unless hAttribute[:minValue].nil?
                           b = a.sort_by do |s|
                              if s =~ /[-+]?[0-9]*\.?[0-9]+/
                                 [2, $&.to_f]
                              else
                                 [1, s]
                              end
                           end
                           hAttribute[:minValue] = b[0]
                        end
                        if min.nil?
                           hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC domain range minimum is missing'
                        end

                        # entity attribute 5.1.2.4.2.2 (rdommax) - range maximum (required)
                        # -> dataDictionary.entities.attributes.maxValue
                        # -> dataDictionary.entities.attributes.valueRange.maxRangeValue
                        max = xRange.xpath('./rdommax').text
                        unless max.empty?
                           hRange[:maxRangeValue] = max
                           a = [max]
                           a << hAttribute[:maxValue] unless hAttribute[:maxValue].nil?
                           b = a.sort_by do |s|
                              if s =~ /[-+]?[0-9]*\.?[0-9]+/
                                 [2, $&.to_f]
                              else
                                 [1, s]
                              end
                           end
                           hAttribute[:maxValue] = b[b.length-1]
                        end
                        if max.nil?
                           hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC domain range maximum is missing'
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

                     end
                  end

                  return hAttribute

               end

            end

         end
      end
   end
end
