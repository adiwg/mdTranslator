# mdJson 2.0 writer - dataQuality

require 'jbuilder'
require_relative 'mdJson_citation'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson

        module StandaloneQualityReport

          @Namespace = ADIWG::Mdtranslator::Writers::MdJson

          def self.build(hStandaloneReport)
            reportReference = hStandaloneReport[:reportReference]
            Jbuilder.new do |json|
              json.reportReference Citation.build(reportReference)
              json.abstract hStandaloneReport[:abstract]
            end

          end

        end

      end
    end
  end
end


