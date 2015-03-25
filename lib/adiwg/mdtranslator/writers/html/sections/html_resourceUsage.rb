# HTML writer
# resource specific usage

# History:
# 	Stan Smith 2015-03-25 original script

require 'html_responsibleParty'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlResourceUsage
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hUsage)

                        # classes used
                        htmlRParty = $HtmlNS::MdHtmlResponsibleParty.new(@html)

                        # resource usage - use - required
                        @html.em('Use: ')
                        @html.text!(hUsage[:specificUsage])
                        @html.br

                        # resource usage - userLimits
                        s = hUsage[:userLimits]
                        if !s.nil?
                            @html.em('Limits: ')
                            @html.text!(s)
                            @html.br
                        end

                        # resource usage - userContacts
                        aUseCon = hUsage[:userContacts]
                        if !aUseCon.empty?
                            aUseCon.each do |hRepParty|
                                htmlRParty.writeHtml(hRepParty)
                            end
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
