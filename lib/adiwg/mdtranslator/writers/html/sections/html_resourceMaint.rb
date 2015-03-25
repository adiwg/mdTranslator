# HTML writer
# resource maintenance information

# History:
# 	Stan Smith 2015-03-24 original script

require 'html_responsibleParty'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlResourceMaintenance
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hResMaint)

                        # classes used
                        htmlResParty = $HtmlNS::MdHtmlResponsibleParty.new(@html)

                        # resource maintenance - maintenance frequency
                        s = hResMaint[:maintFreq]
                        @html.text!(s)
                        @html.blockquote do

                            # resource maintenance - notes
                            aNotes = hResMaint[:maintNotes]
                            aNotes.each do |note|
                                @html.em('Note: ')
                                @html.text!(note)
                                @html.br
                            end

                            # resource maintenance - contacts
                            aResParty = hResMaint[:maintContacts]
                            aResParty.each do |hResParty|
                                htmlResParty.writeHtml(hResParty)
                            end

                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
