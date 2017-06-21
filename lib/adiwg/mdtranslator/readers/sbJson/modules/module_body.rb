# unpack body / summary
# Reader - ScienceBase JSON to internal data structure

# History:
#   Stan Smith 2016-06-19 original script

module ADIWG
   module Mdtranslator
      module Readers
         module SbJson

            module Body

               def self.unpack(hSbJson, hResourceInfo, hResponseObj)

                  # body
                  if hSbJson.has_key?('body')
                     sbAbstract = hSbJson['body']
                     unless sbAbstract.nil? || sbAbstract == ''
                        hResourceInfo[:abstract] = sbAbstract
                     end
                  end

                  # summary
                  if hSbJson.has_key?('summary')
                     sbShort = hSbJson['summary']
                     unless sbShort.nil? || sbShort == ''
                        hResourceInfo[:shortAbstract] = sbShort
                     end
                  end

                  return hResourceInfo

               end

            end

         end
      end
   end
end
