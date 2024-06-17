require_relative 'html_citation'
require_relative 'html_locale'
require_relative 'html_constraint'
require_relative 'html_instrumentationEvent'

module ADIWG
    module Mdtranslator
        module Writers
            module Simple_html
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
                            @html.div(:class => 'block') do
                                @html.div do
                                    @html.summary('Citation', {'class' => 'h4'})
                                    @html.div(:class => 'block') do
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
                            @html.div(:class => 'block') do
                                @html.div do
                                    @html.summary('Locale', {'class' => 'h4'})
                                    @html.div(:class => 'block') do
                                        localeClass.writeHtml(hInstrumentationEventList[:locale])
                                    end
                                end
                            end
                        end

                        # constraints
                        unless hInstrumentationEventList[:constraints].empty?
                            @html.div(:class => 'block') do
                                @html.div do
                                    @html.summary('Constraints', {'class' => 'h4'})
                                    hInstrumentationEventList[:constraints].each do |constraint|
                                        @html.div(:class => 'block') do
                                        @html.div do
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
                            @html.div(:class => 'block') do
                                @html.div do
                                    @html.summary('Instrumentation Events', {'class' => 'h4'})
                                    hInstrumentationEventList[:instrumentationEvents].each do |instrumentationEvent|
                                        @html.div(:class => 'block') do
                                        @html.div do
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