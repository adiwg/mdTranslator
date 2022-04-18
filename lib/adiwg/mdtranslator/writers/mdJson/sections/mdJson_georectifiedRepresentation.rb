# mdJson 2.0 writer - georectified representation

# History:
#   Stan Smith 2017-03-14 original script

require 'jbuilder'
require_relative 'mdJson_gridRepresentation'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Georectified

               def self.build(hGeoRec)

                  Jbuilder.new do |json|
                     json.gridRepresentation Grid.build(hGeoRec[:gridRepresentation]) unless hGeoRec[:gridRepresentation].empty?
                     json.checkPointAvailable hGeoRec[:checkPointAvailable]
                     json.checkPointDescription hGeoRec[:checkPointDescription]
                     json.cornerPoints hGeoRec[:cornerPoints] unless hGeoRec[:cornerPoints].empty?
                     json.centerPoint hGeoRec[:centerPoint] unless hGeoRec[:centerPoint].empty?
                     json.pointInPixel hGeoRec[:pointInPixel]
                     json.transformationDimensionDescription hGeoRec[:transformationDimensionDescription]
                     json.transformationDimensionMapping hGeoRec[:transformationDimensionMapping]
                     json.scope hGeoRec[:scope]
                  end

               end # build
            end # Georectified

         end
      end
   end
end
