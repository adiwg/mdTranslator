require_relative 'html_citation'
require_relative 'html_identifier'
require_relative 'html_responsibility'
require_relative 'html_requestedDate'
require_relative 'html_date'
require_relative 'html_plan'

module ADIWG
    module Mdtranslator
        module Writers
            module Html
                class Html_Requirement
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hRequirement)
                        citationClass = Html_Citation.new(@html)
                        identifierClass = Html_Identifier.new(@html)
                        responsibilityClass = Html_Responsibility.new(@html)
                        requestedDateClass = Html_RequestedDate.new(@html)
                        dateClass = Html_Date.new(@html)
                        planClass = Html_Plan.new(@html)

                        # requirementId
                        unless hRequirement[:requirementId].empty?
                            @html.em('Requirement ID', {'class' => 'h4'})
                            @html.section(:class => 'block') do
                                @html.text!(hRequirement[:requirementId])
                            end
                        end

                        # citation
                        unless hRequirement[:citation].empty?
                            @html.em('Citation: ')
                            @html.section(:class => 'block') do
                                citationClass.writeHtml(hRequirement[:citation])
                            end
                        end

                        # identifier
                        unless hRequirement[:identifier].empty?
                            @html.em('Identifier: ')
                            @html.section(:class => 'block') do
                                identifierClass.writeHtml(hRequirement[:identifier])
                            end
                        end

                        # requestor
                        unless hRequirement[:requestors].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Requestors', {'class' => 'h4'})
                                    hRequirement[:requestors].each do |requestor|
                                        @html.section(:class => 'block') do
                                        @html.details do
                                            @html.summary('Requestor', {'class' => 'h5'})
                                                operationClass.writeHtml(requestor)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        # recipient
                        unless hRequirement[:recipients].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Recipients', {'class' => 'h4'})
                                    hRequirement[:recipients].each do |recipient|
                                        @html.section(:class => 'block') do
                                        @html.details do
                                            @html.summary('Recipient', {'class' => 'h5'})
                                                operationClass.writeHtml(recipient)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        # priority
                        unless hRequirement[:priority].nil?
                            @html.em('Priority: ')
                            @html.section(:class => 'block') do
                                @html.text!(hRequirement[:priority])
                            end
                        end

                        # requested date
                        unless hRequirement[:requestedDate].empty?
                            @html.em('Requested Date: ')
                            @html.section(:class => 'block') do
                                requestedDateClass.writeHtml(hRequirement[:requestedDate])
                            end
                        end

                        # expiry date
                        unless hRequirement[:expiryDate].empty?
                            @html.em('Expiry Date: ')
                            @html.section(:class => 'block') do
                                @html.text!(hRequirement[:expiryDate])
                            end
                        end

                        # satisfied plan
                        unless hRequirement[:satisfiedPlans].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Satisfied Plans', {'class' => 'h4'})
                                    hRequirement[:satisfiedPlans].each do |plan|
                                        @html.section(:class => 'block') do
                                        @html.details do
                                            @html.summary('Plan', {'class' => 'h5'})
                                                planClass.writeHtml(plan)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                        
                    end # writeHtml
                end # Html_Requirement

            end
        end
    end
end