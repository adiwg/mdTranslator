require_relative 'html_citation'
require_relative 'html_operation'
require_relative 'html_requirement'

module ADIWG
    module Mdtranslator
        module Writers
            module Html
                class Html_Plan
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hPlan)
                        citationClass = Html_Citation.new(@html)
                        operationClass = Html_Operation.new(@html)
                        requirementClass = Html_Requirement.new(@html)
                    
                        # planId
                        unless hPlan[:planId].empty?
                            @html.em('Scope', {'class' => 'h4'})
                            @html.section(:class => 'block') do
                                @html.text!(hPlan[:planId])
                            end
                        end

                        # planType
                        unless hPlan[:planType].empty?
                            @html.em('Type', {'class' => 'h4'})
                            @html.section(:class => 'block') do
                                @html.text!(hPlan[:planType])
                            end
                        end

                        # status
                        unless hPlan[:status].empty?
                            @html.em('Status', {'class' => 'h4'})
                            @html.section(:class => 'block') do
                                @html.text!(hPlan[:status])
                            end
                        end

                        # citation
                        unless hAcquisition[:citation].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Citation', {'class' => 'h4'})
                                    @html.section(:class => 'block') do
                                        citationClass.writeHtml(hAcquisition[:citation])
                                    end
                                end
                            end
                        end

                        # planOperation
                        unless hPlan[:planOperations].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Plans', {'class' => 'h4'})
                                    hPlan[:planOperations].each do |operation|
                                        @html.section(:class => 'block') do
                                        @html.details do
                                            @html.summary('Plan', {'class' => 'h5'})
                                                operationClass.writeHtml(operation)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        # satisfiedRequirement
                        unless hPlan[:satisfiedRequirements].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Plans', {'class' => 'h4'})
                                    hPlan[:satisfiedRequirements].each do |requirement|
                                        @html.section(:class => 'block') do
                                        @html.details do
                                            @html.summary('Plan', {'class' => 'h5'})
                                                planClass.writeHtml(requirement)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                    end # writeHtml

                end # Html_Plan
            end
        end
    end
end
