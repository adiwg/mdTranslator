require_relative 'html_identifier'
require_relative 'html_extent'
require_relative 'html_event'

module ADIWG
    module Mdtranslator
        module Writers
            module Html
                class Html_Pass
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hPass)
                        identifierClass = Html_Identifier.new(@html)
                        extentClass = Html_Extent.new(@html)
                        eventClass = Html_Event.new(@html)

                        # passId
                        unless hPass[:passId].empty?
                            @html.em('Pass ID', {'class' => 'h4'})
                            @html.section(:class => 'block') do
                                @html.text!(hPass[:passId])
                            end
                        end

                        # identifier
                        unless hPass[:identifier].empty?
                            @html.em('Identifier: ')
                            @html.section(:class => 'block') do
                                identifierClass.writeHtml(hPass[:identifier])
                            end
                        end

                        # extent
                        unless hPass[:extent].empty?
                            @html.em('Extent: ')
                            @html.section(:class => 'block') do
                                extentClass.writeHtml(hPass[:extent])
                            end
                        end

                        # relatedEvent
                        unless hPass[:relatedEvents].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Related Event', {'class' => 'h4'})
                                    hPass[:relatedEvents].each do |event|
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
                end # Html_Pass
            end
        end
    end
end