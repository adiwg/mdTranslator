# HTML writer
# transfer option

# History:
# 	Stan Smith 2015-03-27 original script
#   Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS

require_relative 'html_onlineResource'
require_relative 'html_medium'

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
                        htmlOlRes = MdHtmlOnlineResource.new(@html)
                        htmlMedium = MdHtmlMedium.new(@html)

                        # transfer options - online options - online resource
                        aOlRes = hTransOption[:online]
                        aOlRes.each do |hOlRes|
                            @html.em('Online option: ')
                            @html.section(:class=>'block') do
                                htmlOlRes.writeHtml(hOlRes)
                            end
                        end

                        # transfer options - offline option - medium
                        hMedium = hTransOption[:offline]
                        if !hMedium.empty?
                            @html.em('Offline option: ')
                            @html.section(:class=>'block') do
                                htmlMedium.writeHtml(hMedium)
                            end
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
