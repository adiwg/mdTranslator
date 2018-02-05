# sbJson 1.0 writer

# History:
#  Stan Smith 2017-11-29 remove summary (short abstract)
#  Stan Smith 2017-11-29 remove duplicate identifiers
#  Stan Smith 2017-11-09 add metadata identifier to output identifiers
#  Stan Smith 2017-11-08 remove identifier which is the primary resource
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
require_relative 'sbJson_geographicExtent'
require_relative 'sbJson_abstract'

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

                  resourceId = Id.build(intObj)
                  json.id resourceId
                  json.title hCitation[:title] unless hCitation.empty?
                  json.alternateTitles hCitation[:alternateTitles] unless hCitation[:alternateTitles].empty?
                  json.body Abstract.build(resourceInfo[:abstract])
                  json.citation Citation.build(hCitation) unless hCitation.empty?

                  # gather all identifiers
                  # include the metadataIdentifier if it is NOT in the 'gov.sciencebase.catalog' namespace
                  # otherwise it would be the resourceId above
                  aIdentifiers = []
                  unless metadataInfo[:metadataIdentifier].empty?
                     unless metadataInfo[:metadataIdentifier][:namespace] == 'gov.sciencebase.catalog'
                        aIdentifiers << metadataInfo[:metadataIdentifier]
                     end
                  end
                  # do not duplicate the identifier which is the primary resource
                  unless hCitation.empty?
                     hCitation[:identifiers].each do |hIdentifier|
                        unless hIdentifier[:identifier] == resourceId
                           aIdentifiers << hIdentifier
                        end
                     end
                  end
                  # eliminate duplicate identifiers
                  # duplicate must match on both ID and schema (namespace)
                  aUniqIds = []
                  aIdentifiers.each do |hIdentifier|
                     foundDup = false
                     aUniqIds.each do |hUniqId|
                        if hIdentifier[:identifier] == hUniqId[:identifier]
                           if hIdentifier[:namespace] == hUniqId[:namespace]
                              foundDup = true
                           end
                        end
                     end
                     unless foundDup
                        aUniqIds << hIdentifier
                     end
                  end
                  json.identifiers @Namespace.json_map(aUniqIds, Identifier) unless aIdentifiers.empty?

                  json.purpose resourceInfo[:purpose]

                  haveRights = false
                  haveRights = true unless resourceInfo[:constraints].empty?
                  distributorInfo.each do |hDistribution|
                     unless hDistribution[:liabilityStatement].nil?
                        haveRights = true
                     end
                  end
                  if haveRights
                     json.rights Rights.build(resourceInfo[:constraints], distributorInfo)
                  end

                  json.provenance Provenance.build
                  json.materialRequestInstructions MaterialRequest.build(distributorInfo) unless distributorInfo.empty?
                  json.parentId ParentId.build(metadataInfo[:parentMetadata]) unless metadataInfo[:parentMetadata].empty?
                  aContactList = Contact.get_contact_list(intObj)
                  json.contacts @Namespace.json_map(aContactList, Contact) unless aContactList.empty?
                  json.webLinks WebLink.build(intObj[:metadata])
                  json.browseCategories BrowseCategory.build(resourceInfo[:resourceTypes])
                  json.tags Tag.build(intObj)
                  json.dates Date.build(resourceInfo) unless resourceInfo.empty?
                  json.spatial Spatial.build(resourceInfo[:extents]) unless resourceInfo[:extents].empty?
                  json.facets Facet.build(intObj[:metadata])
                  json.geographicExtents GeographicExtent.build(resourceInfo[:extents]) unless resourceInfo[:extents].empty?

               end

            end

         end
      end
   end
end
