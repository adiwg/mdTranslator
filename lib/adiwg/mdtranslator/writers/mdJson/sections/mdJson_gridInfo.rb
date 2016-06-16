require 'jbuilder'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module GridInfo
          def self.build(intObj)
            Jbuilder.new do |json|
              json.numberOfDimensions intObj[:dimensions]
              json.dimension(intObj[:dimensionInfo]) do |dim|
                  json.dimensionType dim[:dimensionType]
                  json.dimensionSize dim[:dimensionSize]
                  json.resolution dim[:resolution]
                  json.resolutionUnit dim[:resolutionUnits]
                  json.dimensionTitle dim[:dimensionTitle]
                  json.dimensionDescription dim[:dimensionDescription]
              end
              json.cellGeometry intObj[:dimensionGeometry]
              json.transformationParameterAvailability intObj[:dimensionTransformParams]
            end
          end
        end
      end
    end
  end
end
