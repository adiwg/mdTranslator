# unpack id
# Reader - ScienceBase JSON to internal data structure

# History:
#   Stan Smith 2016-06-14 original script

module ADIWG
   module Mdtranslator
      module Readers
         module SbJson

            module Id

               def self.unpack(hSbJson, hIdentifier, hResponseObj)

                  # title
                  if hSbJson.has_key?('id')
                     sbId = hSbJson['id']
                     unless sbId.nil? || sbId == ''
                        hIdentifier[:identifier] = sbId
                        hIdentifier[:namespace] = 'gov.sciencebase.catalog'
                        hIdentifier[:description] = 'USGS ScienceBase Identifier'
                     end
                  end

                  return hIdentifier

               end

            end

         end
      end
   end
end
