require 'jbuilder'
require_relative 'mdJson_citation'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module AssociatedResource
          def self.build(intObj)
            Jbuilder.new do |json|
              json.associationType intObj[:associationType]
              json.initiativeType intObj[:initiativeType]
              json.resourceType intObj[:resourceType]
              json.resourceCitation Citation.build(intObj[:resourceCitation]) unless intObj[:resourceCitation].empty?
              json.metadataCitation Citation.build(intObj[:metadataCitation]) unless intObj[:metadataCitation].empty?
            end
          end
        end
      end
    end
  end
end
