# unpack systemOfRecords
# Reader - DCAT-US to internal data structure
# Maps 'systemOfRecords' URL to metadata.associatedResources[initiativeType=sorn]

require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Dcat_us

            module SystemOfRecords

               def self.unpack(hDataset, hMetadata, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  return hMetadata unless hDataset.has_key?('systemOfRecords')

                  sorn_url = hDataset['systemOfRecords']
                  return hMetadata if sorn_url.nil? || sorn_url == ''

                  hAssociated = intMetadataClass.newAssociatedResource
                  hAssociated[:initiativeType] = 'sorn'

                  hSornCitation = intMetadataClass.newCitation
                  hOlRes = intMetadataClass.newOnlineResource
                  hOlRes[:olResURI] = sorn_url
                  hSornCitation[:onlineResources] << hOlRes

                  hAssociated[:resourceCitation] = hSornCitation
                  hMetadata[:associatedResources] << hAssociated

                  return hMetadata

               end

            end

         end
      end
   end
end
