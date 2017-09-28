# mdJson 2.0 writer - bounding box

# History:
#  Stan Smith 2017-09-08 add altitude to support fgdc
#  Stan Smith 2017-03-15 original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module BoundingBox

               def self.build(hBbox)

                  Jbuilder.new do |json|
                     json.westLongitude hBbox[:westLongitude]
                     json.eastLongitude hBbox[:eastLongitude]
                     json.southLatitude hBbox[:southLatitude]
                     json.northLatitude hBbox[:northLatitude]
                     json.minimumAltitude hBbox[:minimumAltitude]
                     json.maximumAltitude hBbox[:maximumAltitude]
                     json.unitsOfAltitude hBbox[:unitsOfAltitude]
                  end

               end # build
            end # BoundingBox

         end
      end
   end
end
