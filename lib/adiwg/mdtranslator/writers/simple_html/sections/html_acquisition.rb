require_relative 'html_scope'
require_relative 'html_plan'
require_relative 'html_requirement'
require_relative 'html_objective'
require_relative 'html_platform'
require_relative 'html_instrument'
require_relative 'html_operation'
require_relative 'html_event'
require_relative 'html_pass'
require_relative 'html_environment'

module ADIWG
    module Mdtranslator
        module Writers
            module Html
                class Html_Acquisition
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hAcquisition)
                        scopeClass = Html_Scope.new(@html)
                        planClass = Html_Plan.new(@html)
                        requirementClass = Html_Requirement.new(@html)
                        objectiveClass = Html_Objective.new(@html)
                        platformClass = Html_Platform.new(@html)
                        instrumentClass = Html_Instrument.new(@html)
                        operationClass = Html_Operation.new(@html)
                        eventClass = Html_Event.new(@html)
                        passClass = Html_Pass.new(@html)
                        environmentClass = Html_Environment.new(@html)

                        # scope
                        unless hAcquisition[:scope].empty?
                            @html.div do
                                @html.h5('Scope', {'class' => 'h5'})
                                @html.div(:class => 'block') do
                                scopeClass.writeHtml(hDataQuality[:scope])
                                end
                            end
                        end

                        # plan
                        unless hAcquisition[:plans].empty?
                            @html.div(:class =>'block') do
                                @html.div do
                                    @html.h4('Plans', {'class' => 'h4'})
                                    hAcquisition[:plans].each do |plan|
                                        @html.div(:class =>'block') do
                                            @html.div do
                                                @html.h5('Plan', {'class' => 'h5'})
                                                planClass.writeHtml(plan)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        # requirement
                        unless hAcquisition[:requirements].empty?
                            @html.div(:class =>'block') do
                                @html.div do
                                    @html.h4('Requirements', {'class' => 'h4'})
                                    hAcquisition[:requirements].each do |requirement|
                                        @html.div(:class =>'block') do
                                            @html.div do
                                                @html.h5('Requirement', {'class' => 'h5'})
                                                requirementClass.writeHtml(requirement)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        # objective
                        unless hAcquisition[:objectives].empty?
                            @html.div(:class =>'block') do
                                @html.div do
                                    @html.h4('Objectives', {'class' => 'h4'})
                                    hAcquisition[:objectives].each do |objective|
                                        @html.div(:class =>'block') do
                                            @html.div do
                                                @html.h5('Objective', {'class' => 'h5'})
                                                objectiveClass.writeHtml(objective)
                                            end
                                        end
                                    end
                                end
                            end
                        end


                        # platform
                        unless hAcquisition[:platforms].empty?
                            @html.div(:class =>'block') do
                                @html.div do
                                    @html.h4('Platforms', {'class' => 'h4'})
                                    hAcquisition[:platforms].each do |platform|
                                        @html.div(:class =>'block') do
                                            @html.div do
                                                @html.h5('Platform', {'class' => 'h5'})
                                                platformClass.writeHtml(platform)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        # Instrument
                        unless hAcquisition[:instruments].empty?
                            @html.div(:class =>'block') do
                                @html.div do
                                    @html.h4('Instrument', {'class' => 'h4'})
                                    hAcquisition[:instruments].each do |instrument|
                                        @html.div(:class =>'block') do
                                            @html.div do
                                                @html.h5('Instrument', {'class' => 'h5'})
                                                instrumentClass.writeHtml(instrument)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        # operation
                        unless hAcquisition[:operations].empty?
                            @html.div(:class =>'block') do
                                @html.div do
                                    @html.h4('Operations', {'class' => 'h4'})
                                    hAcquisition[:operations].each do |operations|
                                        @html.div(:class =>'block') do
                                            @html.div do
                                                @html.h5('Operation', {'class' => 'h5'})
                                                operationClass.writeHtml(operations)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        # Event
                        unless hAcquisition[:events].empty?
                            @html.div(:class =>'block') do
                                @html.div do
                                    @html.h4('Events', {'class' => 'h4'})
                                    hAcquisition[:events].each do |event|
                                        @html.div(:class =>'block') do
                                            @html.div do
                                                @html.h5('Event', {'class' => 'h5'})
                                                eventClass.writeHtml(event)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        # Pass
                        unless hAcquisition[:passes].empty?
                            @html.div(:class =>'block') do
                                @html.div do
                                    @html.h4('Passes', {'class' => 'h4'})
                                    hAcquisition[:passes].each do |pass|
                                        @html.div(:class =>'block') do
                                            @html.div do
                                                @html.h5('Pass', {'class' => 'h5'})
                                                passClass.writeHtml(pass)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        # Environment
                        unless hAcquisition[:environment].empty?
                            @html.div do
                                @html.h5('Scope', {'class' => 'h5'})
                                @html.div(:class => 'block') do
                                environmentClass.writeHtml(hAcquisition[:environment])
                                end
                            end
                        end

                    end
                end
            end
        end
    end
end
