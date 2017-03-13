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

               def self.build(hContact)

                  Jbuilder.new do |json|
                     json.contactId hContact[:contactId]
                     json.isOrganization hContact[:isOrganization]
                     json.name hContact[:name]
                     json.positionName hContact[:positionName]
                     json.memberOfOrganization hContact[:memberOfOrgs] unless hContact[:memberOfOrgs].empty?
                     json.logoGraphic hContact[:logos].map { |obj| GraphicOverview.build(obj).attributes! }
                     json.phone hContact[:phones].map { |obj| Phone.build(obj).attributes! }
                     json.address hContact[:addresses].map { |obj| Address.build(obj).attributes! }
                     json.electronicMailAddress hContact[:eMailList] unless hContact[:eMailList].empty?
                     json.onlineResource hContact[:onlineResources].map { |obj| OnlineResource.build(obj).attributes! }
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
