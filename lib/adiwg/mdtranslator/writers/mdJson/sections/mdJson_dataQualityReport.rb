require 'jbuilder'
require_relative 'mdJson_conformanceResult'
require_relative 'mdJson_descriptiveResult'
require_relative 'mdJson_qualityMeasure'
require_relative 'mdJson_quantitativeResult'
require_relative 'mdJson_evaluationMethod'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson

        module DataQualityReport

          @Namespace = ADIWG::Mdtranslator::Writers::MdJson

          def self.build(hReport)
            Jbuilder.new do |json|

              json.conformanceResult @Namespace.json_map(hReport[:conformanceResult], ConformanceResult)
              json.descriptiveResult @Namespace.json_map(hReport[:descriptiveResult], DescriptiveResult)
              json.evaluationMethod EvaluationMethod.build(hReport[:evaluationMethod])
              json.qualityMeasure QualityMeasure.build(hReport[:qualityMeasure])
              json.quantitativeResult @Namespace.json_map(hReport[:quantitativeResult], QuantitativeResult)

            end
          end

        end
      end
    end
  end
end
