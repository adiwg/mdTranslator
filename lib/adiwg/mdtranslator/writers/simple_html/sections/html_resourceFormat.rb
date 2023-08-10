# HTML writer
# resource format

# History:
# 	Stan Smith 2015-03-24 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class MdHtmlResourceFormat
               def initialize(html)
                  @html = html
               end

               def writeHtml(hResFormat)

                  # resource format - name - required
                  unless hResFormat[:formatName].nil?
                     @html.em('Resource Format: ')
                     @html.text!(hResFormat[:formatName])
                  end

                  # resource format - version
                  unless  !hResFormat[:formatVersion].nil?
                     @html.em(' Version: ')
                     @html.text!(hResFormat[:formatVersion])
                  end

                  @html.br

               end # writeHtml

            end # class

         end
      end
   end
end
