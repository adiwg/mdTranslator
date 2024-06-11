require_relative 'html_datetime'

module ADIWG
    module Mdtranslator
        module Writers
            module Simple_html
                class Html_RequestedDate
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hRequestedDate)
                        datetimeClass = Html_Datetime.new(@html)

                        # requestedDateOfCollection
                        unless hRequestedDate[:requestedDateOfCollection].empty?
                            @html.em('Requested Date of Collection: ')
                            @html.text!(hRequestedDate[:requestedDateOfCollection][:dateTime].to_s)
                            @html.br
                        end

                        # latestAcceptableDate
                        unless hRequestedDate[:latestAcceptableDate].empty?
                            @html.em('Latest Acceptable Date: ')
                            @html.text!(hRequestedDate[:latestAcceptableDate][:dateTime].to_s)
                        end

                    end
                end
            end
        end
    end
end