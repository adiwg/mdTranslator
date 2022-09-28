require 'jbuilder'
require_relative 'mdJson_conformanceResult'
require_relative 'mdJson_qualityMeasure'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson

        module DataQualityReport

          @Namespace = ADIWG::Mdtranslator::Writers::MdJson

          def self.build(hReport)
            Jbuilder.new do |json|

              json.conformanceResult @Namespace.json_map(hReport[:conformanceResult], ConformanceResult)
              json.qualityMeasure QualityMeasure.build(hReport[:qualityMeasure])

            end
          end

        end
      end
    end
  end
end
