# mdJson 2.0 writer - spatial reference system parameters

# History:
#   Stan Smith 2017-10-24 original script

require 'jbuilder'
require_relative 'mdJson_projectionParameters'
require_relative 'mdJson_geodeticParameters'
require_relative 'mdJson_verticalDatumParameters'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module SpatialReferenceParameters

               def self.build(hSystem)

                  Jbuilder.new do |json|
                     json.projection ProjectionParameters.build(hSystem[:projection]) unless hSystem[:projection].empty?
                     json.geodetic GeodeticParameters.build(hSystem[:geodetic]) unless hSystem[:geodetic].empty?
                     json.verticalDatum VerticalDatumParameters.build(hSystem[:verticalDatum]) unless hSystem[:verticalDatum].empty?
                  end

               end # build
            end # SpatialReferenceParameters

         end
      end
   end
end
