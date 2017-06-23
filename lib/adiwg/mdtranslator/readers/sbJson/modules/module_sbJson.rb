# unpack sbJson
# Reader - sbJson to internal data structure

# History:
#  Stan Smith 2017-06-12 refactor for mdTranslator 2.0
#  Josh Bradley original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_titles'
require_relative 'module_id'
require_relative 'module_body'
require_relative 'module_citation'
require_relative 'module_identifier'
require_relative 'module_purpose'
require_relative 'module_rights'
require_relative 'module_provenance'
require_relative 'module_materialRequest'
require_relative 'module_parentId'
require_relative 'module_contact'
require_relative 'module_webLinkDocument'
require_relative 'module_webLinkGraphic'

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
                  hResourceInfo = intMetadataClass.newResourceInfo
                  hCitation = intMetadataClass.newCitation

                  # titles / alternateTitles
                  Title.unpack(hSbJson, hCitation, hResponseObj)

                  # id
                  hReturn = Id.unpack(hSbJson, hResponseObj)
                  hMetadataInfo[:metadataIdentifier] = hReturn unless hReturn.nil?

                  # body / summary
                  Body.unpack(hSbJson, hResourceInfo, hResponseObj)

                  # citation
                  Citation.unpack(hSbJson, hCitation, hResponseObj)

                  # identifier
                  Identifier.unpack(hSbJson, hCitation, hResponseObj)

                  # purpose
                  Purpose.unpack(hSbJson, hResourceInfo, hResponseObj)

                  # rights
                  hReturn = Rights.unpack(hSbJson, hResponseObj)
                  hResourceInfo[:constraints] << hReturn unless hReturn.nil?

                  # provenance
                  Provenance.unpack(hSbJson, hCitation, hResponseObj)

                  # materialRequestInstructions
                  aReturn = MaterialRequest.unpack(hSbJson, hResponseObj)
                  unless aReturn.nil?
                     hContact = aReturn[0]
                     myIndex = intObj[:contacts].length
                     intObj[:contacts] << hContact
                     aReturn[1][:distributor][0][:contact][:parties][0][:contactIndex] = myIndex
                     hMetadata[:distributorInfo] << aReturn[1]
                  end

                  # parent ID
                  hReturn = ParentId.unpack(hSbJson, hResponseObj)
                  hMetadataInfo[:parentMetadata] = hReturn unless hReturn.nil?

                  # contacts
                  Contact.unpack(hSbJson, intObj[:contacts], hResponseObj)

                  # web links
                  aReturn = WebLinkDocument.unpack(hSbJson, hResponseObj)
                  hMetadata[:additionalDocuments].concat(aReturn) unless aReturn.nil?
                  aReturn = WebLinkGraphic.unpack(hSbJson, hResponseObj)
                  hResourceInfo[:graphicOverviews].concat(aReturn) unless aReturn.nil?

                  hResourceInfo[:citation] = hCitation
                  hMetadata[:metadataInfo] = hMetadataInfo
                  hMetadata[:resourceInfo] = hResourceInfo
                  intObj[:metadata] = hMetadata
                  @contacts = intObj[:contacts]

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
