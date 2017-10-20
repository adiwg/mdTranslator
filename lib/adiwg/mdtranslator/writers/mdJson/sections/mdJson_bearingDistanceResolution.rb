# mdJson 2.0 writer - bearing distance resolution

# History:
#   Stan Smith 2017-10-20 original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module BearingDistanceResolution

               def self.build(hBearRes)

                  Jbuilder.new do |json|
                     json.distanceResolution hBearRes[:distanceResolution]
                     json.distanceUnitOfMeasure hBearRes[:distanceUnitOfMeasure]
                     json.bearingResolution hBearRes[:bearingResolution]
                     json.bearingUnitOfMeasure hBearRes[:bearingUnitOfMeasure]
                     json.bearingReferenceDirection hBearRes[:bearingReferenceDirection]
                     json.bearingReferenceMeridian hBearRes[:bearingReferenceMeridian]
                  end

               end # build
            end # BearingDistanceResolution

         end
      end
   end
end
