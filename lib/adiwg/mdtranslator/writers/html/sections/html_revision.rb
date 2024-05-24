require_relative 'html_responsibility'
require_relative 'html_date'

module ADIWG
    module Mdtranslator
        module Writers
            module Html
                class Html_Revision
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hRevision)
                        responsibilityClass = Html_Responsibility.new(@html)
                        dateClass = Html_Date.new(@html)

                        # description
                        unless hRevision[:description].empty?
                            @html.em('Description: ')
                            @html.section(:class => 'block') do
                                @html.text!(hRevision[:description])
                            end
                        end

                        # responsibleParty
                        unless hRevision[:responsibleParties].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Responsible Parties', {'class' => 'h4'})
                                    hRevision[:responsibleParties].each do |party|
                                        @html.section(:class => 'block') do
                                        @html.details do
                                            @html.summary('Responsible Party', {'class' => 'h5'})
                                                responsibilityClass.writeHtml(party)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        # dateInfo
                        unless hRevision[:dateInfo].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Date Info', {'class' => 'h4'})
                                    hRevision[:dateInfo].each do |date|
                                        @html.section(:class => 'block') do
                                        @html.details do
                                            @html.summary('Date', {'class' => 'h5'})
                                                dateClass.writeHtml(date)
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