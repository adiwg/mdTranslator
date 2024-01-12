# mdJson 2.0 writer - dataQuality

require 'jbuilder'
require_relative 'mdJson_scope'
require_relative 'mdJson_dataQualityReport'
require_relative 'mdJson_citation'
require_relative 'mdJson_standAloneQualityReport'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson

        module DataQuality

          @Namespace = ADIWG::Mdtranslator::Writers::MdJson

          def self.build(hDataQuality)
            Jbuilder.new do |json|
              json.scope Scope.build(hDataQuality[:scope])
              json.systemIdentifier hDataQuality[:systemIdentifier]
              json.standaloneQualityReport StandaloneQualityReport.build(hDataQuality[:standaloneReport]) unless hDataQuality[:standaloneReport].nil?
              json.report @Namespace.json_map(hDataQuality[:report], DataQualityReport)
            end

          end

        end

      end
    end
  end
end


