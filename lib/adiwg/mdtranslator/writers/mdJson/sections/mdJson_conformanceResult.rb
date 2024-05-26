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
              json.dateTime hConformanceResult[:dateTime] unless hConformanceResult[:dateTime].nil?
              json.scope Scope.build(hConformanceResult[:scope]) unless hConformanceResult[:scope].empty?
              json.name hConformanceResult[:name] unless hConformanceResult[:name].nil?
              json.specification Citation.build(hConformanceResult[:specification]) unless hConformanceResult[:specification].empty?
              json.explanation hConformanceResult[:explanation] unless hConformanceResult[:explanation].nil?
              json.pass hConformanceResult[:pass] unless hConformanceResult[:pass].nil?
            end
          end
        end

      end
    end
  end
end
