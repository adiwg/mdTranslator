# unpack bureauCode
# Reader - DCAT-US to internal data structure
# Maps 'bureauCode' array to contacts with externalIdentifier[namespace=bureauCode]
# and adds each as a responsible party in citation.responsibleParties

require 'securerandom'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Dcat_us

            module BureauCode

               def self.unpack(hDataset, hCitation, aContacts, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  return hCitation unless hDataset.has_key?('bureauCode')

                  bureau_codes = hDataset['bureauCode']
                  return hCitation if bureau_codes.nil? || bureau_codes.empty?

                  bureau_codes.each do |code|
                     next if code.nil? || code == ''

                     # Create a contact carrying the bureau code external identifier
                     hContact = intMetadataClass.newContact
                     hContact[:contactId] = SecureRandom.uuid
                     hContact[:isOrganization] = true
                     hContact[:name] = "Bureau #{code}"

                     hExtId = intMetadataClass.newIdentifier
                     hExtId[:identifier] = code
                     hExtId[:namespace] = 'bureauCode'
                     hContact[:externalIdentifier] << hExtId

                     aContacts << hContact

                     # Add as responsible party so the writer can find it
                     hResponsibility = intMetadataClass.newResponsibility
                     hResponsibility[:roleName] = 'bureau'
                     hParty = intMetadataClass.newParty
                     hParty[:contactId] = hContact[:contactId]
                     hParty[:contactType] = 'organization'
                     hParty[:contactName] = hContact[:name]
                     hResponsibility[:parties] << hParty
                     hCitation[:responsibleParties] << hResponsibility
                  end

                  return hCitation

               end

            end

         end
      end
   end
end
