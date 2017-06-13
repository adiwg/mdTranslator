# unpack sbJson
# Reader - sbJson to internal data structure

# History:
#  Stan Smith 2017-06-12 refactor for mdTranslator 2.0
#  Josh Bradley original script

module ADIWG
   module Mdtranslator
      module Readers
         module SbJson

            def self.unpack(hSbJson, hResponseObj)

               # something goes here
               @contacts = []

            end

            # find the array pointer and type for a contact
            def self.findContact(contactId)

               contactIndex = nil
               contactType = nil
               @contacts.each_with_index do |contact, i|
                  if contact[:contactId] == contactId
                     contactIndex = i
                     if contact[:isOrganization]
                        contactType = 'organization'
                     else
                        contactType = 'individual'
                     end
                  end
               end
               return contactIndex, contactType

            end

            # set contacts array for reader test modules
            def self.setContacts(contacts)
               @contacts = contacts
            end

         end
      end
   end
end
