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
                  s = hItem[:itemName]
                  if !s.nil?
                     @html.em('Common name: ')
                     @html.text!(s)
                     @html.br
                  end

                  # domain member - value
                  s = hItem[:itemValue]
                  if !s.nil?
                     @html.em('Domain value: ')
                     @html.text!(s)
                     @html.br
                  end

                  # domain member - definition
                  s = hItem[:itemDefinition]
                  if !s.nil?
                     @html.em('Definition: ')
                     @html.section(:class => 'block') do
                        @html.text!(s)
                     end
                  end


               end # writeHtml
            end # Html_DomainItem

         end
      end
   end
end
