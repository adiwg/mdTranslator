# unpack dateTime
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-12-11 original script
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers

require 'adiwg/mdtranslator/internal/module_dateTimeFun'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module DateTime

                    def self.unpack(sDateTime)

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new

                        # dateTime
                        intDateTime = intMetadataClass.newDateTime

                        aDateTimeReturn = AdiwgDateTimeFun.dateTimeFromString(sDateTime)
                        intDateTime[:dateTime] = aDateTimeReturn[0]
                        intDateTime[:dateResolution] = aDateTimeReturn[1]

                        return intDateTime

                    end

                end

            end
        end
    end
end