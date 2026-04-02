# unpack accessLevel
# Reader - DCAT-US to internal data structure
# Maps 'accessLevel' field to resourceInfo.constraints[type=legal].legalConstraint.accessCodes
#
# DCAT-US values are mapped to ISO MD_RestrictionCode equivalents for round-trip compatibility:
#   "public"            -> "unclassified"
#   "restricted public" -> "sensitiveButUnclassified"
#   "non-public"        -> "restricted"

require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Dcat_us

            module AccessLevel

               ACCESS_CODE_MAP = {
                  'public'            => 'unclassified',
                  'restricted public' => 'sensitiveButUnclassified',
                  'non-public'        => 'restricted'
               }.freeze

               def self.unpack(hDataset, hResourceInfo, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  return hResourceInfo unless hDataset.has_key?('accessLevel')

                  access_level = hDataset['accessLevel']
                  return hResourceInfo if access_level.nil? || access_level == ''

                  iso_code = ACCESS_CODE_MAP[access_level.downcase] || access_level

                  hConstraint = intMetadataClass.newConstraint
                  hConstraint[:type] = 'legal'
                  hLegal = intMetadataClass.newLegalConstraint
                  hLegal[:accessCodes] << iso_code
                  hConstraint[:legalConstraint] = hLegal
                  hResourceInfo[:constraints] << hConstraint

                  return hResourceInfo

               end

            end

         end
      end
   end
end
