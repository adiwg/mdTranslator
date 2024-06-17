require_relative 'html_citation'
require_relative 'html_identifier'
require_relative 'html_responsibility'
require_relative 'html_requestedDate'
require_relative 'html_date'
require_relative 'html_plan'

module ADIWG
    module Mdtranslator
        module Writers
            module Simple_html
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
                        unless hRequirement[:requirementId].nil?
                            @html.em('Requirement ID: ')
                            @html.text!(hRequirement[:requirementId])
                            @html.br
                        end

                        # citation
                        unless hRequirement[:citation].empty?
                            @html.div(:class => 'block') do
                                @html.div do
                                    @html.summary('Citation', {'class' => 'h4'})
                                    @html.div(:class => 'block') do
                                        citationClass.writeHtml(hRequirement[:citation])
                                    end
                                end
                            end
                        end

                        # identifier
                        unless hRequirement[:identifier].empty?
                            @html.div(:class => 'block') do
                                @html.div do
                                    @html.summary('Identifier ', {'class' => 'h4'})
                                    @html.div(:class => 'block') do
                                        identifierClass.writeHtml(hRequirement[:identifier])
                                    end
                                end
                            end
                        end

                        # requestor
                        unless hRequirement[:requestors].empty?
                            @html.div(:class => 'block') do
                                @html.div do
                                    @html.summary('Requestors', {'class' => 'h4'})
                                    hRequirement[:requestors].each do |requestor|
                                        @html.div(:class => 'block') do
                                        @html.div do
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
                            @html.div(:class => 'block') do
                                @html.div do
                                    @html.summary('Recipients', {'class' => 'h4'})
                                    hRequirement[:recipients].each do |recipient|
                                        @html.div(:class => 'block') do
                                        @html.div do
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
                            @html.text!(hRequirement[:priority])
                            @html.br
                        end

                        # requested date
                        unless hRequirement[:requestedDate].empty?
                            @html.div(:class => 'block') do
                                @html.div do
                                    @html.summary('Requested Date ', {'class' => 'h4'})
                                    @html.div(:class => 'block') do
                                        requestedDateClass.writeHtml(hRequirement[:requestedDate])
                                    end
                                end
                            end
                        end

                        # expiry date
                        unless hRequirement[:expiryDate].nil?
                            @html.em('Expiry Date: ')
                            @html.text!(hRequirement[:expiryDate])
                            @html.br
                        end

                        # satisfied plan
                        unless hRequirement[:satisfiedPlans].empty?
                            @html.div(:class => 'block') do
                                @html.div do
                                    @html.summary('Satisfied Plans', {'class' => 'h4'})
                                    hRequirement[:satisfiedPlans].each do |plan|
                                        @html.div(:class => 'block') do
                                        @html.div do
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