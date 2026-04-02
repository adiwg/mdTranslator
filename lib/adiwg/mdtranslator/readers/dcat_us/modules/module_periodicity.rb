# unpack accrualPeriodicity
# Reader - DCAT-US to internal data structure
# Maps 'accrualPeriodicity' ISO 8601 repeating duration to
# metadataInfo.metadataMaintenance.frequency

require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Dcat_us

            module AccrualPeriodicity

               # Reverse mapping from ISO 8601 repeating duration to frequency label.
               # Matches the forward mapping used in the DCAT-US writer.
               ISO8601_TO_FREQ = {
                  'R/P10Y'   => 'decennial',
                  'R/P4Y'    => 'quadrennial',
                  'R/P3Y'    => 'triennial',
                  'R/P2Y'    => 'biennial',
                  'R/P1Y'    => 'annual',
                  'R/P6M'    => 'semiannual',
                  'R/P4M'    => 'three times a year',
                  'R/P3M'    => 'quarterly',
                  'R/P2M'    => 'bimonthly',
                  'R/P1M'    => 'monthly',
                  'R/P0.5M'  => 'semimonthly',
                  'R/P0.33M' => 'three times a month',
                  'R/P2W'    => 'biweekly',
                  'R/P1W'    => 'weekly',
                  'R/P3.5D'  => 'semiweekly',
                  'R/P0.33W' => 'three times a week',
                  'R/P1D'    => 'daily',
                  'R/PT1H'   => 'hourly',
                  'R/PT1S'   => 'continuously updated',
                  'irregular' => 'irregular'
               }.freeze

               def self.unpack(hDataset, hMetadataInfo, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  return hMetadataInfo unless hDataset.has_key?('accrualPeriodicity')

                  periodicity = hDataset['accrualPeriodicity']
                  return hMetadataInfo if periodicity.nil? || periodicity == ''

                  frequency = ISO8601_TO_FREQ[periodicity]

                  # If not recognised, store the raw ISO 8601 string as the frequency
                  frequency ||= periodicity

                  hMaintenance = intMetadataClass.newMaintenance
                  hMaintenance[:frequency] = frequency
                  hMetadataInfo[:metadataMaintenance] = hMaintenance

                  return hMetadataInfo

               end

            end

         end
      end
   end
end
