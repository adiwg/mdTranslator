# mdJson 2.0 writer - distributor

# History:
#   Stan Smith 2017-03-20 original script

require 'jbuilder'
require_relative 'mdJson_responsibleParty'
require_relative 'mdJson_orderProcess'
require_relative 'mdJson_transferOption'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Distributor

               @Namespace = ADIWG::Mdtranslator::Writers::MdJson

               def self.build(hDistributor)

                  Jbuilder.new do |json|
                     json.contact ResponsibleParty.build(hDistributor[:contact]) unless hDistributor[:contact].empty?
                     json.orderProcess @Namespace.json_map(hDistributor[:orderProcess], OrderProcess)
                     json.transferOption @Namespace.json_map(hDistributor[:transferOptions], TransferOption)
                  end

               end # build
            end # Distributor

         end
      end
   end
end
