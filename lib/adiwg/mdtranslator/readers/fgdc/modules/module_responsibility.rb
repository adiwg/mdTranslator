# Reader - fgdc to internal data structure
# unpack fgdc metadata responsibility

# History:
#  Stan Smith 2017-08-18 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_fgdc'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module Responsibility

               def self.unpack(aNames, role, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hResponsibility = intMetadataClass.newResponsibility

                  hResponsibility[:roleName] = role

                  aNames.each do |name|

                     # get contactId for name
                     contactId = Fgdc.find_contact_by_name(name)
                     if contactId.nil?

                        # build a new contact for this name
                        hContact = intMetadataClass.newContact
                        contactId = UUIDTools::UUID.random_create.to_s
                        hContact[:contactId] = contactId
                        hContact[:name] = name
                        Fgdc.add_contact(hContact)

                     end

                     # add contact to responsibility party
                     hParty = intMetadataClass.newParty
                     aContact = Fgdc.find_contact_by_id(contactId)
                     hParty[:contactId] = contactId
                     hParty[:contactIndex] = aContact[0]
                     hParty[:contactType] = aContact[1]
                     hResponsibility[:parties] << hParty

                  end

                  return hResponsibility

               end

            end

         end
      end
   end
end
