# HTML writer
# transfer option

# History:
#  Stan Smith 2017-04-04 refactored for mdTranslator 2.0
#  Stan Smith 2015-09-21 added transfer size elements
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
# 	Stan Smith 2015-03-27 original script

require_relative 'html_onlineResource'
require_relative 'html_medium'
require_relative 'html_format'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_TransferOption

               def initialize(html)
                  @html = html
               end

               def writeHtml(hTransOption)

                  @html.text!('Nothing Here')



                  # classes used
                  onlineClass = Html_OnlineResource.new(@html)
                  mediumClass = Html_Medium.new(@html)
                  formatClass = Html_Format.new(@html)

                  # # resource distribution - resource format
                  # hTransOption[:distFormats].each do |hFormat|
                  #    htmlFormat.writeHtml(hFormat)
                  # end
                  #
                  # # transfer options - transfer size
                  # s = hTransOption[:transferSize]
                  # if !s.nil?
                  #    @html.em('Transfer size: ')
                  #    @html.text!(s.to_s)
                  #    @html.br
                  # end
                  #
                  # # transfer options - transfer size units
                  # s = hTransOption[:transferSizeUnits]
                  # if !s.nil?
                  #    @html.em('Transfer size units: ')
                  #    @html.text!(s)
                  #    @html.br
                  # end
                  #
                  # # transfer options - online options - online resource
                  # aOlRes = hTransOption[:online]
                  # aOlRes.each do |hOlRes|
                  #    @html.em('Online option: ')
                  #    @html.section(:class => 'block') do
                  #       onlineClass.writeHtml(hOlRes)
                  #    end
                  # end
                  #
                  # # transfer options - offline option - medium
                  # hMedium = hTransOption[:offline]
                  # if !hMedium.empty?
                  #    @html.em('Offline option: ')
                  #    @html.section(:class => 'block') do
                  #       htmlMedium.writeHtml(hMedium)
                  #    end
                  # end

               end # writeHtml
            end # Html_TransferOption

         end
      end
   end
end
