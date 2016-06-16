require 'jbuilder'
require_relative 'mdJson_citation'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module ResourceIdentifier
          def self.build(ident)
            Jbuilder.new do |json|
              json.identifier ident[:identifier]
              json.namespace ident[:identifierNamespace]
              json.version ident[:identifierVersion]
              json.description ident[:identifierDescription]
              json.type ident[:identifierType]
              json.authority Citation.build(ident[:identifierCitation]) unless ident[:identifierCitation].empty?
            end
          end
        end
      end
    end
  end
end
