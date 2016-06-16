require 'jbuilder'
require_relative 'mdJson_citation'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module AdditionalDoc
          def self.build(intObj)
            Jbuilder.new do |json|
              json.resourceType intObj[:resourceType]
              json.citation Citation.build(intObj[:citation]) unless intObj[:citation].empty?
            end
          end
        end
      end
    end
  end
end
