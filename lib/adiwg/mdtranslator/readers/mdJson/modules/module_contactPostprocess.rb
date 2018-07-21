# unpack contact
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-17 refactored error and warning messaging
#  Stan Smith 2018-02-20 original script

require_relative 'module_mdJson'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module ContactPost

               def self.examine(aContact, responseObj)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # test that all organizationMember IDs are in the contacts array
                  aContact.each do |hContact|
                     contactId = hContact[:contactId]
                     hContact[:memberOfOrgs].each do |orgId|
                        hOrg = MdJson.findContact(orgId)
                        if hOrg[0].nil?
                           outContext = "contact #{contactId}, membership organization ID #{orgId}"
                           @MessagePath.issueWarning(110, responseObj, outContext)
                        end
                     end
                  end

               end

            end

         end
      end
   end
end
