# mdJson 2.0 writer - spatial reference system ellipsoid parameters

# History:
#   Stan Smith 2017-10-24 original script

require 'jbuilder'
require_relative 'mdJson_identifier'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module GeodeticParameters

               def self.build(hGeodetic)

                  Jbuilder.new do |json|
                     json.datumIdentifier Identifier.build(hGeodetic[:datumIdentifier]) unless hGeodetic[:datumIdentifier].empty?
                     json.datumName hGeodetic[:datumName]
                     json.ellipsoidIdentifier Identifier.build(hGeodetic[:ellipsoidIdentifier]) unless hGeodetic[:ellipsoidIdentifier].empty?
                     json.ellipsoidName hGeodetic[:ellipsoidName]
                     json.semiMajorAxis hGeodetic[:semiMajorAxis]
                     json.axisUnits hGeodetic[:axisUnits]
                     json.denominatorOfFlatteningRatio hGeodetic[:denominatorOfFlatteningRatio]
                  end

               end # build
            end # EllipsoidParameters

         end
      end
   end
end
