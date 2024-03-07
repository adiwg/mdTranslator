require 'jbuilder'
require_relative 'mdJson_qualityMeasure'
require_relative 'mdJson_evaluationMethod'
require_relative 'mdJson_quantitativeResult'
require_relative 'mdJson_descriptiveResult'
require_relative 'mdJson_conformanceResult'
require_relative 'mdJson_coverageResult'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson

        module DataQualityReport

          @Namespace = ADIWG::Mdtranslator::Writers::MdJson

          def self.build(hReport)
            Jbuilder.new do |json|
              json.type hReport[:type] unless hReport[:type].nil?
              json.standaloneQualityReportDetails hReport[:standaloneQualityReportDetails] unless hReport[:standaloneQualityReportDetails].nil?
              json.qualityMeasure QualityMeasure.build(hReport[:qualityMeasure]) unless hReport[:qualityMeasure].empty?
              json.evaluationMethod EvaluationMethod.build(hReport[:evaluationMethod]) unless hReport[:evaluationMethod].empty? 
              json.quantitativeResult @Namespace.json_map(hReport[:quantitativeResult], QuantitativeResult) unless hReport[:quantitativeResult].empty? 
              json.descriptiveResult @Namespace.json_map(hReport[:descriptiveResult], DescriptiveResult) unless hReport[:descriptiveResult].empty? 
              json.conformanceResult @Namespace.json_map(hReport[:conformanceResult], ConformanceResult) unless hReport[:conformanceResult].empty? 
              json.coverageResult @Namespace.json_map(hReport[:coverageResult], CoverageResult) unless hReport[:coverageResult].empty?
            end
          end

        end
      end
    end
  end
end
