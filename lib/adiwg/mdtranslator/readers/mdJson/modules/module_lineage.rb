# unpack resource lineage
# Reader - ADIwg JSON V1 to internal data structure

# History:
#   Stan Smith 2016-10-17 refactored for mdJson 2.0
#   Stan Smith 2015-07-14 refactored to remove global namespace constants
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2014-07-03 resolve require statements using Mdtranslator.reader_module
# 	Stan Smith 2013-11-26 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_scope')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_citation')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_processStep')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_source')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module ResourceLineage

                    def self.unpack(hLineage, responseObj)

                        # return nil object if input is empty
                        if hLineage.empty?
                            responseObj[:readerExecutionMessages] << 'Resource Lineage object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intLineage = intMetadataClass.newLineage

                        # lineage - statement
                        if hLineage.has_key?('statement')
                            if hLineage['statement'] != ''
                                intLineage[:statement] = hLineage['statement']
                            end
                        end

                        # lineage - resource scope
                        if hLineage.has_key?('resourceScope')
                            hScope = hLineage['resourceScope']
                            unless hScope.empty?
                                intLineage[:resourceScope] = Scope.unpack(hScope, responseObj)
                            end
                        end

                        # lineage - citation []
                        if hLineage.has_key?('lineageCitation')
                            aCitation = hLineage['lineageCitation']
                            aCitation.each do |item|
                                hCitation = Citation.unpack(item, responseObj)
                                unless hCitation.nil?
                                    intLineage[:lineageCitation] << hCitation
                                end
                            end
                        end

                        # lineage - sources []
                        if hLineage.has_key?('source')
                            aSource = hLineage['source']
                            aSource.each do |item|
                                hSource = Source.unpack(item, responseObj)
                                unless hSource.nil?
                                    intLineage[:dataSources] << hSource
                                end
                            end
                        end

                        # lineage - process steps []
                        if hLineage.has_key?('processStep')
                            aSteps = hLineage['processStep']
                            aSteps.each do |item|
                                hSteps = ProcessStep.unpack(item, responseObj)
                                unless hSteps.nil?
                                    intLineage[:processSteps] << hSteps
                                end
                            end
                        end

                        if intLineage[:statement].nil? &&
                            intLineage[:dataSources].empty? &&
                            intLineage[:processSteps].empty?
                            responseObj[:readerExecutionMessages] << 'Resource Lineage must have at least one statement, processStep, or ssource'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        return intLineage
                    end

                end

            end
        end
    end
end
