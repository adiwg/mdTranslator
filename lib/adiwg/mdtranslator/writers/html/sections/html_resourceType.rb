# HTML writer
# resource type

# History:
# 	Stan Smith 2015-03-25 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_ResourceType

               def initialize(html)
                  @html = html
               end

               def writeHtml(hType)

                  # resource type
                  @html.em('Resource Type: ')
                  @html.text!(hType[:type] + ' - ' + hType[:name])
                  @html.br

               end # writeHtml
            end # Html_ResourceType

         end
      end
   end
end
