# mdJson 2.0 writer - geographic resolution

# History:
#   Stan Smith 2017-10-20 original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module GeographicResolution

               def self.build(hGeoRes)

                  Jbuilder.new do |json|
                     json.latitudeResolution hGeoRes[:latitudeResolution]
                     json.longitudeResolution hGeoRes[:longitudeResolution]
                     json.unitOfMeasure hGeoRes[:unitOfMeasure]
                  end

               end # build
            end # GeographicResolution

         end
      end
   end
end
