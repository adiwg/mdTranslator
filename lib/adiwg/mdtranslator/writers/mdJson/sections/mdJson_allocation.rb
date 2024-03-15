# mdJson 2.0 writer - allocation

# History:
#  Stan Smith 2018-03-31 added responsibleParties []
#  Stan Smith 2017-08-31 refactored for mdJson schema 2.3
#  Stan Smith 2017-03-20 original script

require 'jbuilder'
require_relative 'mdJson_responsibleParty'
require_relative 'mdJson_onlineResource'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Allocation

               @Namespace = ADIWG::Mdtranslator::Writers::MdJson

               def self.build(hAllocation)

                  Jbuilder.new do |json|
                     json.sourceAllocationId hAllocation[:id]
                     json.amount hAllocation[:amount]
                     json.currency hAllocation[:currency]
                     json.sourceId hAllocation[:sourceId]
                     json.recipientId hAllocation[:recipientId]
                     json.responsibleParty @Namespace.json_map(hAllocation[:responsibleParties], ResponsibleParty)
                     json.matching hAllocation[:matching]
                     json.comment hAllocation[:comment]
                     json.onlineResource @Namespace.json_map(hAllocation[:onlineResources], OnlineResource)
                  end

               end # build
            end # Allocation

         end
      end
   end
end
