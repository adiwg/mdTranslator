# unpack temporal extent
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2016-10-24 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_timeInstant')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_timePeriod')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module TemporalExtent

                    def self.unpack(hTemporal, responseObj)

                        # return nil object if input is empty
                        if hTemporal.empty?
                            responseObj[:readerExecutionMessages] << 'Temporal Extent object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intTemporal = intMetadataClass.newTemporalExtent

                        # temporal extent - type (required)
                        if hTemporal.has_key?('type')
                            if hTemporal['type'] != ''
                                type = hTemporal['type']
                                if %w{ instant period }.one? { |word| word == type }
                                    intTemporal[:type] = hTemporal['type']
                                else
                                    responseObj[:readerExecutionMessages] << 'Temporal Extent type must be instant or period'
                                    responseObj[:readerExecutionPass] = false
                                    return nil
                                end
                            end
                        end
                        if intTemporal[:type].nil? || intTemporal[:type] == ''
                            responseObj[:readerExecutionMessages] << 'Temporal Extent is missing type'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # temporal extent - time instant (required if)
                        if hTemporal['type'] == 'instant'
                            if hTemporal.has_key?('timeInstant')
                                hTime = hTemporal['timeInstant']
                                unless hTime.empty?
                                    hObject = TimeInstant.unpack(hTime, responseObj)
                                    unless hObject.nil?
                                        intTemporal[:timeInstant] = hObject
                                    end
                                end
                            end
                            if intTemporal[:timeInstant].empty?
                                responseObj[:readerExecutionMessages] << 'Temporal Extent is missing timeInstant object'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        end

                        # temporal extent - time period (required if)
                        if hTemporal['type'] == 'period'
                            if hTemporal.has_key?('timePeriod')
                                hTime = hTemporal['timePeriod']
                                unless hTime.empty?
                                    hObject = TimePeriod.unpack(hTime, responseObj)
                                    unless hObject.nil?
                                        intTemporal[:timePeriod] = hObject
                                    end
                                end
                            end
                            if intTemporal[:timePeriod].empty?
                                responseObj[:readerExecutionMessages] << 'Temporal Extent is missing timePeriod object'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        end

                        return intTemporal

                    end

                end

            end
        end
    end
end
