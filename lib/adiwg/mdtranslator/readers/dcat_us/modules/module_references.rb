# unpack references
# Reader - DCAT-US to internal data structure
# Maps 'references' URL array to metadata.additionalDocuments[].citation[].onlineResources[]

require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Dcat_us

            module References

               def self.unpack(hDataset, hMetadata, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  return hMetadata unless hDataset.has_key?('references')

                  references = hDataset['references']
                  return hMetadata if references.nil? || references.empty?

                  references.each do |ref_url|
                     next if ref_url.nil? || ref_url == ''

                     hAddDoc = intMetadataClass.newAdditionalDocumentation
                     hRefCitation = intMetadataClass.newCitation
                     hOlRes = intMetadataClass.newOnlineResource
                     hOlRes[:olResURI] = ref_url
                     hRefCitation[:onlineResources] << hOlRes
                     hAddDoc[:citation] << hRefCitation
                     hMetadata[:additionalDocuments] << hAddDoc
                  end

                  return hMetadata

               end

            end

         end
      end
   end
end
