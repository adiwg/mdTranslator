require_relative 'html_citation'
require_relative 'html_extent'
require_relative 'html_revision'

module ADIWG
    module Mdtranslator
        module Writers
            module Simple_html
                class Html_InstrumentationEvent
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hInstrumentationEvent)
                        citationClass = Html_Citation.new(@html)
                        extentClass = Html_Extent.new(@html)
                        revisionClass = Html_Revision.new(@html)

                        # citation
                        unless hInstrumentationEvent[:citations].empty?
                            @html.div(:class => 'block') do
                                @html.div do
                                    @html.summary('Citations', {'class' => 'h4'})
                                    hInstrumentationEvent[:citations].each do |citation|
                                        @html.div(:class => 'block') do
                                        @html.div do
                                            @html.summary('Citation', {'class' => 'h5'})
                                                citationClass.writeHtml(citation)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        # description
                        unless hInstrumentationEvent[:description].nil?
                            @html.em('Description: ')
                            @html.text!(hInstrumentationEvent[:description])
                            @html.br
                        end

                        # extent
                        unless hInstrumentationEvent[:extent].empty?
                            @html.div(:class => 'block') do
                                @html.div do
                                    @html.summary('Extent', {'class' => 'h4'})
                                    @html.div(:class => 'block') do
                                        extentClass.writeHtml(hInstrumentationEvent[:extent])
                                    end
                                end
                            end
                        end

                        # eventType
                        unless hInstrumentationEvent[:eventType].nil?
                            @html.em('Event Type: ')
                            @html.text!(hInstrumentationEvent[:eventType])
                            @html.br
                        end

                        # revisionHistory
                        unless hInstrumentationEvent[:revisionHistories].empty?
                            @html.div(:class => 'block') do
                                @html.div do
                                    @html.summary('Revision History', {'class' => 'h4'})
                                    hInstrumentationEvent[:revisionHistories].each do |revision|
                                        @html.div(:class => 'block') do
                                        @html.div do
                                            @html.summary('Revision', {'class' => 'h5'})
                                                revisionClass.writeHtml(revision)
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