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
                        unless hEvent[:eventId].empty?
                            @html.em('Event ID', {'class' => 'h4'})
                            @html.section(:class => 'block') do
                                @html.text!(hEvent[:eventId])
                            end
                        end
                        
                        # identifier
                        unless hEvent[:identifier].empty?
                            @html.em('Identifier: ')
                            @html.section(:class => 'block') do
                                identifierClass.writeHtml(hEvent[:identifier])
                            end
                        end

                        # trigger
                        unless hEvent[:eventId].empty?
                            @html.em('Event ID', {'class' => 'h4'})
                            @html.section(:class => 'block') do
                                @html.text!(hEvent[:eventId])
                            end
                        end

                        # context
                        unless hEvent[:eventId].empty?
                            @html.em('Event ID', {'class' => 'h4'})
                            @html.section(:class => 'block') do
                                @html.text!(hEvent[:eventId])
                            end
                        end

                        # sequence
                        unless hEvent[:eventId].empty?
                            @html.em('Event ID', {'class' => 'h4'})
                            @html.section(:class => 'block') do
                                @html.text!(hEvent[:eventId])
                            end
                        end

                        # time
                        unless hEvent[:identifier].empty?
                            @html.em('Identifier: ')
                            @html.section(:class => 'block') do
                                dateClass.writeHtml(hEvent[:identifier])
                            end
                        end

                        # expectedObjective
                        unless hEvent[:extents].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Expected Objective', {'class' => 'h4'})
                                    hEvent[:extents].each do |objective|
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
                            @html.em('Related Pass: ')
                            @html.section(:class => 'block') do
                                passClass.writeHtml(hEvent[:relatedPass])
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