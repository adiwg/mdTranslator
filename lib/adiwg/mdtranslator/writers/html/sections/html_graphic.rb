# HTML writer
# graphic or graphic overview

# History:
#  Stan Smith 2017-03-24 refactored for mdTranslator 2.0
# 	Stan Smith 2015-03-24 original script

require_relative 'html_onlineResource'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_Graphic
                    
               def initialize(html)
                  @html = html
               end

               def writeHtml(hGraphic)

                  # classes used
                  onlineClass = Html_OnlineResource.new(@html)

                  # graphic - name
                  unless hGraphic[:graphicName].nil?
                     @html.em('Name: ')
                     @html.text!(hGraphic[:graphicName])
                     @html.br
                  end

                  # graphic - description
                  unless hGraphic[:graphicDescription].nil?
                     @html.em('Description: ')
                     @html.text!(hGraphic[:graphicDescription])
                     @html.br
                  end

                  # graphic - type
                  unless hGraphic[:graphicType].nil?
                     @html.em('Type: ')
                     @html.text!(hGraphic[:graphicType])
                     @html.br
                  end

                  # graphic - URI []
                  hGraphic[:graphicURI].each do |hOnline|
                     onlineClass.writeHtml(hOnline)
                  end

                  # TODO add constraint to graphic

               end # writeHtml
            end # Html_Graphic

         end
      end
   end
end
