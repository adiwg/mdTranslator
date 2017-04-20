# HTML writer
# online resource

# History:
#  Stan Smith 2017-03-24 refactored for mdTranslator 2.0
# 	Stan Smith 2015-03-24 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_OnlineResource

               def initialize(html)
                  @html = html
               end

               def writeHtml(hOlRes)

                  # online resource - URI
                  @html.em('URI: ')
                  @html.a(hOlRes[:olResURI], 'href' => hOlRes[:olResURI])
                  @html.br

                  # online resource - name
                  unless hOlRes[:olResName].nil?
                     @html.em('Name: ')
                     @html.text!(hOlRes[:olResName])
                     @html.br
                  end

                  # online resource - description
                  unless hOlRes[:olResDesc].nil?
                     @html.em('Description: ')
                     @html.text!(hOlRes[:olResDesc])
                     @html.br
                  end

                  # online resource - function
                  unless hOlRes[:olResFunction].nil?
                     @html.em('Function: ')
                     @html.text!(hOlRes[:olResFunction])
                     @html.br
                  end

                  # online resource - protocol
                  unless hOlRes[:olResProtocol].nil?
                     @html.em('Protocol: ')
                     @html.text!(hOlRes[:olResProtocol])
                     @html.br
                  end

               end # writeHtml
            end # Html_OnlineResource

         end
      end
   end
end
