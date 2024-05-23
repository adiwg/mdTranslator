require_relative 'html_identifier'
require_relative 'html_extent'
require_relative 'html_event'
require_relative 'html_pass'
require_relative 'html_instrument'

module ADIWG
    module Mdtranslator
        module Writers
            module Html
                class Html_Objective
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hObjective)
                        identifierClass = Html_Identifier.new(@html)
                        extentClass = Html_Extent.new(@html)
                        eventClass = Html_Event.new(@html)
                        passClass = Html_Pass.new(@html)
                        instrumentClass = Html_Instrument.new(@html)

                        # objectiveId
                        unless hObjective[:objectiveId].empty?
                            @html.em('Objective ID', {'class' => 'h4'})
                            @html.section(:class => 'block') do
                                @html.text!(hObjective[:objectiveId])
                            end
                        end

                        # identifier
                        unless hObjective[:identifiers].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Identifiers', {'class' => 'h4'})
                                    hObjective[:identifiers].each do |identifier|
                                        @html.section(:class => 'block') do
                                        @html.details do
                                            @html.summary('Identifier', {'class' => 'h5'})
                                                @html.text!(identifier)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        # priority
                        unless hObjective[:priority].empty?
                            @html.em('Priority', {'class' => 'h4'})
                            @html.section(:class => 'block') do
                                @html.text!(hObjective[:priority])
                            end
                        end

                        # objectiveType
                        unless hObjective[:objectiveTypes].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Objective Types', {'class' => 'h4'})
                                    hObjective[:objectiveTypes].each do |type|
                                        @html.section(:class => 'block') do
                                        @html.details do
                                            @html.summary('Type', {'class' => 'h5'})
                                                @html.text!(type)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        # function
                        unless hObjective[:functions].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Functions', {'class' => 'h4'})
                                    hObjective[:functions].each do |function|
                                        @html.section(:class => 'block') do
                                        @html.details do
                                            @html.summary('Function', {'class' => 'h5'})
                                                @html.text!(function)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                        
                        # extent
                        unless hObjective[:extents].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Extents', {'class' => 'h4'})
                                    hObjective[:extents].each do |extent|
                                        @html.section(:class => 'block') do
                                        @html.details do
                                            @html.summary('Extent', {'class' => 'h5'})
                                                extentClass.writeHtml(extent)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        # objectiveOccurrence
                        unless hObjective[:objectiveOccurrences].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Occurrences', {'class' => 'h4'})
                                    hObjective[:objectiveOccurrences].each do |occurrence|
                                        @html.section(:class => 'block') do
                                        @html.details do
                                            @html.summary('Occurrence', {'class' => 'h5'})
                                                eventClass.writeHtml(occurrence)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        # pass
                        unless hObjective[:passes].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Passes', {'class' => 'h4'})
                                    hObjective[:passes].each do |pass|
                                        @html.section(:class => 'block') do
                                        @html.details do
                                            @html.summary('Pass', {'class' => 'h5'})
                                                passClass.writeHtml(pass)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        # sensingInstrument
                        unless hObjective[:sensingInstruments].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Sensing Instruments', {'class' => 'h4'})
                                    hObjective[:sensingInstruments].each do |instrument|
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

                end # Html_Requirement
            end
        end
    end
end