# unpack purpose
# Reader - ScienceBase JSON to internal data structure

# History:
#   Stan Smith 2016-06-19 original script

module ADIWG
   module Mdtranslator
      module Readers
         module SbJson

            module Purpose

               def self.unpack(hSbJson, hResourceInfo, hResponseObj)

                  if hSbJson.has_key?('purpose')
                     sbPurpose = hSbJson['purpose']
                     unless sbPurpose.nil? || sbPurpose == ''
                        hResourceInfo[:purpose] = sbPurpose
                     end
                  end

                  return hResourceInfo

               end

            end

         end
      end
   end
end
