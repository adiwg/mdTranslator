# HTML writer
# resource type

# History:
#  Stan Smith 2017-05-24 Fixed problem with nil name
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

                  # resource type - (required)
                  unless hType[:type].nil?
                     @html.em('Resource Type: ')
                     @html.text!(hType[:type])
                     unless hType[:name].nil?
                        @html.em(' Name: ')
                        @html.text!(hType[:name])
                     end
                     @html.br
                  end

               end # writeHtml
            end # Html_ResourceType

         end
      end
   end
end
