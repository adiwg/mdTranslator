# unpack distribution
# Reader - DCAT-US to internal data structure
# Maps 'distribution' array to metadata.distributorInfo

require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Dcat_us

            module Distribution

               def self.unpack(hDataset, hMetadata, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  return hMetadata unless hDataset.has_key?('distribution')

                  distributions = hDataset['distribution']
                  return hMetadata if distributions.nil? || distributions.empty?

                  distributions.each do |dist|
                     next if dist.nil? || dist.empty?

                     uri = dist['downloadURL'] || dist['accessURL']
                     # Include distributions that have at least a URL
                     next if uri.nil? || uri == ''

                     hDistribution = intMetadataClass.newDistribution
                     hDistribution[:description] = dist['description'] unless dist['description'].nil?

                     hDistributor = intMetadataClass.newDistributor
                     hTransferOption = intMetadataClass.newTransferOption

                     # Online option (URL + title)
                     hOnlineResource = intMetadataClass.newOnlineResource
                     hOnlineResource[:olResURI] = uri
                     hOnlineResource[:olResName] = dist['title'] unless dist['title'].nil?
                     hTransferOption[:onlineOptions] << hOnlineResource

                     # Media type stored in distributionFormats
                     media_type = dist['mediaType']
                     unless media_type.nil? || media_type == ''
                        hFormat = intMetadataClass.newResourceFormat
                        hFormatCitation = intMetadataClass.newCitation
                        hFormatCitation[:title] = media_type
                        hFormat[:formatSpecification] = hFormatCitation
                        hTransferOption[:distributionFormats] << hFormat
                     end

                     # Human-readable format description stored as transfer option note
                     format_str = dist['format']
                     unless format_str.nil? || format_str == ''
                        hTransferOption[:unitsOfDistribution] = format_str
                     end

                     # conformsTo for distribution stored in formatSpecification notes
                     conforms_to = dist['conformsTo']
                     unless conforms_to.nil? || conforms_to == ''
                        hTransferOption[:transferFrequency] = { conformsTo: conforms_to }
                     end

                     hDistributor[:transferOptions] << hTransferOption
                     hDistribution[:distributor] << hDistributor
                     hMetadata[:distributorInfo] << hDistribution
                  end

                  return hMetadata

               end

            end

         end
      end
   end
end
