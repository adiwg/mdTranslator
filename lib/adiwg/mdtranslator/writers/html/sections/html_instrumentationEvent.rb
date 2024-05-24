require_relative 'html_citation'
require_relative 'html_extent'
require_relative 'html_revision'

module ADIWG
    module Mdtranslator
        module Writers
            module Html
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
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Citations', {'class' => 'h4'})
                                    hInstrumentationEvent[:citations].each do |citation|
                                        @html.section(:class => 'block') do
                                        @html.details do
                                            @html.summary('Citation', {'class' => 'h5'})
                                                citationClass.writeHtml(citation)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        # description
                        unless hInstrumentationEvent[:description].empty?
                            @html.em('Description: ')
                            @html.section(:class => 'block') do
                                @html.text!(hInstrumentationEvent[:description])
                            end
                        end

                        # extent
                        unless hInstrumentationEvent[:extent].empty?
                            @html.em('Extent: ')
                            @html.section(:class => 'block') do
                                extentClass.writeHtml(hInstrumentationEvent[:extent])
                            end
                        end

                        # eventType
                        unless hInstrumentationEvent[:eventType].empty?
                            @html.em('Event Type: ')
                            @html.section(:class => 'block') do
                                @html.text!(hInstrumentationEvent[:eventType])
                            end
                        end

                        # revisionHistory
                        unless hInstrumentationEvent[:revisionHistory].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Revision History', {'class' => 'h4'})
                                    hInstrumentationEvent[:revisionHistory].each do |revision|
                                        @html.section(:class => 'block') do
                                        @html.details do
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