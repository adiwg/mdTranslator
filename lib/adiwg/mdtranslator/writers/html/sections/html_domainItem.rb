# HTML writer
# domain item

# History:
#  Stan Smith 2017-04-05 refactored for mdTranslator 2.0
# 	Stan Smith 2015-03-26 original script

require_relative 'html_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_DomainItem

               def initialize(html)
                  @html = html
               end

               def writeHtml(hItem)

                  # classes used
                  citationClass = Html_Citation.new(@html)

                  # domain item - common name
                  unless hItem[:itemName].nil?
                     @html.em('Name: ')
                     @html.text!(hItem[:itemName])
                     @html.br
                  end

                  # domain item - value
                  unless hItem[:itemValue].nil?
                     @html.em('Value: ')
                     @html.text!(hItem[:itemValue])
                     @html.br
                  end

                  # domain item - definition
                  unless hItem[:itemDefinition].nil?
                     @html.em('Definition: ')
                     @html.section(:class => 'block') do
                        @html.text!(hItem[:itemDefinition])
                     end
                  end

                  # domain item - reference {citation}
                  unless hItem[:itemReference].empty?
                     @html.details do
                        @html.summary('Reference', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           citationClass.writeHtml(hItem[:itemReference])
                        end
                     end
                  end

               end # writeHtml
            end # Html_DomainItem

         end
      end
   end
end
