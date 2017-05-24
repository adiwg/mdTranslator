# mdJson 2.0 writer - citation

# History:
#   Stan Smith 2017-03-20 original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module DateTime

               def self.build(hDateTime)

                  return AdiwgDateTimeFun.stringFromDateObject(hDateTime)

               end # build
            end # DateTime

         end
      end
   end
end
