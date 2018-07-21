# unpack measure
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-21 refactored error and warning messaging
# 	Stan Smith 2016-10-17 original script

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module Measure

               def self.unpack(hMeasure, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hMeasure.empty?
                     @MessagePath.issueWarning(540, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intMeasure = intMetadataClass.newMeasure

                  # measure - type enumeration (required)
                  if hMeasure.has_key?('type')
                     unless hMeasure['type'] == ''
                        type = hMeasure['type']
                        if %w{ distance length vertical angle measure scale }.one? {|word| word == type}
                           intMeasure[:type] = hMeasure['type']
                        else
                           @MessagePath.issueError(541, responseObj, inContext)
                        end
                     end
                  end
                  if intMeasure[:type].nil? || intMeasure[:type] == ''
                     @MessagePath.issueError(542, responseObj, inContext)
                  end

                  # measure - value (required)
                  if hMeasure.has_key?('value')
                     intMeasure[:value] = hMeasure['value']
                  end
                  if intMeasure[:value].nil? || intMeasure[:value] == ''
                     @MessagePath.issueError(543, responseObj, inContext)
                  end

                  # measure - unit of measure (required)
                  if hMeasure.has_key?('unitOfMeasure')
                     intMeasure[:unitOfMeasure] = hMeasure['unitOfMeasure']
                  end
                  if intMeasure[:unitOfMeasure].nil? || intMeasure[:unitOfMeasure] == ''
                     @MessagePath.issueError(544, responseObj, inContext)
                  end

                  return intMeasure

               end

            end

         end
      end
   end
end
