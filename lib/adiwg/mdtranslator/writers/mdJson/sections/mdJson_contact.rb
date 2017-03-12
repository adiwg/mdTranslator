# mdJson 2.0 writer - contact

# History:
#   Stan Smith 2017-03-11 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'
require_relative 'mdJson_onlineResource'
require_relative 'mdJson_phone'
require_relative 'mdJson_address'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Contact

               def self.build(hContact)

                  Jbuilder.new do |json|
                     json.contactId hContact[:contactId]
                     json.isOrganization hContact[:isOrganization]
                     json.name hContact[:name]
                     json.positionName hContact[:positionName]
                     # json.onlineResource json_map(hContact[:onlineRes], OnlineResource)
                     # json.contactInstructions hContact[:contactInstructions]
                     # json.phoneBook json_map(hContact[:phones], Phone)
                     # json.address Address.build(hContact[:address])
                  end

               end # build
            end # Contact

         end
      end
   end
end
