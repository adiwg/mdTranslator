# HTML writer
# algorithm

# History:
#  Stan Smith 2019-09-24 original script

require_relative 'html_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module Simple_html

            class Html_Algorithm

               def initialize(html)
                  @html = html
               end

               def writeHtml(hAlgorithm)

                  # classes used
                  citationClass = Html_Citation.new(@html)

                  # algorithm - description
                  unless hAlgorithm[:description].nil?
                     @html.em('Description: ')
                     @html.text!(hAlgorithm[:description])
                     @html.br
                  end

                  # algorithm - citation {citation}
                  unless hAlgorithm[:citation].empty?
                     @html.div do
                        @html.h5('Algorithm citation', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           citationClass.writeHtml(hAlgorithm[:citation])
                        end
                     end
                  end

               end # writeHtml
            end # Html_Algorithm

         end
      end
   end
end
