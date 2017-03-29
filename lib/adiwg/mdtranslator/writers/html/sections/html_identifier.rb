# HTML writer
# identifier

# History:
#  Stan Smith 2017-03-23 refactor for mdTranslator 2.0
#  Stan Smith 2015-08-21 expanded to handle RS_Identifier
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
# 	Stan Smith 2015-03-24 original script

require_relative 'html_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_Identifier

               def initialize(html)
                  @html = html
               end

               def writeHtml(hIdentifier)

                  # classes used
                  citationClass = Html_Citation.new(@html)

                  # identifier - identifier
                  unless hIdentifier[:identifier].nil?
                     @html.em('Identifier:')
                     @html.text!(hIdentifier[:identifier])
                     @html.br
                  end

                  # identifier - namespace
                  unless hIdentifier[:namespace].nil?
                     @html.em(' Namespace:')
                     @html.text!(hIdentifier[:namespace])
                     @html.br
                  end

                  # identifier - version
                  unless hIdentifier[:version].nil?
                     @html.em(' Version:')
                     @html.text!(hIdentifier[:version])
                     @html.br
                  end

                  # identifier - description
                  unless hIdentifier[:description].nil?
                     @html.em(' Description:')
                     @html.section(:class => 'block') do
                        @html.text!(hIdentifier[:description])
                     end
                  end

                  # identifier - authority {citation}
                  unless hIdentifier[:citation].empty?
                     @html.details do
                        @html.summary('Authority', {'id' => 'metadata-identifier', 'class' => 'h4'})
                        @html.section(:class => 'block') do
                           citationClass.writeHtml(hIdentifier[:citation])
                        end
                     end
                  end

               end # writeHtml
            end # Html_Identifier

         end
      end
   end
end
