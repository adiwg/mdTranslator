# unpack publisher
# Reader - DCAT-US to internal data structure
# Maps 'publisher' object to contacts[] and citation.responsibleParties

require 'securerandom'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Dcat_us

            module Publisher

               def self.unpack(hDataset, hCitation, aContacts, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  return hCitation unless hDataset.has_key?('publisher')

                  hPublisher = hDataset['publisher']
                  return hCitation if hPublisher.nil? || hPublisher.empty?

                  org_name = hPublisher['name']
                  return hCitation if org_name.nil? || org_name == ''

                  # Create contact for the publisher organization
                  hContact = intMetadataClass.newContact
                  hContact[:contactId] = SecureRandom.uuid
                  hContact[:isOrganization] = true
                  hContact[:name] = org_name
                  aContacts << hContact

                  # Handle subOrganizationOf hierarchy
                  if hPublisher.has_key?('subOrganizationOf')
                     parent = hPublisher['subOrganizationOf']
                     parent_name = parent['name'] unless parent.nil?
                     unless parent_name.nil? || parent_name == ''
                        hParentContact = intMetadataClass.newContact
                        hParentContact[:contactId] = SecureRandom.uuid
                        hParentContact[:isOrganization] = true
                        hParentContact[:name] = parent_name
                        aContacts << hParentContact
                        hContact[:memberOfOrgs] << hParentContact[:contactId]
                     end
                  end

                  # Create responsible party referencing the publisher contact
                  hResponsibility = intMetadataClass.newResponsibility
                  hResponsibility[:roleName] = 'publisher'
                  hParty = intMetadataClass.newParty
                  hParty[:contactId] = hContact[:contactId]
                  hParty[:contactType] = 'organization'
                  hParty[:contactName] = hContact[:name]
                  hResponsibility[:parties] << hParty
                  hCitation[:responsibleParties] << hResponsibility

                  return hCitation

               end

            end

         end
      end
   end
end
