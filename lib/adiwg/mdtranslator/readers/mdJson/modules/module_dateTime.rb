# unpack dateTime
# Reader - ADIwg JSON V1 to internal data structure

# History:
#  Stan Smith 2018-06-18 refactored error and warning messaging
#  Stan Smith 2016-10-05 refactored for mdJson 2.0
#  Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#  Stan Smith 2015-07-14 refactored to remove global namespace constants
# 	Stan Smith 2013-12-11 original script

require 'adiwg/mdtranslator/internal/module_dateTimeFun'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module DateTime

               def self.unpack(sDateTime, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if sDateTime == ''
                     @MessagePath.issueWarning(160, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intDateTime = intMetadataClass.newDateTime

                  # dateTime - dateTime (required)
                  # if dateTimeFromString fails, [0] = nil; [1] = 'ERROR'
                  aDateTimeReturn = AdiwgDateTimeFun.dateTimeFromString(sDateTime)
                  if aDateTimeReturn[1] == 'ERROR'
                     @MessagePath.issueError(161, responseObj, inContext)
                  else
                     intDateTime[:dateTime] = aDateTimeReturn[0]
                     intDateTime[:dateResolution] = aDateTimeReturn[1]
                  end

                  return intDateTime

               end

            end

         end
      end
   end
end