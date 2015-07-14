# ISO <<Class>> LI_Lineage
# writer output in XML

# History:
# 	Stan Smith 2013-11-20 original script.
#   Stan Smith 2014-07-09 modify require statements to function in RubyGem structure
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS

require_relative 'class_processStep'
require_relative 'class_source'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class LI_Lineage

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hLineage)

                        # classes used
                        sourceClass =  LI_Source.new(@xml, @responseObj)
                        pStepClass =  LI_ProcessStep.new(@xml, @responseObj)

                        @xml.tag!('gmd:LI_Lineage') do

                            # lineage - statement
                            s = hLineage[:statement]
                            if !s.nil?
                                @xml.tag!('gmd:statement') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:statement')
                            end

                            # lineage - processing steps
                            aProcSteps = hLineage[:processSteps]
                            if !aProcSteps.empty?
                                aProcSteps.each do |pStep|
                                    @xml.tag!('gmd:processStep') do
                                        pStepClass.writeXML(pStep)
                                    end
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:processStep')
                            end

                            # lineage - data sources
                            aSources = hLineage[:dataSources]
                            if !aSources.empty?
                                aSources.each do |hSource|
                                    @xml.tag!('gmd:source') do
                                        sourceClass.writeXML(hSource)
                                    end
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:source')
                            end

                        end

                    end

                end

            end
        end
    end
end
