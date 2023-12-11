# mdJson 2.0 writer - grid representation

# History:
#   Stan Smith 2017-03-14 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'
require_relative 'mdJson_dimension'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Grid

               def self.build(hGrid)

                  @Namespace = ADIWG::Mdtranslator::Writers::MdJson

                  Jbuilder.new do |json|
                     json.scope hGrid[:scope]
                     json.numberOfDimensions hGrid[:numberOfDimensions]
                     json.dimension @Namespace.json_map(hGrid[:dimension], Dimension)
                     json.cellGeometry hGrid[:cellGeometry]
                     json.transformationParameterAvailable hGrid[:transformationParameterAvailable]
                  end

               end # build
            end # Grid

         end
      end
   end
end
