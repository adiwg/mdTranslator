# unpack sbJson
# Reader - sbJson to internal data structure

# History:
#  Stan Smith 2017-06-12 refactor for mdTranslator 2.0
#  Josh Bradley original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_titles'

module ADIWG
   module Mdtranslator
      module Readers
         module SbJson

            module SbJson

               def self.unpack(hSbJson, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  intObj = intMetadataClass.newBase

                  # build basic mdTranslator internal object
                  hMetadata = intMetadataClass.newMetadata
                  hMetadataInfo = intMetadataClass.newMetadataInfo
                  hResource = intMetadataClass.newResourceInfo
                  hCitation = intMetadataClass.newCitation

                  hResource[:citation] = hCitation
                  hMetadata[:metadataInfo] = hMetadataInfo
                  hMetadata[:resourceInfo] = hResource
                  intObj[:metadata] = hMetadata

                  # titles / alternateTitles
                  Title.unpack(hSbJson, hCitation, hResponseObj)

                  # id

                  # something goes here
                  @contacts = []

                  return intObj

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
end