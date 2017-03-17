# mdJson 2.0 writer - taxonomic voucher

# History:
#   Stan Smith 2017-03-17 original script

require 'jbuilder'
require_relative 'mdJson_responsibleParty'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Voucher

               def self.build(hVoucher)

                  Jbuilder.new do |json|
                     json.specimen hVoucher[:specimen]
                     json.repository ResponsibleParty.build(hVoucher[:repository]) unless hVoucher[:repository].empty?
                  end

               end # build
            end # Voucher

         end
      end
   end
end
