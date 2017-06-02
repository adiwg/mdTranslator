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
require_relative 'sbJson_webLink'
require_relative 'sbJson_browseCategory'
require_relative 'sbJson_tag'
require_relative 'sbJson_date'
require_relative 'sbJson_spatial'
require_relative 'sbJson_facet'

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
                  aContactList = Contact.get_contact_list(intObj)
                  json.contacts @Namespace.json_map(aContactList, Contact) unless aContactList.empty?
                  json.webLinks WebLink.build(intObj[:metadata])
                  json.browseCategories BrowseCategory.build(resourceInfo[:resourceTypes])
                  json.tags Tag.build(resourceInfo)
                  json.dates Date.build(hCitation) unless hCitation.empty?
                  json.spatial Spatial.build(resourceInfo[:extents]) unless resourceInfo[:extents].empty?
                  json.facets Facet.build(intObj[:metadata])

               end

            end

         end
      end
   end
end
