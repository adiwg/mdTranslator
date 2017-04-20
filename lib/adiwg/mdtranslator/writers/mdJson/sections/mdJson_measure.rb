# mdJson 2.0 writer - measure

# History:
#   Stan Smith 2017-03-14 original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Measure

               def self.build(hMeasure)

                  Jbuilder.new do |json|
                     json.type hMeasure[:type]
                     json.value hMeasure[:value]
                     json.unitOfMeasure hMeasure[:unitOfMeasure]
                  end

               end # build
            end # Measure

         end
      end
   end
end
