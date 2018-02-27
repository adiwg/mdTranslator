# unpack series
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-02-19 refactored error and warning messaging
# 	Stan Smith 2017-11-01 original script

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module ValueRange

               def self.unpack(hRange, responseObj)

                  # return nil object if input is empty
                  if hRange.empty?
                     responseObj[:readerExecutionMessages] << 'WARNING: mdJson reader: value range object is empty'
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
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson value range minimum is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # value range - maximum range value (required)
                  if hRange.has_key?('maxRangeValue')
                     intRange[:maxRangeValue] = hRange['maxRangeValue']
                  end
                  if intRange[:maxRangeValue].nil? || intRange[:maxRangeValue] == ''
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson value range maximum is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  return intRange

               end

            end

         end
      end
   end
end
