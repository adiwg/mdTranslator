require 'jbuilder'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module Domain
          def self.build(intObj)
            Jbuilder.new do |json|
              json.domainId(intObj[:domainId])
              json.commonName intObj[:domainName]
              json.codeName intObj[:domainCode]
              json.description intObj[:domainDescription]
              json.member(intObj[:domainItems]) do |mem|
                  json.name mem[:itemName]
                  json.value mem[:itemValue]
                  json.definition mem[:itemDefinition]
              end unless intObj[:domainItems].empty?
            end
          end
        end
      end
    end
  end
end
