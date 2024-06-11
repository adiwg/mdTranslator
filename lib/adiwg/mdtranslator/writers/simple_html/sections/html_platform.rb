require_relative 'html_identifier'
require_relative 'html_citation'
require_relative 'html_responsibility'
require_relative 'html_instrument'
require_relative 'html_instrumentationEventList'

module ADIWG
    module Mdtranslator
        module Writers
            module Simple_html
                class Html_Platform
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hPlatform)
                        identifierClass = Html_Identifier.new(@html)
                        citationClass = Html_Citation.new(@html)
                        responsibilityClass = Html_Responsibility.new(@html)
                        instrumentClass = Html_Instrument.new(@html)
                        instrumentationEventListClass = Html_InstrumentationEventList.new(@html)

                        # platformId
                        unless hPlatform[:platformId].nil?
                            @html.em('Platform ID: ')
                            @html.text!(hPlatform[:platformId])
                            @html.br
                        end

                        # citation
                        unless hPlatform[:citation].empty?
                            @html.div(:class => 'block') do
                                @html.div do
                                    @html.summary('Citation', {'class' => 'h4'})
                                    @html.div(:class => 'block') do
                                        citationClass.writeHtml(hPlatform[:citation])
                                    end
                                end
                            end
                        end

                        # identifier
                        unless hPlatform[:identifier].empty?
                            @html.div(:class => 'block') do
                                @html.div do
                                    @html.summary('Identifier', {'class' => 'h4'})
                                    @html.div(:class => 'block') do
                                        identifierClass.writeHtml(hPlatform[:identifier])
                                    end
                                end
                            end
                        end

                        # description
                        unless hPlatform[:description].nil?
                            @html.em('Description: ')
                            @html.text!(hPlatform[:description])
                            @html.br
                        end

                        # sponsor
                        unless hPlatform[:sponsors].empty?
                            @html.div(:class => 'block') do
                                @html.div do
                                    @html.summary('Sponsors', {'class' => 'h4'})
                                    hPlatform[:sponsors].each do |responsibility|
                                        @html.div(:class => 'block') do
                                        @html.div do
                                            @html.summary('Responsibility', {'class' => 'h5'})
                                                responsibilityClass.writeHtml(responsibility)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        # instrument
                        unless hPlatform[:instruments].empty?
                            @html.div(:class => 'block') do
                                @html.div do
                                    @html.summary('Instruments', {'class' => 'h4'})
                                    hPlatform[:instruments].each do |instrument|
                                        @html.div(:class => 'block') do
                                        @html.div do
                                            @html.summary('Instrument', {'class' => 'h5'})
                                                instrumentClass.writeHtml(instrument)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        # history
                        unless hPlatform[:history].empty?
                            @html.div(:class => 'block') do
                                @html.div do
                                    @html.summary('History', {'class' => 'h4'})
                                    hPlatform[:history].each do |instrumentationEventList|
                                        @html.div(:class => 'block') do
                                        @html.div do
                                            @html.summary('Instrumentation Event List', {'class' => 'h5'})
                                                instrumentationEventListClass.writeHtml(instrumentationEventList)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                        
                    end
                end
            end
        end
    end
end