# unpack programCode
# Reader - DCAT-US to internal data structure
# Maps 'programCode' array to contacts with externalIdentifier[namespace=programCode]
# and adds each as a responsible party in citation.responsibleParties

require 'securerandom'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Dcat_us

            module ProgramCode

               def self.unpack(hDataset, hCitation, aContacts, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  return hCitation unless hDataset.has_key?('programCode')

                  program_codes = hDataset['programCode']
                  return hCitation if program_codes.nil? || program_codes.empty?

                  program_codes.each do |code|
                     next if code.nil? || code == ''

                     # Create a contact carrying the program code external identifier
                     hContact = intMetadataClass.newContact
                     hContact[:contactId] = SecureRandom.uuid
                     hContact[:isOrganization] = true
                     hContact[:name] = "Program #{code}"

                     hExtId = intMetadataClass.newIdentifier
                     hExtId[:identifier] = code
                     hExtId[:namespace] = 'programCode'
                     hContact[:externalIdentifier] << hExtId

                     aContacts << hContact

                     # Add as responsible party so the writer can find it
                     hResponsibility = intMetadataClass.newResponsibility
                     hResponsibility[:roleName] = 'program'
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
