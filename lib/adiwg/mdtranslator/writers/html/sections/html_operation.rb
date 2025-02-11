require_relative 'html_citation'
require_relative 'html_identifier'
require_relative 'html_objective'
require_relative 'html_operation'
require_relative 'html_plan'
require_relative 'html_platform'
require_relative 'html_event'

module ADIWG
    module Mdtranslator
        module Writers
            module Html
                class Html_Operation
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hOperation)
                        citationClass = Html_Citation.new(@html)
                        identifierClass = Html_Identifier.new(@html)
                        objectiveClass = Html_Objective.new(@html)
                        operationClass = Html_Operation.new(@html)
                        planClass = Html_Plan.new(@html)
                        platformClass = Html_Platform.new(@html)
                        eventClass = Html_Event.new(@html)


                        # operationId
                        unless hOperation[:operationId].nil?
                            @html.em('Operation ID: ')
                            @html.text!(hOperation[:operationId])
                            @html.br
                        end

                        # description
                        unless hOperation[:description].nil?
                            @html.em('Description: ')
                            @html.text!(hOperation[:description])
                            @html.br
                        end

                        # citation
                        unless hOperation[:citation].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Citation', {'class' => 'h4'})
                                    @html.section(:class => 'block') do
                                        citationClass.writeHtml(hOperation[:citation])
                                    end
                                end
                            end
                        end

                        # identifier
                        unless hOperation[:identifier].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Identifier', {'class' => 'h4'})
                                    @html.section(:class => 'block') do
                                        identifierClass.writeHtml(hOperation[:identifier])
                                    end
                                end
                            end
                        end

                        # status
                        unless hOperation[:status].nil?
                            @html.em('Status: ')
                            @html.text!(hOperation[:status])
                            @html.br
                        end

                        # operationType
                        unless hOperation[:operationType].nil?
                            @html.em('Operation Type: ')
                            @html.text!(hOperation[:operationType])
                            @html.br
                        end

                        # objective
                        unless hOperation[:objectives].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Objectives', {'class' => 'h4'})
                                    hOperation[:objectives].each do |objective|
                                        @html.section(:class => 'block') do
                                        @html.details do
                                            @html.summary('Objective', {'class' => 'h5'})
                                                objectiveClass.writeHtml(objective)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        # parentOperation
                        unless hOperation[:parentOperation].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Parent Operation', {'class' => 'h4'})
                                    @html.section(:class => 'block') do
                                        operationClass.writeHtml(hOperation[:parentOperation])
                                    end
                                end
                            end
                        end

                        # childOperation
                        unless hOperation[:childOperations].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Child Operations', {'class' => 'h4'})
                                    hOperation[:childOperations].each do |operation|
                                        @html.section(:class => 'block') do
                                        @html.details do
                                            @html.summary('Operation', {'class' => 'h5'})
                                                operationClass.writeHtml(operation)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        # plan
                        unless hOperation[:plan].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Plan', {'class' => 'h4'})
                                    @html.section(:class => 'block') do
                                        planClass.writeHtml(hOperation[:plan])
                                    end
                                end
                            end
                        end

                        # platform
                        unless hOperation[:platforms].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Platforms', {'class' => 'h4'})
                                    hOperation[:platforms].each do |platform|
                                        @html.section(:class => 'block') do
                                        @html.details do
                                            @html.summary('Platform', {'class' => 'h5'})
                                                platformClass.writeHtml(platform)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        # significantEvent
                        unless hOperation[:significantEvents].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Significant Events', {'class' => 'h4'})
                                    hOperation[:significantEvents].each do |event|
                                        @html.section(:class => 'block') do
                                        @html.details do
                                            @html.summary('Event', {'class' => 'h5'})
                                                eventClass.writeHtml(event)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                    end # writeHtml

                end # Html_Operation
            end
        end
    end
end