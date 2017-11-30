# unpack body / summary
# Reader - ScienceBase JSON to internal data structure

# History:
#  Stan Smith 2017-11-29 do not import short abstract
#  Stan Smith 2016-06-19 original script

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
                  # do not import short abstract
                  # sbJson forces summary to first 300 characters of abstract

                  return hResourceInfo

               end

            end

         end
      end
   end
end
