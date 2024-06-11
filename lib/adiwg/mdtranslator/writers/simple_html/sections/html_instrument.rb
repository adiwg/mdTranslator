require_relative 'html_identifier'
require_relative 'html_platform'
require_relative 'html_instrumentationEventList'

module ADIWG
    module Mdtranslator
        module Writers
            module Simple_html
                class Html_Instrument
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hInstrument)
                        identifierClass = Html_Identifier.new(@html)
                        platformClass = Html_Platform.new(@html)
                        instrumentationEventListClass = Html_InstrumentationEventList.new(@html)

                        # instrumentId
                        unless hInstrument[:instrumentId].nil?
                            @html.em('Instrument ID: ')
                            @html.text!(hInstrument[:instrumentId])
                            @html.br
                        end

                        # identifier
                        unless hInstrument[:identifier].empty?
                            @html.div(:class => 'block') do
                                @html.div do
                                    @html.summary('Identifier', {'class' => 'h4'})
                                    @html.div(:class => 'block') do
                                        identifierClass.writeHtml(hInstrument[:identifier])
                                    end
                                end
                            end
                        end

                        # instrumentType
                        unless hInstrument[:instrumentType].nil?
                            @html.em('Instrument Type: ')
                            @html.text!(hInstrument[:instrumentType])
                            @html.br
                        end

                        # description
                        unless hInstrument[:description].nil?
                            @html.em('Description: ')
                            @html.text!(hInstrument[:description])
                            @html.br
                        end

                        # mountedOn
                        unless hInstrument[:mountedOn].empty?
                            @html.div(:class => 'block') do
                                @html.div do
                                    @html.summary('Mounted On', {'class' => 'h4'})
                                    @html.div(:class => 'block') do
                                        platformClass.writeHtml(hInstrument[:mountedOn])
                                    end
                                end
                            end
                        end

                        # history
                        unless hInstrument[:histories].empty?
                            @html.div(:class => 'block') do
                                @html.div do
                                    @html.summary('Histories', {'class' => 'h4'})
                                    hInstrument[:histories].each do |instrumentationEventList|
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

                        # hostId
                        unless hInstrument[:hostId].empty?
                            @html.div(:class => 'block') do
                                @html.div do
                                    @html.summary('Host ID', {'class' => 'h4'})
                                    @html.div(:class => 'block') do
                                        identifierClass.writeHtml(hInstrument[:hostId])
                                    end
                                end
                            end
                        end

                    end # writeHtml
                end # Html_Instrument
            end
        end
    end
end