# unpack related items
# Reader - ScienceBase JSON to internal data structure

# History:
#   Stan Smith 2016-08-03 original script

require 'json'
require 'open-uri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_codelists'

module ADIWG
   module Mdtranslator
      module Readers
         module SbJson

            module RelatedItem

               def self.unpack(hSbJson, hMetadata, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  # relationship direction of related items depends on the main record id
                  sbId = nil
                  if hSbJson.has_key?('id')
                     sbId = hSbJson['id']
                  end
                  if sbId.nil? || sbId == ''
                     hResponseObj[:readerExecutionMessages] << 'ScienceBase id missing'
                     return hMetadata
                  end

                  # get the link to the related items array
                  hRelatedItems = hSbJson['relatedItems']
                  itemsLink = nil
                  if hRelatedItems.has_key?('link')
                     hLink = hRelatedItems['link']
                     unless hLink.empty?
                        itemsLink = hLink['url']
                     end
                  end
                  return hMetadata if itemsLink.nil?

                  # fetch the related items array in json format
                  itemsLink = itemsLink + '&format=json'
                  begin
                     web_contents = open(itemsLink, :read_timeout => 30) { |f| f.read }
                  rescue => readErr
                     hResponseObj[:readerExecutionMessages] << "Failed reading ScienceBase relatedItems #{itemsLink} - see following message(s):\n"
                     hResponseObj[:readerExecutionMessages] << readErr.to_s.slice(0, 300)
                     return hMetadata
                  else
                     # parse related items array
                     aItems = []
                     begin
                        aItems = JSON.parse(web_contents)
                     rescue JSON::JSONError => parseErr
                        hResponseObj[:readerExecutionMessages] << 'Parsing related links failed - see following message(s):\n'
                        hResponseObj[:readerExecutionMessages] << parseErr.to_s.slice(0, 300)
                        return hMetadata
                     end

                     # process each returned related item as a separate associated resource
                     aItems.each do |hItem|
                        unless hItem.empty?

                           # determine relationship direction
                           forward = nil
                           if hItem.has_key?('itemId')
                              forward = true if sbId == hItem['itemId']
                           end
                           if hItem.has_key?('relatedItemId')
                              forward = false if sbId == hItem['relatedItemId']
                           end
                           if forward.nil?
                              hResponseObj[:readerExecutionMessages] << 'Main ScienceBase id was not referenced in related item'
                              return hMetadata
                           end

                           # fetch resourceTypes from related item
                           if forward
                              resourceId = hItem['relatedItemId']
                           else
                              resourceId = hItem['itemId']
                           end
                           resourceLink = "https://www.sciencebase.gov/catalog/item/#{resourceId}?format=json"
                           begin
                              web_contents = open(resourceLink, :read_timeout => 30) { |f| f.read }
                           rescue => readErr
                              hResponseObj[:readerExecutionMessages] << "Failed reading ScienceBase relatedItem #{resourceId} - see following message(s)"
                              hResponseObj[:readerExecutionMessages] << readErr.to_s.slice(0, 300)
                              hResponseObj[:readerExecutionMessages] << 'Either the item does not exist or the item is secured and requires authentication to access.'
                              break
                           else
                              # parse related item
                              begin
                                 hRelatedItem = JSON.parse(web_contents)
                              rescue JSON::JSONError => parseErr
                                 hResponseObj[:readerExecutionMessages] << 'Parsing related item failed - see following message(s):\n'
                                 hResponseObj[:readerExecutionMessages] << parseErr.to_s.slice(0, 300)
                                 break
                              end

                              # create mew associated resource
                              hResource = intMetadataClass.newAssociatedResource

                              if hRelatedItem.has_key?('browseCategories')
                                 aBrowse = hRelatedItem['browseCategories']
                                 aBrowse.each do |category|
                                    resourceType = Codelists.codelist_sb2adiwg('scope_sb2adiwg', category)
                                    resourceType = resourceType.nil? ? category : resourceType
                                    hResource[:resourceTypes] << resourceType
                                 end
                              else
                                 hResponseObj[:readerExecutionMessages] << "Related item #{resourceId} did not have browseCategories"
                              end

                              # fill in associated resource citation
                              hCitation = intMetadataClass.newCitation
                              citationTitle = nil
                              if hItem.has_key?('relatedItemTitle')
                                 citationTitle = hItem['relatedItemTitle'] if forward
                              end
                              if hItem.has_key?('title')
                                 citationTitle = hItem['title'] unless forward
                              end
                              hCitation[:title] = citationTitle

                              # create an identifier for each related item id
                              if hItem.has_key?('id')
                                 hIdentifier = intMetadataClass.newIdentifier
                                 hIdentifier[:identifier] = hItem['id']
                                 hIdentifier[:namespace] = 'gov.sciencebase.catalog'
                                 hIdentifier[:description] = 'id'
                                 hCitation[:identifiers] << hIdentifier
                              end
                              if hItem.has_key?('itemId')
                                 hIdentifier = intMetadataClass.newIdentifier
                                 hIdentifier[:identifier] = hItem['itemId']
                                 hIdentifier[:namespace] = 'gov.sciencebase.catalog'
                                 hIdentifier[:description] = 'itemId'
                                 hCitation[:identifiers] << hIdentifier
                              end
                              if hItem.has_key?('relatedItemId')
                                 hIdentifier = intMetadataClass.newIdentifier
                                 hIdentifier[:identifier] = hItem['relatedItemId']
                                 hIdentifier[:namespace] = 'gov.sciencebase.catalog'
                                 hIdentifier[:description] = 'relatedItemId'
                                 hCitation[:identifiers] << hIdentifier
                              end
                              if hItem.has_key?('itemLinkTypeId')
                                 hIdentifier = intMetadataClass.newIdentifier
                                 hIdentifier[:identifier] = hItem['itemLinkTypeId']
                                 hIdentifier[:namespace] = 'gov.sciencebase.catalog'
                                 hIdentifier[:description] = 'itemLinkTypeId'
                                 hCitation[:identifiers] << hIdentifier
                              end

                              hResource[:resourceCitation] = hCitation
                              hMetadata[:associatedResources] << hResource

                           end

                        end
                     end

                     return hMetadata
                  end

               end

            end

         end
      end
   end
end
