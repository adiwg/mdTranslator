# unpack related items
# Reader - ScienceBase JSON to internal data structure

# History:
#   Stan Smith 2016-08-03 original script

require 'json'
require 'open-uri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module SbJson

            module RelatedItem

               def self.unpack(hSbJson, hMetadata, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  if hSbJson.has_key?('id')
                     sbId = hSbJson['id']
                     if sbId.nil? || sbId == ''
                        hResponseObj[:readerExecutionMessages] << 'ScienceBase id missing'
                        return {}
                     end
                  end

                  hRelatedItems = hSbJson['relatedItems']
                  linkAdd = nil
                  if hRelatedItems.has_key?('link')
                     hLink = hRelatedItems['link']
                     unless hLink.empty?
                        linkAdd = hLink['url']
                     end
                  end
                  return if linkAdd.nil?

                  linkAdd = linkAdd + '&format=json'
                  begin
                     web_contents = open(linkAdd, :read_timeout => 30) { |f| f.read }
                  rescue => readErr
                     hResponseObj[:readerExecutionMessages] << 'Failed reading ScienceBase relatedItems - see following message(s):\n'
                     hResponseObj[:readerExecutionMessages] << readErr.to_s.slice(0, 300)
                     return {}
                  else
                     # parse related items file
                     aItems = []
                     begin
                        aItems = JSON.parse(web_contents)
                     rescue JSON::JSONError => parseErr
                        hResponseObj[:readerExecutionMessages] << 'Parsing related links failed - see following message(s):\n'
                        hResponseObj[:readerExecutionMessages] << parseErr.to_s.slice(0, 300)
                        return {}
                     end

                     # process each returned item as a new associated resource
                     aItems.each do |hItem|
                        unless hItem.empty?
                           id = hItem['id']
                           itemId = hItem['itemId']
                           relatedItemId = hItem['relatedItemId']
                           itemLinkTypeId = hItem['itemLinkTypeId']

                           # determine relationship direction
                           forward = nil
                           if sbId == itemId
                              forward = true
                           elsif sbId == relatedItemId
                              forward = false
                           end
                           if forward.nil?
                              hResponseObj[:readerExecutionMessages] << 'ScienceBase id does not match a related item id'
                              return {}
                           end

                           hResource = intMetadataClass.newAssociatedResource

                           # determine resourceTypes

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
