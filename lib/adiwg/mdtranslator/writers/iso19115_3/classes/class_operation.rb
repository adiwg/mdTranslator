require_relative 'class_citation'
require_relative 'class_identifier'
require_relative 'class_objective'
require_relative 'class_plan'
require_relative 'class_platform'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_3

                class MI_Operation
                    def initialize(xml, hResponseObj)
                        @xml = xml
                        @hResponseObj = hResponseObj
                    end

                    def writeXML(hOperation)

                        codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                        citationClass = CI_Citation.new(@xml, @hResponseObj)
                        identifierClass = MD_Identifier.new(@xml, @hResponseObj)
                        objectiveClass = MI_Objective.new(@xml, @hResponseObj)
                        planClass = MI_Plan.new(@xml, @hResponseObj)
                        platformClass = MI_Platform.new(@xml, @hResponseObj)
                        operationClass = MI_Operation.new(@xml, @hResponseObj)

                        @xml.tag!('mac:MI_Operation', id: hOperation[:operationId]) do

                            unless hOperation[:description].nil?
                                @xml.tag!('mac:description') do
                                    @xml.tag!('gco:CharacterString', hOperation[:description])
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:description')
                                end
                            end

                            unless hOperation[:citation].empty?
                                @xml.tag!('mac:citation') do
                                    citationClass.writeXML(hOperation[:citation])
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:citation')
                                end
                            end

                            unless hOperation[:identifier].empty?
                                @xml.tag!('mac:identifier') do
                                    identifierClass.writeXML(hOperation[:identifier])
                                end
                            end

                            unless hOperation[:status].nil?
                                @xml.tag!('mac:status') do
                                    codelistClass.writeXML('mac', 'iso_progress', hOperation[:status])
                                end
                            end

                            unless hOperation[:operationType].nil?
                                @xml.tag!('mac:type') do
                                    codelistClass.writeXML('mac', 'iso_operationTypeCode', hOperation[:operationType])
                                end
                            end

                            unless hOperation[:platforms].empty?
                                hOperation[:platforms].each do |hPlatform|
                                    @xml.tag!('mac:platform') do
                                        platformClass.writeXML(hPlatform)
                                    end
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:platform')
                                end
                            end

                            unless hOperation[:childOperations].empty?
                                hOperation[:childOperations].each do |hChildOp|
                                    @xml.tag!('mac:childOperation') do
                                        operationClass.writeXML(hChildOp)
                                    end
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:childOperation')
                                end
                            end

                            unless hOperation[:objectives].empty?
                                hOperation[:objectives].each do |hObjective|
                                    @xml.tag!('mac:objective') do
                                        objectiveClass.writeXML(hObjective)
                                    end
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:objective')
                                end
                            end

                            unless hOperation[:parentOperation].empty?
                                @xml.tag!('mac:parentOperation') do
                                    operationClass.writeXML(hOperation[:parentOperation])
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:parentOperation')
                                end
                            end

                            unless hOperation[:plan].empty?
                                @xml.tag!('mac:plan') do
                                    planClass.writeXML(hOperation[:plan])
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:plan')
                                end
                            end

                        end
                    end
                end

            end
        end
    end
end
