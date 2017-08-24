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

               def self.unpack(aContacts, role, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hResponsibility = intMetadataClass.newResponsibility

                  hResponsibility[:roleName] = role

                  # add contacts to responsibility party []
                  aContacts.each do |contactId|
                     hContactInfo = Fgdc.find_contact_by_id(contactId)
                     unless hContactInfo[0].nil?
                        hParty = intMetadataClass.newParty
                        hParty[:contactId] = contactId
                        hParty[:contactIndex] = hContactInfo[0]
                        hParty[:contactType] = hContactInfo[1]
                        hResponsibility[:parties] << hParty
                     end
                  end

                  return hResponsibility

               end

            end

         end
      end
   end
end
