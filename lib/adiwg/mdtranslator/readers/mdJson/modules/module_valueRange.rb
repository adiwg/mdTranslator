# unpack series
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-27 refactored error and warning messaging
# 	Stan Smith 2017-11-01 original script

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module ValueRange

               def self.unpack(hRange, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hRange.empty?
                     @MessagePath.issueWarning(890, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intRange = intMetadataClass.newValueRange

                  # value range - minimum range value (required)
                  if hRange.has_key?('minRangeValue')
                     intRange[:minRangeValue] = hRange['minRangeValue']
                  end
                  if intRange[:minRangeValue].nil? || intRange[:minRangeValue] == ''
                     @MessagePath.issueError(891, responseObj, inContext)
                  end

                  # value range - maximum range value (required)
                  if hRange.has_key?('maxRangeValue')
                     intRange[:maxRangeValue] = hRange['maxRangeValue']
                  end
                  if intRange[:maxRangeValue].nil? || intRange[:maxRangeValue] == ''
                     @MessagePath.issueError(892, responseObj, inContext)
                  end

                  return intRange

               end

            end

         end
      end
   end
end
