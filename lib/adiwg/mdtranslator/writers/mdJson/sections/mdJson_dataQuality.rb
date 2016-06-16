require 'jbuilder'
require_relative 'mdJson_base'
require_relative 'mdJson_citation'
require_relative 'mdJson_processStep'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module DataQuality
          extend MdJson::Base

          def self.build(intObj)
            Jbuilder.new do |json|
              json.scope intObj[:dataScope]
              json.lineage do
                  ln = intObj[:dataLineage]
                  json.statement ln[:statement]
                  json.processStep json_map(ln[:processSteps], ProcessStep)
                  json.source(ln[:dataSources]) do |src|
                      json.description src[:sourceDescription]
                      json.citation Citation.build(src[:sourceCitation]) unless src[:sourceCitation].empty?
                      json.processStep json_map(src[:sourceSteps], ProcessStep) unless src[:sourceSteps].empty?
                  end unless ln[:dataSources].empty?
              end unless intObj[:dataLineage].empty?
            end
          end
        end
      end
    end
  end
end
