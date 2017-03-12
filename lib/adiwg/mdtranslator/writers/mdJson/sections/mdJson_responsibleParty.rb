# mdJson 2.0 writer - dictionary

# History:
#   Stan Smith 2017-03-11 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module ResponsibleParty

               def self.build(hResParty)

                  Jbuilder.new do |json|
                     json.role hResParty[:roleName]
                     # roleExtent
                     json.party(hResParty[:parties]) do |party|
                        json.contactId party[:contactId]
                     end
                  end

               end # build
            end # ResponsibleParty

         end
      end
   end
end
