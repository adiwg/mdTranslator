# mdJson 2.0 writer - dataQuality

require 'jbuilder'
require_relative 'mdJson_scope'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson

        module DataQuality

          @Namespace = ADIWG::Mdtranslator::Writers::MdJson

          def self.build(hDataQuality)
            Jbuilder.new do |json|
              json.scope Scope.build(hDataQuality[:scope])
              json.standaloneQualityReport hDataQuality[:standaloneQualityReport]
              json.report hDataQuality[:report]
            end

          end

        end

      end
    end
  end
end


