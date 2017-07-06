# unpack identifier
# Reader - ScienceBase JSON to internal data structure

# History:
#   Stan Smith 2016-06-19 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module SbJson

            module Identifier

               def self.unpack(hSbJson, hCitation, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  if hSbJson.has_key?('identifiers')
                     hSbJson['identifiers'].each_with_index do |hSbIdentifier, i|
                        hIdentifier = intMetadataClass.newIdentifier

                        unless hSbIdentifier['type'].nil? || hSbIdentifier['type'] == ''
                           hIdentifier[:description] = hSbIdentifier['type']
                        end
                        unless hSbIdentifier['scheme'].nil? || hSbIdentifier['scheme'] == ''
                           hIdentifier[:namespace] = hSbIdentifier['scheme']
                        end
                        unless hSbIdentifier['key'].nil? || hSbIdentifier['key'] == ''
                           hIdentifier[:identifier] = hSbIdentifier['key']
                        end

                        hCitation[:identifiers] << hIdentifier
                     end
                  end

                  return hCitation

               end

            end

         end
      end
   end
end
