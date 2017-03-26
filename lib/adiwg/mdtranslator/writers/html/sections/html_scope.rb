# HTML writer
# scope

# History:
#  Stan Smith 2017-03-25 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_Scope

               def initialize(html)
                  @html = html
               end

               def writeHtml(hScope)

                  # scope - code
                  unless hScope[:scopeCode].nil?
                     @html.em('Scope Code: ')
                     @html.text!(hScope[:scopeCode])
                     @html.br
                  end

                  # scope - description []
                  hScope[:scopeDescriptions].each do |hDescription|
                     # TODO scope description
                  end

                  # scope - extents []
                  hScope[:extents].each do |hExtent|
                     # TODO scope extent
                  end

               end # writeHtml
            end # Html_Scope

         end
      end
   end
end
