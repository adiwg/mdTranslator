# unpack lineage
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-26 original script
#   Stan Smith 2014-07-03 resolve require statements using Mdtranslator.reader_module
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to remove global namespace constants

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_processStep')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_source')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Lineage

                    def self.unpack(hLineage, responseObj)

                        # return nil object if input is empty
                        intDataLine = nil
                        return if hLineage.empty?

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intDataLine = intMetadataClass.newLineage

                        # lineage - statement
                        if hLineage.has_key?('statement')
                            s = hLineage['statement']
                            if s != ''
                                intDataLine[:statement] = s
                            end
                        end

                        # lineage - process steps
                        if hLineage.has_key?('processStep')
                            aProcSteps = hLineage['processStep']
                            unless aProcSteps.empty?
                                aProcSteps.each do |hProcStep|
                                    intDataLine[:processSteps] << ProcessStep.unpack(hProcStep, responseObj)
                                end
                            end
                        end

                        # lineage - data sources
                        if hLineage.has_key?('source')
                            aSources = hLineage['source']
                            unless aSources.empty?
                                aSources.each do |hSource|
                                    intDataLine[:dataSources] << Source.unpack(hSource, responseObj)
                                end
                            end
                        end

                        return intDataLine
                    end

                end

            end
        end
    end
end
