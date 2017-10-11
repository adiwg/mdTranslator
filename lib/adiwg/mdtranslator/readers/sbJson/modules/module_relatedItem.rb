# unpack related items
# Reader - ScienceBase JSON to internal data structure

# History:
#  Stan Smith 2017-10-11 revise forward and reverse association definition
#  Stan Smith 2017-09-14 remove all identifiers except relatedItemId
#  Stan Smith 2017-08-03 original script

require 'json'
require 'open-uri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_codelists'
require_relative 'module_browseCategory'

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
                           # forward: how the associated resource relates to the main resource
                           # ... in other words - the relationship is defined in terms of the associated resource
                           # ... example: the associated resource is a 'subProject' of the main resource
                           # reverse: how the main resource relates to the associated resource
                           # ... in other words - the relationship is defined in terms of the main resource
                           # ... example: the main resource is the 'parentProject' of the associated resource
                           # all mdJson/mdTranslator relationships must be expressed as forward
                           forward = nil
                           if hItem.has_key?('itemId')
                              forward = false if sbId == hItem['itemId']
                           end
                           if hItem.has_key?('relatedItemId')
                              forward = true if sbId == hItem['relatedItemId']
                           end
                           if forward.nil?
                              hResponseObj[:readerExecutionMessages] << 'Main ScienceBase id was not referenced in related item'
                              return hMetadata
                           end

                           # fetch resourceTypes from related item's record
                           if forward
                              resourceId = hItem['itemId']
                           else
                              resourceId = hItem['relatedItemId']
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

                              # add resource types
                              BrowseCategory.unpack(hRelatedItem, hResource[:resourceTypes], hResponseObj)

                              # add association type
                              if hItem.has_key?('type')
                                 sbAssocType = hItem['type']
                                 unless sbAssocType.nil? || sbAssocType == ''
                                    assocType = nil
                                    if forward
                                       assocType = Codelists.codelist_sb2adiwg('association_sb2adiwg_assoc2main', sbAssocType)
                                    else
                                       assocType = Codelists.codelist_sb2adiwg('association_sb2adiwg_main2assoc', sbAssocType)
                                    end
                                    if assocType.nil?
                                       hResource[:associationType] = sbAssocType
                                    else
                                       hResource[:associationType] = assocType
                                    end
                                 end
                              end
                              if hResource[:associationType].nil?
                                 hResource[:associationType] = 'missing'
                              end

                              # fill in associated resource citation
                              hCitation = intMetadataClass.newCitation
                              citationTitle = 'associated resource title'
                              if forward
                                 if hItem.has_key?('title')
                                    citationTitle = hItem['title']
                                 end
                              else
                                 if hItem.has_key?('relatedItemTitle')
                                    citationTitle = hItem['relatedItemTitle']
                                 end
                              end
                              hCitation[:title] = citationTitle

                              # create an identifier for the related item
                              # use resourceId computed above
                              hIdentifier = intMetadataClass.newIdentifier
                              hIdentifier[:identifier] = resourceId
                              hIdentifier[:namespace] = 'gov.sciencebase.catalog'
                              hIdentifier[:description] = 'relatedItemId'
                              hCitation[:identifiers] << hIdentifier

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
