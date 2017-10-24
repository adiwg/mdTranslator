# mdJson 2.0 writer - spatial reference system ellipsoid parameters

# History:
#   Stan Smith 2017-10-24 original script

require 'jbuilder'
require_relative 'mdJson_identifier'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module EllipsoidParameters

               def self.build(hEllipsoid)

                  Jbuilder.new do |json|
                     json.ellipsoidIdentifier Identifier.build(hEllipsoid[:ellipsoidIdentifier]) unless hEllipsoid[:ellipsoidIdentifier].empty?
                     json.ellipsoidName hEllipsoid[:ellipsoidName]
                     json.semiMajorAxis hEllipsoid[:semiMajorAxis]
                     json.axisUnits hEllipsoid[:axisUnits]
                     json.denominatorOfFlatteningRatio hEllipsoid[:denominatorOfFlatteningRatio]
                  end

               end # build
            end # EllipsoidParameters

         end
      end
   end
end
