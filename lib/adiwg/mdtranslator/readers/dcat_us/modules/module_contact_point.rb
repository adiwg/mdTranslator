# unpack contactPoint
# Reader - DCAT-US to internal data structure
# Maps 'contactPoint' vCard object to contacts[] and resourceInfo.pointOfContacts

require 'securerandom'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Dcat_us

            module ContactPoint

               def self.unpack(hDataset, hResourceInfo, aContacts, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  return hResourceInfo unless hDataset.has_key?('contactPoint')

                  hContactPoint = hDataset['contactPoint']
                  return hResourceInfo if hContactPoint.nil? || hContactPoint.empty?

                  fn = hContactPoint['fn']
                  has_email = hContactPoint['hasEmail']

                  # At minimum we need a name
                  return hResourceInfo if fn.nil? || fn == ''

                  # Create contact
                  hContact = intMetadataClass.newContact
                  hContact[:contactId] = SecureRandom.uuid
                  hContact[:isOrganization] = false
                  hContact[:name] = fn

                  # Strip 'mailto:' prefix from email
                  unless has_email.nil? || has_email == ''
                     email = has_email.start_with?('mailto:') ? has_email[7..] : has_email
                     hContact[:eMailList] << email unless email.nil? || email == ''
                  end

                  aContacts << hContact

                  # Create pointOfContact responsibility
                  hResponsibility = intMetadataClass.newResponsibility
                  hResponsibility[:roleName] = 'pointOfContact'
                  hParty = intMetadataClass.newParty
                  hParty[:contactId] = hContact[:contactId]
                  hParty[:contactType] = 'individual'
                  hParty[:contactName] = hContact[:name]
                  hResponsibility[:parties] << hParty
                  hResourceInfo[:pointOfContacts] << hResponsibility

                  return hResourceInfo

               end

            end

         end
      end
   end
end
