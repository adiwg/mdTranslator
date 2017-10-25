# mdJson 2.0 writer - spatial resolution

# History:
#  Stan Smith 2017-10-20 added coordinate resolution
#  Stan Smith 2017-10-20 added bearing distance resolution
#  Stan Smith 2017-10-20 added geographic resolution
#  Stan Smith 2017-03-15 original script

require 'jbuilder'
require_relative 'mdJson_measure'
require_relative 'mdJson_coordinateResolution'
require_relative 'mdJson_bearingDistanceResolution'
require_relative 'mdJson_geographicResolution'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module SpatialResolution

               def self.build(hResolution)

                  Jbuilder.new do |json|
                     json.scaleFactor hResolution[:scaleFactor]
                     json.measure Measure.build(hResolution[:measure]) unless hResolution[:measure].empty?
                     unless hResolution[:coordinateResolution].empty?
                        json.coordinateResolution CoordinateResolution.build(hResolution[:coordinateResolution])
                     end
                     unless hResolution[:bearingDistanceResolution].empty?
                        json.bearingDistanceResolution BearingDistanceResolution.build(hResolution[:bearingDistanceResolution])
                     end
                     unless hResolution[:geographicResolution].empty?
                        json.geographicResolution GeographicResolution.build(hResolution[:geographicResolution])
                     end
                     json.levelOfDetail hResolution[:levelOfDetail]
                  end

               end # build
            end # SpatialResolution

         end
      end
   end
end
