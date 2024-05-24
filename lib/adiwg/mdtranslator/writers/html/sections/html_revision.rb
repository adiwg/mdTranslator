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
                        unless hRevision[:description].nil?
                            @html.em('Description: ')
                            @html.text!(hRevision[:description])
                            @html.br
                        end

                        # responsibleParty
                        unless hRevision[:responsibleParty].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Responsible Party', {'class' => 'h4'})
                                    @html.section(:class => 'block') do
                                        responsibilityClass.writeHtml(hRevision[:responsibleParty])
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
                                        @html.em('Datetime: ')
                                        @html.text!(date[:dateTime].to_s)
                                        @html.br
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