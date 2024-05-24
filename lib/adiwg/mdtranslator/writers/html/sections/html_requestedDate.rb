require_relative 'html_datetime'

module ADIWG
    module Mdtranslator
        module Writers
            module Html
                class Html_RequestedDate
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hRequestedDate)
                        datetimeClass = Html_Datetime.new(@html)

                        # requestedDateOfCollection
                        unless hRequestedDate[:requestedDateOfCollection].empty?
                            @html.em('Requested Date of Collection', {'class' => 'h4'})
                            @html.section(:class => 'block') do
                                @html.text!(hRequestedDate[:requestedDateOfCollection][:dateTime].to_s)
                            end
                        end

                        # latestAcceptableDate
                        unless hRequestedDate[:latestAcceptableDate].empty?
                            @html.em('Latest Acceptable Date', {'class' => 'h4'})
                            @html.section(:class => 'block') do
                                @html.text!(hRequestedDate[:latestAcceptableDate][:dateTime].to_s)
                            end
                        end

                    end
                end
            end
        end
    end
end