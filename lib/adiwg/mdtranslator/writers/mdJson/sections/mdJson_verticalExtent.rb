# mdJson 2.0 writer - temporal extent

# History:
#   Stan Smith 2017-03-15 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

# TODO complete tests

require 'jbuilder'
require_relative 'mdJson_spatialReference'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module VerticalExtent

               def self.build(hVertical)

                  Jbuilder.new do |json|
                     json.description hVertical[:description]
                     json.minValue hVertical[:minValue]
                     json.maxValue hVertical[:maxValue]
                     json.crsId SpatialReference.build(hVertical[:crsId]) unless hVertical[:crsId].empty?
                  end

               end # build
            end # VerticalExtent

         end
      end
   end
end
