# unpack id
# Reader - ScienceBase JSON to internal data structure

# History:
#   Stan Smith 2016-06-14 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module SbJson

            module Id

               def self.unpack(hSbJson, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  if hSbJson.has_key?('id')
                     hIdentifier = intMetadataClass.newIdentifier

                     sbId = hSbJson['id']
                     unless sbId.nil? || sbId == ''
                        hIdentifier[:identifier] = sbId
                        hIdentifier[:namespace] = 'gov.sciencebase.catalog'
                        hIdentifier[:description] = 'USGS ScienceBase Identifier'
                        return hIdentifier
                     end
                  end

                  return nil

               end

            end

         end
      end
   end
end
