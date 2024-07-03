# Reader - fgdc to internal data structure
# unpack fgdc data quality

# History:
#  Stan Smith 2017-08-15 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_lineage'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module DataQuality

               def self.unpack(xDataQual, hMetadata, hDataQuality, hResponseObj)
                  intMetadataClass = InternalMetadata.new

                  hDataQuality[:scope] = intMetadataClass.newScope
                  hDataQuality[:scope][:scopeCode] = 'tabularDataset'

                  hDataQuality[:systemIdentifier] = {
                     uid: UUIDTools::UUID.random_create.to_s,
                     label: "CSDGM Data Quality"
                  }

                  # data quality 2.1 (attracc) - attribute accuracy
                  xAccuracy = xDataQual.xpath('./attracc')
                  unless xAccuracy.empty?
                     # data quality 2.1.1 (attraccr) - Attribute Accuracy Report
                     xAccuracyReport = xAccuracy.xpath('./attraccr')
                     unless xAccuracyReport.empty?
                        report = intMetadataClass.newDataQualityReport
                        report[:type] = 'DQ_NonQuantitativeAttributeCorrectness'
                        descriptiveResult = intMetadataClass.newDescriptiveResult
                        descriptiveResult[:name] = 'Attribute Accuracy Report'
                        descriptiveResult[:statement] = xAccuracyReport.text
                        report[:descriptiveResult] << descriptiveResult
                        hDataQuality[:report] << report
                     end
                     # data quality 2.1.2 (qattracc) - Quantitative Attribute Accuracy Assessment
                     xQuantitativeAccuracy = xAccuracy.xpath('./qattracc')
                     unless xQuantitativeAccuracy.empty?
                        report = intMetadataClass.newDataQualityReport
                        report[:type] = 'DQ_QuantitativeAttributeAccuracy'
                        # data quality 2.1.2.1 (attraccv) - Attribute Accuracy Value
                        xQuantitativeAccuracyValue = xQuantitativeAccuracy.xpath('./attraccv')
                        unless xQuantitativeAccuracyValue.empty?
                           quantitativeResult = intMetadataClass.newQuantitativeResult
                           quantitativeResult[:name] = 'Attribute Accuracy Value'
                           quantitativeResult[:values] << xQuantitativeAccuracyValue.text
                           report[:quantitativeResult] << quantitativeResult
                        end
                        # data quality 2.1.2.2 (attracce) - Attribute Accuracy Explanation
                        xEvaluationMethod = xQuantitativeAccuracy.xpath('./attracce')
                        unless xEvaluationMethod.empty?
                           evaluationMethod = intMetadataClass.newEvaluationMethod
                           evaluationMethod[:name] = 'Attribute Accuracy Explanation'
                           evaluationMethod[:methodDescription] = xEvaluationMethod.text
                           report[:evaluationMethod] << evaluationMethod
                        end
                        hDataQuality[:report] << report unless report[:quantitativeResult].empty? && report[:evaluationMethod].empty?
                     end
                  end

                  # data quality 2.2 (logic) - logical consistency (required) (not implemented)
                  xLogic = xDataQual.xpath('./logic')
                  if xLogic.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: data quality logical consistency section is missing'
                  else
                     logic = xLogic.text
                     report = intMetadataClass.newDataQualityReport
                     report[:type] = 'DQ_ConceptualConsistency'
                     descriptiveResult = intMetadataClass.newDescriptiveResult
                     descriptiveResult[:name] = 'Logical Consistency Report'
                     descriptiveResult[:statement] = logic
                     report[:descriptiveResult] << descriptiveResult
                     hDataQuality[:report] << report
                  end

                  # data quality 2.3 (complete) - completion report (required)
                  xComplete = xDataQual.xpath('./complete')
                  if xComplete.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: data quality completion report section is missing'
                  else
                     complete = xComplete.text
                     report = intMetadataClass.newDataQualityReport
                     report[:type] = 'DQ_CompletenessOmission'
                     descriptiveResult = intMetadataClass.newDescriptiveResult
                     descriptiveResult[:name] = 'Completeness Report'
                     descriptiveResult[:statement] = complete
                     report[:descriptiveResult] << descriptiveResult
                     hDataQuality[:report] << report
                  end

                  # data quality 2.4 (posacc) - Positional Accuracy
                  xPositionalAccuracy = xDataQual.xpath('./posacc')
                  unless xPositionalAccuracy.empty?
                     # data quality 2.4.1 (horizpa) - Horizontal Positional Accuracy
                     xHorizontalAccuracy = xPositionalAccuracy.xpath('./horizpa')
                     unless xHorizontalAccuracy.empty?
                        report = intMetadataClass.newDataQualityReport
                        report[:type] = 'DQ_AbsoluteExternalPositionalAccuracy'
                        # Combine Horizontal Positional Accuracy Report and Explanation
                        descriptive_result_text = ''
                        xHorizontalAccuracyReport = xHorizontalAccuracy.xpath('./horizpar')
                        unless xHorizontalAccuracyReport.empty?
                           descriptive_result_text += xHorizontalAccuracyReport.text
                        end
                        xQuantitativeHorizontalAccuracy = xHorizontalAccuracy.xpath('./qhorizpa')
                        unless xQuantitativeHorizontalAccuracy.empty?
                           xHorizontalAccuracyValue = xQuantitativeHorizontalAccuracy.xpath('horizpav')
                           unless xHorizontalAccuracyValue.empty?
                              descriptive_result_text += " Value: #{xHorizontalAccuracyValue.text}"
                           end
                           xHorizontalAccuracyExplanation = xQuantitativeHorizontalAccuracy.xpath('horizpae')
                           unless xHorizontalAccuracyExplanation.empty?
                              descriptive_result_text += " Explanation: #{xHorizontalAccuracyExplanation.text}"
                           end
                        end
                        unless descriptive_result_text.empty?
                           descriptiveResult = intMetadataClass.newDescriptiveResult
                           descriptiveResult[:name] = 'Horizontal Positional Accuracy Report'
                           descriptiveResult[:statement] = descriptive_result_text
                           report[:descriptiveResult] << descriptiveResult
                        end
                        hDataQuality[:report] << report
                     end
                     # data quality 2.4.2 (vertacc) - Vertical Positional Accuracy
                     xVerticalAccuracy = xPositionalAccuracy.xpath('./vertacc')
                     unless xVerticalAccuracy.empty?
                        report = intMetadataClass.newDataQualityReport
                        report[:type] = 'DQ_AbsoluteExternalPositionalAccuracy'
                        # Combine Vertical Positional Accuracy Report and Explanation
                        descriptive_result_text = ''
                        xVerticalAccuracyReport = xVerticalAccuracy.xpath('./vertaccr')
                        unless xVerticalAccuracyReport.empty?
                           descriptive_result_text += xVerticalAccuracyReport.text
                        end
                        xVerticalAccuracyAssessment = xVerticalAccuracy.xpath('./qvertpa')
                        unless xVerticalAccuracyAssessment.empty?
                           xVerticalAccuracyValue = xVerticalAccuracyAssessment.xpath('vertaccv')
                           unless xVerticalAccuracyValue.empty?
                              descriptive_result_text += " Value: #{xVerticalAccuracyValue.text}"
                           end
                           xVerticalAccuracyExplanation = xVerticalAccuracyAssessment.xpath('vertacce')
                           unless xVerticalAccuracyExplanation.empty?
                              descriptive_result_text += " Explanation: #{xVerticalAccuracyExplanation.text}"
                           end
                        end
                        unless descriptive_result_text.empty?
                           descriptiveResult = intMetadataClass.newDescriptiveResult
                           descriptiveResult[:name] = 'Vertical Positional Accuracy Report'
                           descriptiveResult[:statement] = descriptive_result_text
                           report[:descriptiveResult] << descriptiveResult
                        end
                        hDataQuality[:report] << report
                     end
                  end

                  # data quality 2.5 (lineage) - lineage (required)
                  xLineage = xDataQual.xpath('./lineage')
                  unless xLineage.empty?
                     hLineage = Lineage.unpack(xLineage, hResponseObj)
                     unless hLineage.nil?
                        hMetadata[:lineageInfo] << hLineage
                     end
                  end
                  if xLineage.nil?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: data quality lineage section is missing'
                  end

                  return hDataQuality
               end

            end

         end
      end
   end
end