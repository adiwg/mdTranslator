# sbJson 1.0 writer

# History:
#  Stan Smith 2017-05-12 refactored for mdJson/mdTranslator 2.0
#  Josh Bradley original script

require 'jbuilder'
require_relative 'sbJson_id'
require_relative 'sbJson_citation'
require_relative 'sbJson_identifier'
require_relative 'sbJson_rights'
require_relative 'sbJson_provenance'
require_relative 'sbJson_materialRequest'
require_relative 'sbJson_parentId'
require_relative 'sbJson_contact'
require_relative 'sbJson_contactList'

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            def self.build(intObj, responseObj)

               metadataInfo = intObj[:metadata][:metadataInfo]
               resourceInfo = intObj[:metadata][:resourceInfo]
               distributorInfo = intObj[:metadata][:distributorInfo]
               hCitation = resourceInfo[:citation]

               @Namespace = ADIWG::Mdtranslator::Writers::SbJson

               Jbuilder.new do |json|

                  json.id Id.build(intObj)
                  json.title hCitation[:title] unless hCitation.empty?
                  json.alternateTitles hCitation[:alternateTitles] unless hCitation[:alternateTitles].empty?
                  json.body resourceInfo[:abstract]
                  json.summary resourceInfo[:shortAbstract]
                  json.citation Citation.build(hCitation) unless hCitation.empty?
                  json.identifiers @Namespace.json_map(hCitation[:identifiers], Identifier) unless hCitation.empty?
                  json.purpose resourceInfo[:purpose]
                  json.rights Rights.build(resourceInfo[:constraints]) unless resourceInfo[:constraints].empty?
                  json.provenance Provenance.build(metadataInfo)
                  json.materialRequestInstructions MaterialRequest.build(distributorInfo) unless distributorInfo.empty?
                  json.parentId ParentId.build(metadataInfo[:parentMetadata]) unless metadataInfo[:parentMetadata].empty?
                  aContactList = ContactList.build(intObj)
                  json.contacts @Namespace.json_map(aContactList, Contact) unless aContactList.empty?

               end

            end

         end
      end
   end
end
