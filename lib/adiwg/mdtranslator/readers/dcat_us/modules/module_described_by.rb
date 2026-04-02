# unpack describedBy / describedByType
# Reader - DCAT-US to internal data structure
# Maps 'describedBy' URL to dataDictionaries[].citation.onlineResources[].olResURI
# Maps 'describedByType' to the olResProtocol of the same online resource

require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Dcat_us

            module DescribedBy

               def self.unpack(hDataset, aDataDictionaries, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  return aDataDictionaries unless hDataset.has_key?('describedBy')

                  described_by = hDataset['describedBy']
                  return aDataDictionaries if described_by.nil? || described_by == ''

                  described_by_type = hDataset['describedByType']

                  hDataDictionary = intMetadataClass.newDataDictionary
                  hDataDictionary[:includedWithDataset] = false

                  hDictCitation = intMetadataClass.newCitation
                  hOlRes = intMetadataClass.newOnlineResource
                  hOlRes[:olResURI] = described_by
                  hOlRes[:olResProtocol] = described_by_type unless described_by_type.nil? || described_by_type == ''
                  hDictCitation[:onlineResources] << hOlRes

                  hDataDictionary[:citation] = hDictCitation
                  aDataDictionaries << hDataDictionary

                  return aDataDictionaries

               end

            end

         end
      end
   end
end
