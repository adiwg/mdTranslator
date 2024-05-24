require_relative 'html_date'

module ADIWG
    module Mdtranslator
        module Writers
            module Html
                class Html_RequestedDate
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hRequestedDate)
                        dateClass = Html_Date.new(@html)

                        # requestedDateOfCollection
                        unless hRequestedDate[:requestedDateOfCollection].empty?
                            @html.em('Requested Date of Collection', {'class' => 'h4'})
                            @html.section(:class => 'block') do
                                dateClass.writeHtml(hRequestedDate[:requestedDateOfCollection])
                            end
                        end

                        # latestAcceptableDate
                        unless hRequestedDate[:latestAcceptableDate].empty?
                            @html.em('Latest Acceptable Date', {'class' => 'h4'})
                            @html.section(:class => 'block') do
                                dateClass.writeHtml(hRequestedDate[:latestAcceptableDate])
                            end
                        end

                    end
                end
            end
        end
    end
end