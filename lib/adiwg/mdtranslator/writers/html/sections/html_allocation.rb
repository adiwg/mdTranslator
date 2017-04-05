# HTML writer
# allocation

# History:
#  Stan Smith 2017-04-04 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_Allocation

               def initialize(html)
                  @html = html
               end

               def writeHtml(hAllocation)

                  # allocation - amount
                  unless hAllocation[:amount].nil?
                     @html.em('Amount: ')
                     @html.text!(hAllocation[:amount].to_s)
                     @html.br
                  end

                  # allocation - currency
                  # allocation - sourceId
                  # allocation - recipientId
                  # allocation - matching {Boolean}
                  # allocation - comment

               end # writeHtml
            end # Html_Allocation

         end
      end
   end
end
