# unpack issued date
# Reader - DCAT-US to internal data structure
# Maps 'issued' field to citation.dates with dateType='creation'

require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Dcat_us

            module Issued

               def self.unpack(hDataset, hCitation, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  if hDataset.has_key?('issued')
                     issued = hDataset['issued']
                     unless issued.nil? || issued == ''
                        hDate = intMetadataClass.newDate
                        hDate[:date] = issued
                        hDate[:dateType] = 'creation'
                        hCitation[:dates] << hDate
                     end
                  end

                  return hCitation

               end

            end

         end
      end
   end
end
