# mdJson 2.0 writer - entity attribute

# History:
#  Stan Smith 2017-11-01 added new elements to support fgdc
#  Stan Smith 2017-03-19 refactored for mdJson/mdTranslator 2.0
#  Josh Bradley original script

require 'jbuilder'
require_relative 'mdJson_citation'
require_relative 'mdJson_valueRange'
require_relative 'mdJson_timePeriod'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module EntityAttribute

               @Namespace = ADIWG::Mdtranslator::Writers::MdJson

               def self.build(hAttribute)

                  Jbuilder.new do |json|
                     json.commonName hAttribute[:attributeName]
                     json.codeName hAttribute[:attributeCode]
                     json.alias hAttribute[:attributeAlias] unless hAttribute[:attributeAlias].empty?
                     json.definition hAttribute[:attributeDefinition]
                     unless hAttribute[:attributeReference].empty?
                        json.attributeReference Citation.build(hAttribute[:attributeReference])
                     end
                     json.dataType hAttribute[:dataType]
                     json.allowNull hAttribute[:allowNull]
                     json.allowMany hAttribute[:allowMany]
                     json.units hAttribute[:unitOfMeasure]
                     json.unitsResolution hAttribute[:measureResolution]
                     json.isCaseSensitive hAttribute[:isCaseSensitive]
                     json.fieldWidth hAttribute[:fieldWidth]
                     json.missingValue hAttribute[:missingValue]
                     json.domainId hAttribute[:domainId]
                     json.minValue hAttribute[:minValue]
                     json.maxValue hAttribute[:maxValue]
                     json.rangeOfValues @Namespace.json_map(hAttribute[:rangeOfValues], ValueRange)
                     json.timePeriodOfValues @Namespace.json_map(hAttribute[:timePeriodOfValues], TimePeriod)

                  end

               end # build
            end # EntityAttribute
         end
      end
   end
end
