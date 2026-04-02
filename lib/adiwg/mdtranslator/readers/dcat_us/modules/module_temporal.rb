# unpack temporal
# Reader - DCAT-US to internal data structure
# Maps 'temporal' field to resourceInfo.extents[].temporalExtents[].timePeriod
#
# DCAT-US temporal format: ISO 8601 interval "start/end"
# Examples:
#   "2000-01-15T00:45:00Z/2010-01-15T00:06:00Z"
#   "2000-01-15T00:45:00Z/P1W"
#   "2000-01-15"

require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Dcat_us

            module Temporal

               def self.unpack(hDataset, hResourceInfo, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  return hResourceInfo unless hDataset.has_key?('temporal')

                  temporal = hDataset['temporal']
                  return hResourceInfo if temporal.nil? || temporal == ''

                  # Add to existing extent if one exists, otherwise create a new one
                  if hResourceInfo[:extents].empty?
                     hExtent = intMetadataClass.newExtent
                     hResourceInfo[:extents] << hExtent
                  else
                     hExtent = hResourceInfo[:extents][0]
                  end

                  hTemporalExtent = intMetadataClass.newTemporalExtent
                  hTimePeriod = intMetadataClass.newTimePeriod

                  parts = temporal.split('/')
                  start_str = parts[0]
                  end_str   = parts[1]

                  unless start_str.nil? || start_str == ''
                     hStartDateTime = intMetadataClass.newDateTime
                     hStartDateTime[:dateTime] = start_str
                     hTimePeriod[:startDateTime] = hStartDateTime
                  end

                  unless end_str.nil? || end_str == ''
                     hEndDateTime = intMetadataClass.newDateTime
                     hEndDateTime[:dateTime] = end_str
                     hTimePeriod[:endDateTime] = hEndDateTime
                  end

                  hTemporalExtent[:timePeriod] = hTimePeriod
                  hExtent[:temporalExtents] << hTemporalExtent

                  return hResourceInfo

               end

            end

         end
      end
   end
end
