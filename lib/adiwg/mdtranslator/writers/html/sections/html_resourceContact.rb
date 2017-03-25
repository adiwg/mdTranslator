# HTML writer
# general resource contacts

# History:
# 	Stan Smith 2015-03-24 original script
#   Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS

require_relative 'html_responsibility'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlResourceContact
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(resourceInfo)

                        # classes used
                        htmlParty = MdHtmlResponsibleParty.new(@html)

                        # general - contacts
                        resourceInfo[:pointsOfContact].each do |hResParty|
                            htmlParty.writeHtml(hResParty)
                        end

                    end # def writeHtml

                end

            end
        end
    end
end
