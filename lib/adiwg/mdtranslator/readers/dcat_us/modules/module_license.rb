# unpack license
# Reader - DCAT-US to internal data structure
# Maps 'license' field to resourceInfo.constraints[].reference[].title

require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Dcat_us

            module License

               def self.unpack(hDataset, hResourceInfo, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  return hResourceInfo unless hDataset.has_key?('license')

                  license = hDataset['license']
                  return hResourceInfo if license.nil? || license == ''

                  hConstraint = intMetadataClass.newConstraint
                  hConstraint[:type] = 'use'
                  hRefCitation = intMetadataClass.newCitation
                  hRefCitation[:title] = license
                  hConstraint[:reference] << hRefCitation
                  hResourceInfo[:constraints] << hConstraint

                  return hResourceInfo

               end

            end

         end
      end
   end
end
