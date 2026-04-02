# unpack identifier
# Reader - DCAT-US to internal data structure
# Maps 'identifier' field to citation.onlineResources and citation.identifiers

require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Dcat_us

            module Identifier

               def self.unpack(hDataset, hCitation, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  return hCitation unless hDataset.has_key?('identifier')

                  identifier = hDataset['identifier']
                  return hCitation if identifier.nil? || identifier == ''

                  # Store as an online resource in the citation
                  hOlRes = intMetadataClass.newOnlineResource
                  hOlRes[:olResURI] = identifier
                  hCitation[:onlineResources] << hOlRes

                  # If the identifier contains 'doi', also store as a named identifier
                  if identifier.downcase.include?('doi')
                     hId = intMetadataClass.newIdentifier
                     hId[:identifier] = identifier
                     hId[:namespace] = 'DOI'
                     hCitation[:identifiers] << hId
                  end

                  return hCitation

               end

            end

         end
      end
   end
end
