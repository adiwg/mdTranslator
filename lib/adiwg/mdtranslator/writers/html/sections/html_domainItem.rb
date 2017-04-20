# HTML writer
# domain item

# History:
#  Stan Smith 2017-04-05 refactored for mdTranslator 2.0
# 	Stan Smith 2015-03-26 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_DomainItem

               def initialize(html)
                  @html = html
               end

               def writeHtml(hItem)

                  # domain member - common name
                  unless hItem[:itemName].nil?
                     @html.em('Name: ')
                     @html.text!(hItem[:itemName])
                     @html.br
                  end

                  # domain member - value
                  unless hItem[:itemValue].nil?
                     @html.em('Value: ')
                     @html.text!(hItem[:itemValue])
                     @html.br
                  end

                  # domain member - definition
                  unless hItem[:itemDefinition].nil?
                     @html.em('Definition: ')
                     @html.section(:class => 'block') do
                        @html.text!(hItem[:itemDefinition])
                     end
                  end

               end # writeHtml
            end # Html_DomainItem

         end
      end
   end
end
