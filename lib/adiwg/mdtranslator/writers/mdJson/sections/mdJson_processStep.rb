require 'jbuilder'
require_relative 'mdJson_base'
require_relative 'mdJson_responsibleParty'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module ProcessStep
          extend MdJson::Base

          def self.build(intObj)
            Jbuilder.new do |json|
              json.stepId intObj[:stepId]
              json.description intObj[:stepDescription]
              json.rationale intObj[:stepRationale]
              json.dateTime intObj[:stepDateTime][:dateTime] unless intObj[:stepDateTime].empty?
              json.processor json_map(intObj[:stepProcessors], ResponsibleParty)
            end
          end
        end
      end
    end
  end
end
