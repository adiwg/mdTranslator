require 'jbuilder'
require_relative 'mdJson_scope'
require_relative 'mdJson_citation'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson

        module ConformanceResult
          def self.build(hConformanceResult)
            Jbuilder.new do |json|
              json.dateTime hConformanceResult[:dateTime]
              json.scope Scope.build(hConformanceResult[:scope])
              json.specification Citation.build(hConformanceResult[:specification])
              json.explanation hConformanceResult[:explanation]
              json.pass hConformanceResult[:pass]
            end
          end
        end

      end
    end
  end
end
