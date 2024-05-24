require_relative 'html_pass'
require_relative 'html_instrument'
require_relative 'html_extent'
require_relative 'html_identifier'

module ADIWG
    module Mdtranslator
        module Writers
            module Html
                class Html_Event
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hEvent)
                        passClass = Html_Pass.new(@html)
                        instrumentClass = Html_Instrument.new(@html)
                        extentClass = Html_Extent.new(@html)
                        identifierClass = Html_Identifier.new(@html)

                        # eventId
                        unless hEvent[:eventId].nil?
                            @html.em('Event ID: ')
                            @html.text!(hEvent[:eventId])
                            @html.br
                        end
                        
                        # identifier
                        unless hEvent[:identifier].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Identifier', {'class' => 'h4'})
                                    @html.section(:class => 'block') do
                                        identifierClass.writeHtml(hEvent[:identifier])
                                    end
                                end
                            end
                        end

                        # trigger
                        unless hEvent[:trigger].nil?
                            @html.em('Trigger: ')
                            @html.text!(hEvent[:trigger])
                            @html.br
                        end

                        # context
                        unless hEvent[:context].nil?
                            @html.em('Context: ')
                            @html.text!(hEvent[:context])
                            @html.br
                        end

                        # sequence
                        unless hEvent[:sequence].nil?
                            @html.em('Sequence: ')
                            @html.text!(hEvent[:sequence])
                            @html.br
                        end

                        # time
                        unless hEvent[:dateTime].nil? || hEvent[:dateTime].empty?
                            @html.em('Datetime: ')
                            @html.section(:class => 'block') do
                                @html.text!.writeHtml(hEvent[:dateTime][:dateTime].to_s)
                            end
                        end

                        # expectedObjective
                        unless hEvent[:expectedObjectives].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Expected Objective', {'class' => 'h4'})
                                    hEvent[:expectedObjectives].each do |objective|
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

                        # relatedPass
                        unless hEvent[:relatedPass].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Related Pass', {'class' => 'h4'})
                                    @html.section(:class => 'block') do
                                        passClass.writeHtml(hEvent[:relatedPass])
                                    end
                                end
                            end
                        end

                        #relatedSensor
                        unless hEvent[:relatedSensors].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Related Sensors', {'class' => 'h4'})
                                    hEvent[:relatedSensors].each do |instrument|
                                        @html.section(:class => 'block') do
                                        @html.details do
                                            @html.summary('Instrument', {'class' => 'h5'})
                                                instrumentClass.writeHtml(instrument)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                    end # writeHtml
                end # Html_Event

            end
        end
    end
end