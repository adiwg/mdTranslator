# HTML writer
# resource specific usage

# History:
# 	Stan Smith 2015-03-25 original script
#   Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS

require_relative 'html_responsibility'

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
                        htmlRParty = MdHtmlResponsibleParty.new(@html)

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
                            @html.em('Contacts:')
                            @html.section(:class=>'block') do
                                aUseCon.each do |hRepParty|
                                    htmlRParty.writeHtml(hRepParty)
                                end
                            end
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
