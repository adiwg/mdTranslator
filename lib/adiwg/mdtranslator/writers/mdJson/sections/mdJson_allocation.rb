# mdJson 2.0 writer - allocation

# History:
#   Stan Smith 2017-03-20 original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Allocation

               def self.build(hAllocation)

                  Jbuilder.new do |json|
                     json.amount hAllocation[:amount]
                     json.currency hAllocation[:currency]
                     json.sourceId hAllocation[:sourceId]
                     json.recipientId hAllocation[:recipientId]
                     json.matching hAllocation[:matching]
                     json.comment hAllocation[:comment]
                  end

               end # build
            end # Allocation

         end
      end
   end
end
