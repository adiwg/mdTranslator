# HTML writer
# transfer option

# History:
# 	Stan Smith 2015-03-27 original script

require 'html_onlineResource'
require 'html_medium'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlTransferOption
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hTransOption)

                        # classes used
                        htmlOlRes = $HtmlNS::MdHtmlOnlineResource.new(@html)
                        htmlMedium = $HtmlNS::MdHtmlMedium.new(@html)

                        # transfer options - online options - online resource
                        aOlRes = hTransOption[:online]
                        aOlRes.each do |hOlRes|
                            @html.em('Online option: ')
                            @html.blockquote do
                                htmlOlRes.writeHtml(hOlRes)
                            end
                        end

                        # transfer options - offline option - medium
                        hMedium = hTransOption[:offline]
                        if !hMedium.empty?
                            @html.em('Offline option: ')
                            @html.blockquote do
                                htmlMedium.writeHtml(hMedium)
                            end
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
