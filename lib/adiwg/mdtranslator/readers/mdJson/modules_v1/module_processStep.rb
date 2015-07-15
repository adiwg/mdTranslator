# unpack process step
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-26 original script
#   Stan Smith 2014-07-03 resolve require statements using Mdtranslator.reader_module
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_responsibleParty')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_dateTime')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module ProcessStep

                    def self.unpack(hProcStep, responseObj)

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intDataPStep = intMetadataClass.newDataProcessStep

                        # process step - step ID
                        if hProcStep.has_key?('stepId')
                            s = hProcStep['stepId']
                            if s != ''
                                intDataPStep[:stepId] = s
                            end
                        end

                        # process step - description
                        if hProcStep.has_key?('description')
                            s = hProcStep['description']
                            if s != ''
                                intDataPStep[:stepDescription] = s
                            end
                        end

                        # process step - rationale
                        if hProcStep.has_key?('rationale')
                            s = hProcStep['rationale']
                            if s != ''
                                intDataPStep[:stepRationale] = s
                            end
                        end

                        # process step - dateTime
                        if hProcStep.has_key?('dateTime')
                            s = hProcStep['dateTime']
                            if s != ''
                                intDataPStep[:stepDateTime] = DateTime.unpack(s, responseObj)
                            end
                        end

                        # process step - step processors
                        if hProcStep.has_key?('processor')
                            aProcessors = hProcStep['processor']
                            unless aProcessors.empty?
                                aProcessors.each do |processor|
                                    intDataPStep[:stepProcessors] << ResponsibleParty.unpack(processor, responseObj)
                                end
                            end
                        end

                        return intDataPStep
                    end

                end

            end
        end
    end
end
