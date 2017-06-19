# unpack citation
# Reader - ScienceBase JSON to internal data structure

# History:
#   Stan Smith 2016-06-19 original script

module ADIWG
   module Mdtranslator
      module Readers
         module SbJson

            module Citation

               def self.unpack(hSbJson, hCitation, hResponseObj)

                  if hSbJson.has_key?('citation')
                     sbCitation = hSbJson['citation']
                     unless sbCitation.nil? || sbCitation == ''
                        hCitation[:otherDetails][0] = sbCitation
                     end
                  end

                  return hCitation

               end

            end

         end
      end
   end
end
