require_relative 'class_citation'
require_relative 'class_operation'
require_relative 'class_requirement'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_3

                class MI_Plan
                    def initialize(xml, hResponseObj)
                        @xml = xml
                        @hResponseObj = hResponseObj
                    end

                    def writeXML(hPlan)

                        codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                        citationClass = CI_Citation.new(@xml, @hResponseObj)
                        operationClass = MI_Operation.new(@xml, @hResponseObj)
                        requirementClass = MI_Requirement.new(@xml, @hResponseObj)

                        @xml.tag!('mac:MI_Plan', id: hPlan[:planId]) do
                            unless hPlan[:planType].nil?
                                @xml.tag!('mac:type') do
                                    codelistClass.writeXML('mac', 'iso_geometryTypeCode', hPlan[:planType])
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:type')
                                end
                            end

                            unless hPlan[:status].nil?
                                @xml.tag!('mac:status') do
                                    codelistClass.writeXML('mac', 'iso_progress', hPlan[:status])
                                end
                            end

                            unless hPlan[:citation].empty?
                                @xml.tag!('mac:citation') do
                                    citationClass.writeXML(hPlan[:citation])
                                end
                            end

                            unless hPlan[:planOperations].empty?
                                hPlan[:planOperations].each do |hOperation|
                                    @xml.tag!('mac:operation') do
                                        operationClass.writeXML(hOperation)
                                    end
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:operation')
                                end
                            end

                            unless hPlan[:satisfiedRequirements].empty?
                                hPlan[:satisfiedRequirements].each do |hRequirement|
                                    @xml.tag!('mac:satisfiedRequirement') do
                                        requirementClass.writeXML(hRequirement)
                                    end
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:satisfiedRequirement')
                                end
                            end
                        end

                    end
                end
            end
        end
    end
end
