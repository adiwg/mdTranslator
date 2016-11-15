# unpack process step
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2016-10-15 refactored for mdJson 2.0
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2014-07-03 resolve require statements using Mdtranslator.reader_module
# 	Stan Smith 2013-11-26 original script

require_relative 'module_timePeriod'
require_relative 'module_responsibleParty'
require_relative 'module_citation'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module ProcessStep

                    def self.unpack(hProcStep, responseObj)

                        # return nil object if input is empty
                        if hProcStep.empty?
                            responseObj[:readerExecutionMessages] << 'Process Step object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intProcStep = intMetadataClass.newProcessStep

                        # process step - step ID
                        if hProcStep.has_key?('stepId')
                            if hProcStep['stepId'] != ''
                                intProcStep[:stepId] = hProcStep['stepId']
                            end
                        end

                        # process step - description - required
                        if hProcStep.has_key?('description')
                            intProcStep[:description] = hProcStep['description']
                        end
                        if intProcStep[:description].nil? || intProcStep[:description] == ''
                            responseObj[:readerExecutionMessages] << 'Process Step attribute description is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # process step - rationale
                        if hProcStep.has_key?('rationale')
                            if hProcStep['rationale'] != ''
                                intProcStep[:rationale] = hProcStep['rationale']
                            end
                        end

                        # process step - time period
                        if hProcStep.has_key?('timePeriod')
                            hObject = hProcStep['timePeriod']
                            unless hObject.empty?
                                hReturn = TimePeriod.unpack(hObject, responseObj)
                                unless hReturn.nil?
                                    intProcStep[:timePeriod] = hReturn
                                end
                            end
                        end

                        # process step - step processors [responsible party]
                        if hProcStep.has_key?('processor')
                            aProc = hProcStep['processor']
                            aProc.each do |item|
                                hParty = ResponsibleParty.unpack(item, responseObj)
                                unless hParty.nil?
                                    intProcStep[:processors] << hParty
                                end
                            end
                        end

                        # process step - reference [citation]
                        if hProcStep.has_key?('reference')
                            aReference = hProcStep['reference']
                            aReference.each do |item|
                                hReference = Citation.unpack(item, responseObj)
                                unless hReference.nil?
                                    intProcStep[:references] << hReference
                                end
                            end
                        end

                        return intProcStep

                    end

                end

            end
        end
    end
end
