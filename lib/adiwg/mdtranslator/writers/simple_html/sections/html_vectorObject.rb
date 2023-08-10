# HTML writer
# vector object

# History:
#  Stan Smith 2017-03-28 original script

module ADIWG
   module Mdtranslator
      module Writers
         module SimpleHtml

            class Html_VectorObject

               def initialize(html)
                  @html = html
               end

               def writeHtml(hObject)

                  # vector object - type
                  unless hObject[:objectType].nil?
                     @html.em('Object Type: ')
                     @html.text!(hObject[:objectType])
                     @html.br
                  end

                  # vector object - count
                  unless hObject[:objectCount].nil?
                     @html.em('Object Count: ')
                     @html.text!(hObject[:objectCount].to_s)
                     @html.br
                  end

               end # writeHtml
            end # Html_VectorObject

         end
      end
   end
end
