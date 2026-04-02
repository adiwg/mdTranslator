# unpack modified date
# Reader - DCAT-US to internal data structure
# Maps 'modified' field to citation.dates with dateType='revision'

require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Dcat_us

            module Modified

               def self.unpack(hDataset, hCitation, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  if hDataset.has_key?('modified')
                     modified = hDataset['modified']
                     unless modified.nil? || modified == ''
                        hDate = intMetadataClass.newDate
                        hDate[:date] = modified
                        hDate[:dateType] = 'revision'
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
