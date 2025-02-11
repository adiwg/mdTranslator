require_relative 'html_citation'
require_relative 'html_locale'
require_relative 'html_constraint'
require_relative 'html_instrumentationEvent'

module ADIWG
    module Mdtranslator
        module Writers
            module Html
                class Html_InstrumentationEventList
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hInstrumentationEventList)
                        citationClass = Html_Citation.new(@html)
                        localeClass = Html_Locale.new(@html)
                        constraintClass = Html_Constraint.new(@html)
                        instrumentationEventClass = Html_InstrumentationEvent.new(@html)

                        # citation
                        unless hInstrumentationEventList[:citation].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Citation', {'class' => 'h4'})
                                    @html.section(:class => 'block') do
                                        citationClass.writeHtml(hInstrumentationEventList[:citation])
                                    end
                                end
                            end
                        end

                        # desctiption  
                        unless hInstrumentationEventList[:description].nil?
                            @html.em('Description: ')
                            @html.text!(hInstrumentationEventList[:description])
                            @html.br
                        end

                        # locale
                        unless hInstrumentationEventList[:locale].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Locale', {'class' => 'h4'})
                                    @html.section(:class => 'block') do
                                        localeClass.writeHtml(hInstrumentationEventList[:locale])
                                    end
                                end
                            end
                        end

                        # constraints
                        unless hInstrumentationEventList[:constraints].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Constraints', {'class' => 'h4'})
                                    hInstrumentationEventList[:constraints].each do |constraint|
                                        @html.section(:class => 'block') do
                                        @html.details do
                                            @html.summary('Constraint', {'class' => 'h5'})
                                                constraintClass.writeHtml(constraint)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        # instrumentationEvent
                        unless hInstrumentationEventList[:instrumentationEvents].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Instrumentation Events', {'class' => 'h4'})
                                    hInstrumentationEventList[:instrumentationEvents].each do |instrumentationEvent|
                                        @html.section(:class => 'block') do
                                        @html.details do
                                            @html.summary('Instrumentation Event', {'class' => 'h5'})
                                                instrumentationEventClass.writeHtml(instrumentationEvent)
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