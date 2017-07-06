# unpack parent id
# Reader - ScienceBase JSON to internal data structure

# History:
#   Stan Smith 2016-06-21 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module SbJson

            module ParentId

               def self.unpack(hSbJson, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  if hSbJson.has_key?('parentId')
                     sbId = hSbJson['parentId']
                     unless sbId.nil? || sbId == ''
                        hCitation = intMetadataClass.newCitation
                        hIdentifier = intMetadataClass.newIdentifier
                        hCitation[:title] = 'U.S. Geological Survey ScienceBase parent identifier'
                        hIdentifier[:identifier] = sbId
                        hIdentifier[:namespace] = 'gov.sciencebase.catalog'
                        hIdentifier[:description] = 'USGS ScienceBase Identifier'
                        hCitation[:identifiers] << hIdentifier
                        return hCitation
                     end
                  end

                  return nil

               end

            end

         end
      end
   end
end
