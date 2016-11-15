# unpack time interval
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2016-10-14 original script

require_relative 'module_dateTime'
require_relative 'module_timeInterval'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module TimePeriod

                    def self.unpack(hTimePeriod, responseObj)

                        # return nil object if input is empty
                        if hTimePeriod.empty?
                            responseObj[:readerExecutionMessages] << 'Time Period object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intTimePer = intMetadataClass.newTimePeriod

                        # time period - id
                        if hTimePeriod.has_key?('id')
                            if hTimePeriod['id'] != ''
                                intTimePer[:timeId] = hTimePeriod['id']
                            end
                        end

                        # time period - description
                        if hTimePeriod.has_key?('description')
                            if hTimePeriod['description'] != ''
                                intTimePer[:description] = hTimePeriod['description']
                            end
                        end

                        # time period - identifier
                        if hTimePeriod.has_key?('identifier')
                            if hTimePeriod['identifier'] != ''
                                intTimePer[:identifier] = hTimePeriod['identifier']
                            end
                        end

                        # time period - period names []
                        if hTimePeriod.has_key?('periodName')
                            hTimePeriod['periodName'].each do |item|
                                if item != ''
                                    intTimePer[:periodNames] << item
                                end
                            end
                        end

                        # time period - start datetime
                        if hTimePeriod.has_key?('startDateTime')
                            if hTimePeriod['startDateTime'] != ''
                                hDate = DateTime.unpack(hTimePeriod['startDateTime'], responseObj)
                                unless hDate.nil?
                                    intTimePer[:startDateTime] = hDate
                                end
                            end
                        end

                        # time period - end datetime
                        if hTimePeriod.has_key?('endDateTime')
                            if hTimePeriod['endDateTime'] != ''
                                hDate = DateTime.unpack(hTimePeriod['endDateTime'], responseObj)
                                unless hDate.nil?
                                    intTimePer[:endDateTime] = hDate
                                end
                            end
                        end

                        if intTimePer[:startDateTime].empty? && intTimePer[:endDateTime].empty?
                            responseObj[:readerExecutionMessages] << 'Time Period is missing both a start and an end time'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # time period - time interval
                        if hTimePeriod.has_key?('timeInterval')
                            unless hTimePeriod['timeInterval'].empty?
                                hTimeInt = TimeInterval.unpack(hTimePeriod['timeInterval'], responseObj)
                                unless hTimeInt.nil?
                                    intTimePer[:timeInterval] = hTimeInt
                                end
                            end
                        end

                        return intTimePer

                    end

                end

            end
        end
    end
end
