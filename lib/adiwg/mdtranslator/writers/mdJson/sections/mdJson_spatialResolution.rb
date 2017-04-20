# mdJson 2.0 writer - spatial resolution

# History:
#   Stan Smith 2017-03-15 original script

require 'jbuilder'
require_relative 'mdJson_measure'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module SpatialResolution

               def self.build(hResolution)

                  Jbuilder.new do |json|
                     json.scaleFactor hResolution[:scaleFactor]
                     json.measure Measure.build(hResolution[:measure]) unless hResolution[:measure].empty?
                     json.levelOfDetail hResolution[:levelOfDetail]
                  end

               end # build
            end # SpatialResolution

         end
      end
   end
end
