# mdJson 2.0 writer - value range

# History:
#  Stan Smith 2017-11-01 original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module ValueRange

               def self.build(hRange)

                  Jbuilder.new do |json|
                     json.minRangeValue hRange[:minRangeValue]
                     json.maxRangeValue hRange[:maxRangeValue]
                  end

               end # build
            end # ValueRange

         end
      end
   end
end
