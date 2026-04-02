# unpack rights
# Reader - DCAT-US to internal data structure
# Maps 'rights' field to resourceInfo.constraints[type=use].releasability.statement

require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Dcat_us

            module Rights

               def self.unpack(hDataset, hResourceInfo, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  return hResourceInfo unless hDataset.has_key?('rights')

                  rights = hDataset['rights']
                  return hResourceInfo if rights.nil? || rights == ''

                  hConstraint = intMetadataClass.newConstraint
                  hConstraint[:type] = 'use'
                  hRelease = intMetadataClass.newRelease
                  hRelease[:statement] = rights
                  hConstraint[:releasability] = hRelease
                  hResourceInfo[:constraints] << hConstraint

                  return hResourceInfo

               end

            end

         end
      end
   end
end
