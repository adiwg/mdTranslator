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

              json.conformanceResult @Namespace.json_map(hReport[:conformanceResult], ConformanceResult) unless hReport[:conformanceResult].nil? || hReport[:conformanceResult].empty? 
              json.descriptiveResult @Namespace.json_map(hReport[:descriptiveResult], DescriptiveResult) unless hReport[:descriptiveResult].nil? || hReport[:descriptiveResult].empty? 
              json.evaluationMethod EvaluationMethod.build(hReport[:evaluationMethod]) unless hReport[:evaluationMethod].nil?
              json.qualityMeasure QualityMeasure.build(hReport[:qualityMeasure]) unless hReport[:qualityMeasure].nil?
              json.quantitativeResult @Namespace.json_map(hReport[:quantitativeResult], QuantitativeResult) unless hReport[:quantitativeResult].nil? || hReport[:quantitativeResult].empty? 

            end
          end

        end
      end
    end
  end
end
