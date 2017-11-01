# mdJson 2.0 writer - entity

# History:
#  Stan Smith 2017-11-01 add new elements to support fgdc
#  Stan Smith 2017-03-19 original script

require 'jbuilder'
require_relative 'mdJson_citation'
require_relative 'mdJson_entityAttribute'
require_relative 'mdJson_entityIndex'
require_relative 'mdJson_entityForeignKey'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Entity

               @Namespace = ADIWG::Mdtranslator::Writers::MdJson

               def self.build(hEntity)

                  Jbuilder.new do |json|
                     json.entityId hEntity[:entityId]
                     json.commonName hEntity[:entityName]
                     json.codeName hEntity[:entityCode]
                     json.alias hEntity[:entityAlias] unless hEntity[:entityAlias].empty?
                     json.definition hEntity[:entityDefinition]
                     json.entityReference @Namespace.json_map(hEntity[:entityReferences], Citation)
                     json.primaryKeyAttributeCodeName hEntity[:primaryKey] unless hEntity[:primaryKey].empty?
                     json.index @Namespace.json_map(hEntity[:indexes], EntityIndex)
                     json.attribute @Namespace.json_map(hEntity[:attributes], EntityAttribute)
                     json.foreignKey @Namespace.json_map(hEntity[:foreignKeys], EntityForeignKey)
                     json.fieldSeparatorCharacter hEntity[:fieldSeparatorCharacter]
                     json.numberOfHeaderLines hEntity[:numberOfHeaderLines]
                     json.quoteCharacter hEntity[:quoteCharacter]
                  end

               end # build
            end # Entity

         end
      end
   end
end
