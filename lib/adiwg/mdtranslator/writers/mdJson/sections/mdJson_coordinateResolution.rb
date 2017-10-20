# mdJson 2.0 writer - coordinate resolution

# History:
#   Stan Smith 2017-10-20 original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module CoordinateResolution

               def self.build(hCoordRes)

                  Jbuilder.new do |json|
                     json.abscissaResolutionX hCoordRes[:abscissaResolutionX]
                     json.ordinateResolutionY hCoordRes[:ordinateResolutionY]
                     json.unitOfMeasure hCoordRes[:unitOfMeasure]
                  end

               end # build
            end # CoordinateResolution

         end
      end
   end
end
