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
                        planClass = Html_Plan.new(@html)
                    
                        # planId
                        unless hPlan[:planId].empty?
                            @html.em('Plan ID: ')
                            @html.text!(hPlan[:planId])
                            @html.br
                        end

                        # planType
                        unless hPlan[:planType].empty?
                            @html.em('Type: ')
                            @html.text!(hPlan[:planType])
                            @html.br
                        end

                        # status
                        unless hPlan[:status].empty?
                            @html.em('Status: ')
                            @html.text!(hPlan[:status])
                            @html.br
                        end

                        # citation
                        unless hPlan[:citation].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Citation', {'class' => 'h4'})
                                    @html.section(:class => 'block') do
                                        citationClass.writeHtml(hPlan[:citation])
                                    end
                                end
                            end
                        end

                        # planOperation
                        unless hPlan[:planOperations].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Operations', {'class' => 'h4'})
                                    hPlan[:planOperations].each do |operation|
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

                        # satisfiedRequirement
                        unless hPlan[:satisfiedRequirements].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Requirements', {'class' => 'h4'})
                                    hPlan[:satisfiedRequirements].each do |requirement|
                                        @html.section(:class => 'block') do
                                        @html.details do
                                            @html.summary('Requirement', {'class' => 'h5'})
                                                requirementClass.writeHtml(requirement)
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
