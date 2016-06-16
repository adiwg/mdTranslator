require 'adiwg/mdtranslator/internal/module_dateTimeFun'

module ADIWG
    module Mdtranslator
        module Readers
            module SbJson

                module DateTime

                    def self.unpack(sDateTime, responseObj)

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
