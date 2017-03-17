require 'jbuilder'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module EntityAttribute
          def self.build(intObj)
            Jbuilder.new do |json|
              json.commonName intObj[:attributeName]
              json.codeName intObj[:attributeCode]
              json.alias (intObj[:attributeAlias])
              json.definition intObj[:attributeDefinition]
              json.dataType intObj[:dataType]
              json.allowNull intObj[:allowNull]
              json.units intObj[:unitOfMeasure]
              json.domainId intObj[:domainId]
              json.minValue intObj[:minValue]
              json.maxValue intObj[:maxValue]

            end
          end
        end
      end
    end
  end
end
