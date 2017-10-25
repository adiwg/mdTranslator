# mdJson 2.0 writer - spatial reference system vertical datum parameters

# History:
#   Stan Smith 2017-10-24 original script

require 'jbuilder'
require_relative 'mdJson_identifier'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module VerticalDatumParameters

               def self.build(hDatum)

                  Jbuilder.new do |json|
                     json.datumIdentifier Identifier.build(hDatum[:datumIdentifier]) unless hDatum[:datumIdentifier].empty?
                     json.encodingMethod hDatum[:encodingMethod]
                     json.isDepthSystem hDatum[:isDepthSystem]
                     json.verticalResolution hDatum[:verticalResolution]
                     json.unitOfMeasure hDatum[:unitOfMeasure]
                  end

               end # build
            end # VerticalDatumParameters

         end
      end
   end
end
