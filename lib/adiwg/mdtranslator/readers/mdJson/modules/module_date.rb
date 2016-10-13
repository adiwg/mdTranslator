# unpack date
# Reader - ADIwg JSON data structure

# History:
#   Stan Smith 2016-10-12 original script

require 'adiwg/mdtranslator/internal/module_dateTimeFun'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Date

                    def self.unpack(hDate, responseObj)

                        # return nil object if input is empty
                        if hDate.empty?
                            responseObj[:readerExecutionMessages] << 'Date object is empty'
                            responseObj[:readerExecutionPass] = false
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
                                responseObj[:readerExecutionMessages] << 'Date string is invalid'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            else
                                intDate[:date] = aDateTimeReturn[0]
                                intDate[:dateResolution] = aDateTimeReturn[1]
                            end
                        else
                            responseObj[:readerExecutionMessages] << 'Date string is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # date - date type (required)
                        if hDate.has_key?('dateType')
                            intDate[:dateType] = hDate['dateType']
                        end
                        if intDate[:dateType].nil? || intDate[:dateType] == ''
                            responseObj[:readerExecutionMessages] << 'Date attribute dateType is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        return intDate

                    end

                end

            end
        end
    end
end