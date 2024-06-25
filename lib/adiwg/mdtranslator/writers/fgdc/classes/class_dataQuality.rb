# FGDC <<Class>> Quality
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-03-23 refactored error and warning messaging
#  Stan Smith 2017-12-15 original script

require_relative 'class_lineage'

module ADIWG
  module Mdtranslator
    module Writers
      module Fgdc

        class DataQuality

          def initialize(xml, hResponseObj)
            @xml = xml
            @hResponseObj = hResponseObj
            @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
          end

          def writeXML(intObj)

            # classes used
            lineageClass = Lineage.new(@xml, @hResponseObj)

            hDataQuality = intObj.dig(:metadata, :dataQuality, 0)

            if hDataQuality && hDataQuality[:report]
              # data quality 2.1 (attracc) - Attribute Accuracy
              attribute_accuracy_report_text = hDataQuality[:report].select do |report|
                [
                  'DQ_NonQuantitativeAttributeCorrectness',
                  'DQ_ThematicClassificationCorrectness'
                ].include?(report[:type]) && !report.dig(:descriptiveResult, 0, :statement).nil?
              end.map { |report| report.dig(:descriptiveResult, 0, :statement) }.compact.join(' ')

              quantitative_attribute_accuracy = hDataQuality[:report].find { |report| report[:type] == 'DQ_QuantitativeAttributeAccuracy' }
              attribute_accuracy_value = quantitative_attribute_accuracy.dig(:quantitativeResult, 0, :values, 0) if quantitative_attribute_accuracy
              attribute_evaluation_method = quantitative_attribute_accuracy.dig(:evaluationMethod, :methodDescription) if quantitative_attribute_accuracy

              if attribute_accuracy_report_text != '' || attribute_accuracy_value || attribute_evaluation_method
                @xml.tag!('attracc') do
                  @xml.tag!('attraccr', attribute_accuracy_report_text) unless attribute_accuracy_report_text.empty?
                  if attribute_accuracy_value || attribute_evaluation_method
                    @xml.tag!('qattracc') do
                      @xml.tag!('attraccv', attribute_accuracy_value) if attribute_accuracy_value
                      @xml.tag!('attracce', attribute_evaluation_method) if attribute_evaluation_method
                    end
                  end
                end
              elsif @hResponseObj[:writerShowTags]
                @xml.tag!('attracc', 'Not Reported')
              end

              # data quality 2.2 (logic) - logical consistency (required)
              logic_reports = hDataQuality[:report].select do |report|
                [
                  'DQ_ConceptualConsistency',
                  'DQ_DomainConsistency',
                  'DQ_FormatConsistency',
                  'DQ_TopologicalConsistency'
                ].include?(report[:type]) && !report.dig(:descriptiveResult, 0, :statement).nil?
              end

              logic = logic_reports.map { |report| report.dig(:descriptiveResult, 0, :statement) }.compact.join(' ')

              if logic != ''
                @xml.tag!('logic', logic)
              else
                @xml.tag!('logic', 'Not Reported')
              end

              # data quality 2.3 (complete) - completion report (required)
              omission = hDataQuality[:report].find { |report| report[:type] == 'DQ_CompletenessOmission' }&.dig(:descriptiveResult, 0, :statement)
              commission = hDataQuality[:report].find { |report| report[:type] == 'DQ_CompletenessCommission' }&.dig(:descriptiveResult, 0, :statement)
              complete = [omission, commission].compact.join(' ')
              if complete != ''
                @xml.tag!('complete', complete)
              else
                @xml.tag!('complete', 'Not Reported')
              end

              # data quality 2.4 (posacc) - Positional Accuracy
              reports = hDataQuality[:report].select do |report|
                [
                  'DQ_AbsoluteExternalPositionalAccuracy',
                  'DQ_RelativeInternalPositionalAccuracy',
                  'DQ_GriddedDataPositionalAccuracy'
                ].include?(report[:type]) && !report.dig(:descriptiveResult, 0, :statement).nil?
              end

              horizpar = ''
              vertaccr = ''

              reports.each do |report|
                descriptive_result = report.dig(:descriptiveResult, 0)
                next unless descriptive_result

                if descriptive_result[:name] == 'Vertical Positional Accuracy Report'
                  vertaccr = descriptive_result[:statement]
                else
                  horizpar = descriptive_result[:statement]
                end
              end

              if !horizpar.empty? || !vertaccr.empty?
                @xml.tag!('posacc') do
                  if !horizpar.empty?
                    @xml.tag!('horizpa') do
                      @xml.tag!('horizpar', horizpar)
                    end
                  end

                  if !vertaccr.empty?
                    @xml.tag!('vertacc') do
                      @xml.tag!('vertaccr', vertaccr)
                    end
                  end
                end
              elsif @hResponseObj[:writerShowTags]
                @xml.tag!('position', 'Not Reported')
              end

              # data quality 2.5 (lineage) - lineage (required)
              unless intObj[:metadata][:lineageInfo].empty?
                @xml.tag!('lineage') do
                  lineageClass.writeXML(intObj[:metadata][:lineageInfo])
                end
              end
              if intObj[:metadata][:lineageInfo].empty?
                @NameSpace.issueWarning(350, nil, 'data quality section')
              end

              # data quality 2.6 (cloud) - cloud cover (not implemented)
              if @hResponseObj[:writerShowTags]
                @xml.tag!('cloud', 'Not Reported')
              end

            end # writeXML
          end # DataQuality

        end # Quality

      end
    end
  end
end