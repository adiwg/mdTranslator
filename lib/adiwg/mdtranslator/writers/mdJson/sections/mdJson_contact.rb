# mdJson 2.0 writer - contact

# History:
#   Stan Smith 2017-03-11 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'
require_relative 'mdJson_graphicOverview'
require_relative 'mdJson_phone'
require_relative 'mdJson_address'
require_relative 'mdJson_onlineResource'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Contact

               @Namespace = ADIWG::Mdtranslator::Writers::MdJson

               def self.build(hContact)

                  Jbuilder.new do |json|
                     json.contactId hContact[:contactId]
                     json.isOrganization hContact[:isOrganization]
                     json.name hContact[:name]
                     json.positionName hContact[:positionName]
                     json.memberOfOrganization hContact[:memberOfOrgs] unless hContact[:memberOfOrgs].empty?
                     json.logoGraphic @Namespace.json_map(hContact[:logos], GraphicOverview)
                     json.phone @Namespace.json_map(hContact[:phones], Phone)
                     json.address @Namespace.json_map(hContact[:addresses], Address)
                     json.electronicMailAddress hContact[:eMailList] unless hContact[:eMailList].empty?
                     json.externalIdentifiers hContact[:externalIdentifiers] unless hContact[:externalIdentifiers].empty?
                     json.onlineResource @Namespace.json_map(hContact[:onlineResources], OnlineResource)
                     json.hoursOfService hContact[:hoursOfService] unless hContact[:hoursOfService].empty?
                     json.contactInstructions hContact[:contactInstructions]
                     json.contactType hContact[:contactType]
                  end

               end # build
            end # Contact

         end
      end
   end
end
