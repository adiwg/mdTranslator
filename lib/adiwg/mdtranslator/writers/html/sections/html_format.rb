# HTML writer
# format

# History:
#  Stan Smith 2017-04-03 refactored for mdTranslator 2.0
#  Stan Smith 2015-09-21 added compression method element
# 	Stan Smith 2015-03-27 original script

require_relative 'html_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_Format

               def initialize(html)
                  @html = html
               end

               def writeHtml(hFormat)

                  # classes used
                  citationClass = Html_Citation.new(@html)

                  # resource format - format specification {citation}
                  unless hFormat[:formatSpecification].empty?
                     @html.details do
                        @html.summary('Specification', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           citationClass.writeHtml(hFormat[:formatSpecification])
                        end
                     end
                  end

                  # resource format - amendment number
                  unless hFormat[:amendmentNumber].nil?
                     @html.em('Amendment Number: ')
                     @html.text!(hFormat[:amendmentNumber])
                     @html.br
                  end

                  # resource format - compression method
                  unless hFormat[:compressionMethod].nil?
                     @html.em('Compression Method: ')
                     @html.text!(hFormat[:compressionMethod])
                     @html.br
                  end

               end # writeHtml
            end # Html_Format

         end
      end
   end
end
