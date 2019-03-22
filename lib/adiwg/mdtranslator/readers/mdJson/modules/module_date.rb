# unpack date
# Reader - ADIwg JSON data structure

# History:
#  Stan Smith 2018-06-18 refactored error and warning messaging
#  Stan Smith 2016-10-12 original script

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module Date

               def self.unpack(hDate, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hDate.empty?
                     @MessagePath.issueWarning(150, responseObj, inContext)
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
                        @MessagePath.issueError(151, responseObj, inContext)
                     else
                        intDate[:date] = aDateTimeReturn[0]
                        intDate[:dateResolution] = aDateTimeReturn[1]
                     end
                  else
                     @MessagePath.issueError(152, responseObj, inContext)
                  end

                  # date - date type (required)
                  if hDate.has_key?('dateType')
                     intDate[:dateType] = hDate['dateType']
                  end
                  if intDate[:dateType].nil? || intDate[:dateType] == ''
                     @MessagePath.issueError(153, responseObj, inContext)
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