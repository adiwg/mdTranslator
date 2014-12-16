# ISO <<Class>> LI_Lineage
# writer output in XML

# History:
# 	Stan Smith 2013-11-20 original script
#   Stan Smith 2014-07-09 modify require statements to function in RubyGem structure
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers

require 'class_processStep'
require 'class_source'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class LI_Lineage

                    def initialize(xml)
                        @xml = xml
                    end

                    def writeXML(hLineage)

                        # classes used
                        sourceClass = $WriterNS::LI_Source.new(@xml)
                        pStepClass = $WriterNS::LI_ProcessStep.new(@xml)

                        @xml.tag!('gmd:LI_Lineage') do

                            # lineage - statement
                            s = hLineage[:statement]
                            if !s.nil?
                                @xml.tag!('gmd:statement') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif $showAllTags
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
                            elsif $showAllTags
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
                            elsif $showAllTags
                                @xml.tag!('gmd:source')
                            end

                        end

                    end

                end

            end
        end
    end
end
