# mdJson 2.0 writer - entity attribute

# History:
#   Stan Smith 2017-03-19 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module EntityAttribute

               def self.build(hAttribute)

                  Jbuilder.new do |json|
                     json.commonName hAttribute[:attributeName]
                     json.codeName hAttribute[:attributeCode]
                     json.alias hAttribute[:attributeAlias] unless hAttribute[:attributeAlias].empty?
                     json.definition hAttribute[:attributeDefinition]
                     json.dataType hAttribute[:dataType]
                     json.allowNull hAttribute[:allowNull]
                     json.allowMany hAttribute[:allowMany]
                     json.units hAttribute[:unitOfMeasure]
                     json.domainId hAttribute[:domainId]
                     json.minValue hAttribute[:minValue]
                     json.maxValue hAttribute[:maxValue]
                  end

               end # build
            end # EntityAttribute
         end
      end
   end
end
