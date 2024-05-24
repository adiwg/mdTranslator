require_relative 'html_identifier'
require_relative 'html_platform'
require_relative 'html_instrumentationEventList'

module ADIWG
    module Mdtranslator
        module Writers
            module Html
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
                            @html.em('Instrument ID', {'class' => 'h4'})
                            @html.section(:class => 'block') do
                                @html.text!(hInstrument[:instrumentId])
                            end
                        end

                        # identifier
                        unless hInstrument[:identifier].empty?
                            @html.em('Identifier: ')
                            @html.section(:class => 'block') do
                                identifierClass.writeHtml(hInstrument[:identifier])
                            end
                        end

                        # instrumentType
                        unless hInstrument[:instrumentType].nil?
                            @html.em('Instrument Type', {'class' => 'h4'})
                            @html.section(:class => 'block') do
                                @html.text!(hInstrument[:instrumentType])
                            end
                        end

                        # description
                        unless hInstrument[:description].nil?
                            @html.em('Description', {'class' => 'h4'})
                            @html.section(:class => 'block') do
                                @html.text!(hInstrument[:description])
                            end
                        end

                        # mountedOn
                        unless hInstrument[:mountedOn].empty?
                            @html.em('Mounted On', {'class' => 'h4'})
                            @html.section(:class => 'block') do
                                platformClass.writeHtml(hInstrument[:mountedOn])
                            end
                        end

                        # history
                        unless hInstrument[:histories].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Histories', {'class' => 'h4'})
                                    hInstrument[:histories].each do |instrumentationEventList|
                                        @html.section(:class => 'block') do
                                        @html.details do
                                            @html.summary('Instrumentation Event List', {'class' => 'h5'})
                                                instrumentationEventListClass.writeHtml(instrumentationEventList)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                        # hostId
                    end # writeHtml
                end # Html_Instrument
            end
        end
    end
end