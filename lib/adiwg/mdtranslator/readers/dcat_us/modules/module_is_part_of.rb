# unpack isPartOf
# Reader - DCAT-US to internal data structure
# Maps 'isPartOf' URL to metadata.associatedResources[initiativeType=collection]

require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Dcat_us

            module IsPartOf

               def self.unpack(hDataset, hMetadata, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  return hMetadata unless hDataset.has_key?('isPartOf')

                  is_part_of = hDataset['isPartOf']
                  return hMetadata if is_part_of.nil? || is_part_of == ''

                  hAssociated = intMetadataClass.newAssociatedResource
                  hAssociated[:initiativeType] = 'collection'
                  hAssociated[:associationType] = 'collectiveTitle'

                  hCollCitation = intMetadataClass.newCitation
                  hOlRes = intMetadataClass.newOnlineResource
                  hOlRes[:olResURI] = is_part_of
                  hCollCitation[:onlineResources] << hOlRes

                  hAssociated[:resourceCitation] = hCollCitation
                  hMetadata[:associatedResources] << hAssociated

                  return hMetadata

               end

            end

         end
      end
   end
end
