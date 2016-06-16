require 'jbuilder'
require_relative 'mdJson_base'
require_relative 'mdJson_attribute'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module Entity
          extend MdJson::Base

          def self.build(intObj)
            Jbuilder.new do |json|
              json.entityId intObj[:entityId]
              json.commonName intObj[:entityName]
              json.codeName intObj[:entityCode]
              json.alias intObj[:entityAlias]
              json.definition intObj[:entityDefinition]
              json.primaryKeyAttributeCodeName (intObj[:primaryKey])
              json.index(intObj[:indexes]) do |idx|
                json.codeName idx[:indexCode]
                json.allowDuplicates idx[:duplicate]
                json.attributeCodeName (idx[:attributeNames])
              end unless intObj[:indexes].empty?
              json.attribute json_map(intObj[:attributes], Attribute)
              json.foreignKey(intObj[:foreignKeys]) do |fk|
                json.localAttributeCodeName(fk[:fkLocalAttributes])
                json.referencedEntityCodeName fk[:fkReferencedEntity]
                json.referencedAttributeCodeName(fk[:fkReferencedAttributes])
              end unless intObj[:foreignKeys].empty?
            end
          end
        end
      end
    end
  end
end
