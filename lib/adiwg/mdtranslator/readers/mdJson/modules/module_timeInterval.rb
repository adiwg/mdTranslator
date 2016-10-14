# unpack time interval
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2016-10-14 original script

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module TimeInterval

                    def self.unpack(hTimeInt, responseObj)

                        # return nil object if input is empty
                        if hTimeInt.empty?
                            responseObj[:readerExecutionMessages] << 'Time Interval object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intTime = intMetadataClass.newTimeInterval

                        # time interval - interval (required)
                        if hTimeInt.has_key?('interval')
                            interval = hTimeInt['interval']
                            if interval != ''
                                if interval.is_a?(Integer) || interval.is_a?(Float)
                                    intTime[:interval] = hTimeInt['interval']
                                else
                                    responseObj[:readerExecutionMessages] << 'Time Interval attribute interval is not a number'
                                    responseObj[:readerExecutionPass] = false
                                    return nil
                                end
                            end
                        end
                        if intTime[:interval].nil? || intTime[:interval] == ''
                            responseObj[:readerExecutionMessages] << 'Time Interval attribute interval is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # time interval - units (required)
                        if hTimeInt.has_key?('units')
                            if hTimeInt['units'] != ''
                                intTime[:units] = hTimeInt['units']
                            end
                        end
                        if intTime[:units].nil? || intTime[:units] == ''
                            responseObj[:readerExecutionMessages] << 'Time Interval attribute units is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        return intTime
                    end

                end

            end
        end
    end
end
