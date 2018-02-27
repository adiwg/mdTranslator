# unpack date
# Reader - ADIwg JSON data structure

# History:
#  Stan Smith 2018-02-18 refactored error and warning messaging
#  Stan Smith 2016-10-12 original script

require 'adiwg/mdtranslator/internal/module_dateTimeFun'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module Date

               def self.unpack(hDate, responseObj)

                  # return nil object if input is empty
                  if hDate.empty?
                     responseObj[:readerExecutionMessages] << 'WARNING: mdJson reader: date object is empty'
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intDate = intMetadataClass.newDate

                  # date - date (required)
                  # if dateTimeFromString fails, [0] = nil; [1] = 'ERROR'
                  if hDate.has_key?('date') && hDate['date'] != ''
                     aDateTimeReturn = AdiwgDateTimeFun.dateTimeFromString(hDate['date'])
                     if aDateTimeReturn[1] == 'ERROR'
                        responseObj[:readerExecutionMessages] << 'ERROR: mdJson reader: date string is invalid'
                        responseObj[:readerExecutionPass] = false
                        return nil
                     else
                        intDate[:date] = aDateTimeReturn[0]
                        intDate[:dateResolution] = aDateTimeReturn[1]
                     end
                  else
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson reader: date string is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # date - date type (required)
                  if hDate.has_key?('dateType')
                     intDate[:dateType] = hDate['dateType']
                  end
                  if intDate[:dateType].nil? || intDate[:dateType] == ''
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson reader: date type is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # date - description
                  if hDate.has_key?('description')
                     s = hDate['description']
                     unless s == ''
                        intDate[:description] = s
                     end
                  end

                  return intDate

               end

            end

         end
      end
   end
end