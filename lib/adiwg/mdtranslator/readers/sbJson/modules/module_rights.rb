# unpack rights
# Reader - ScienceBase JSON to internal data structure

# History:
#   Stan Smith 2016-06-19 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module SbJson

            module Rights

               def self.unpack(hSbJson, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  hConstraint = intMetadataClass.newConstraint
                  hLegal = intMetadataClass.newLegalConstraint

                  if hSbJson.has_key?('rights')
                     sbRights = hSbJson['rights']
                     unless sbRights.nil? || sbRights == ''
                        hConstraint[:type] = 'legal'
                        hLegal[:otherCons][0] = sbRights
                        hConstraint[:legalConstraint] = hLegal
                        return hConstraint
                     end
                  end

                  return nil

               end

            end

         end
      end
   end
end
