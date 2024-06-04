require_relative 'class_citation'
require_relative 'class_identifier'
require_relative 'class_responsibility'
require_relative 'class_codelist'
require_relative 'class_requestedDate'
require_relative 'class_gcoDateTime'
require_relative 'class_plan'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_3

                class MI_Requirement
                    def initialize(xml, hResponseObj)
                        @xml = xml
                        @hResponseObj = hResponseObj
                    end

                    def writeXML(hRequirement)

                        citationClass = CI_Citation.new(@xml, @hResponseObj)
                        identifierClass = MD_Identifier.new(@xml, @hResponseObj)
                        responsibilityClass = CI_Responsibility.new(@xml, @hResponseObj)
                        codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                        requestedDateClass = MI_RequestedDate.new(@xml, @hResponseObj)
                        gcoDateTimeClass = GcoDateTime.new(@xml, @hResponseObj)
                        planClass = MI_Plan.new(@xml, @hResponseObj)

                        unless hRequirement[:citation].empty?
                            @xml.tag!('mac:citation') do
                                citationClass.writeXML(hRequirement[:citation])
                            end
                        else
                            if @hResponseObj[:writerShowTags]
                                @xml.tag!('mac:citation')
                            end
                        end

                        unless hRequirement[:identifier].empty?
                            @xml.tag!('mac:identifier') do
                                identifierClass.writeXML(hRequirement[:identifier])
                            end
                        else
                            if @hResponseObj[:writerShowTags]
                                @xml.tag!('mac:identifier')
                            end
                        end

                        unless hRequirement[:requestors].empty?
                            hRequirement[:requestors].each do |hResponsibility|
                                @xml.tag!('mac:request') do
                                    responsibilityClass.writeXML(hResponsibility)
                                end
                            end
                        end

                        unless hRequirement[:recipients].empty?
                            hRequirement[:recipients].each do |hResponsibility|
                                @xml.tag!('mac:recipient') do
                                    responsibilityClass.writeXML(hResponsibility)
                                end
                            end
                        end

                        unless hRequirement[:priority].nil?
                            @xml.tag!('mac:priority') do
                                codelistClass.writeXML('mcc', 'iso_priorityCode', hRequirement[:priority])
                            end
                        end

                        unless hRequirement[:requestedDate].nil?
                            @xml.tag!('mac:requestedDate') do
                                requestedDateClass.writeXML(hRequirement[:requestedDate])
                            end
                        else
                            if @hResponseObj[:writerShowTags]
                                @xml.tag!('mac:requestedDate')
                            end
                        end

                        # unless hRequirement[:expiryDate].nil?
                        #     @xml.tag!('mac:expiryDate') do
                        #         gcoDateTimeClass.writeXML(hRequirement[:expiryDate])
                        #     end
                        # else
                        #     if @hResponseObj[:writerShowTags]
                        #         @xml.tag!('mac:expiryDate')
                        #     end
                        # end

                        unless hRequirement[:satisfiedPlans].empty?
                            hRequirement[:satisfiedPlans].each do |hPlan|
                                @xml.tag!('mac:satisifiedPlan') do
                                    planClass.writeXML(hPlan)
                                end
                            end
                        else
                            if @hResponseObj[:writerShowTags]
                                @xml.tag!('mac:satisifiedPlan')
                            end
                        end
                    end
                end

            end
        end
    end
end
