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
                           report[:evaluationMethod] = intMetadataClass.newEvaluationMethod
                           report[:evaluationMethod][:methodDescription] = xEvaluationMethod.text
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
                        # data quality 2.4.1.1 (horizpar) - Horizontal Positional Accuracy Report
                        xHorizontalAccuracyReport = xHorizontalAccuracy.xpath('./horizpar')
                        unless xHorizontalAccuracyReport.empty?
                           descriptiveResult = intMetadataClass.newDescriptiveResult
                           descriptiveResult[:name] = 'Horizontal Positional Accuracy Report'
                           descriptiveResult[:statement] = xHorizontalAccuracyReport.text
                           report[:descriptiveResult] << descriptiveResult
                        end
                        # data quality 2.4.1.2 (qhorizpa) - Quantitative Horizontal Positional Accuracy Assessment
                        xQuantitativeHorizontalAccuracy = xHorizontalAccuracy.xpath('./qhorizpa')
                        unless xQuantitativeHorizontalAccuracy.empty?
                           # data quality 2.4.1.2.1 (horizpav) - Horizontal Positional Accuracy Value
                           xHorizontalAccuracyValue = xQuantitativeHorizontalAccuracy.xpath('horizpav')
                           unless xHorizontalAccuracyValue.empty?
                              quantitativeResult = intMetadataClass.newQuantitativeResult
                              value = xHorizontalAccuracyValue.text
                              quantitativeResult[:name] = 'Horizontal Positional Accuracy Value'
                              quantitativeResult[:values] << value
                              report[:quantitativeResult] << quantitativeResult
                           end
                           # data quality 2.4.1.2.2 (horizpae) - Horizontal Positional Accuracy Explanation
                           xHorizontalAccuracyExplanation = xQuantitativeHorizontalAccuracy.xpath('horizpae')
                           unless xHorizontalAccuracyExplanation.empty?
                              descriptiveResult = intMetadataClass.newDescriptiveResult
                              descriptiveResult[:name] = 'Horizontal Positional Accuracy Explanation'
                              descriptiveResult[:statement] = xHorizontalAccuracyExplanation.text
                              report[:descriptiveResult] << descriptiveResult
                           end
                        end
                        hDataQuality[:report] << report
                     end
                     # data quality 2.4.2 (vertacc) - Vertical Positional Accuracy
                     xVerticalAccuracy = xPositionalAccuracy.xpath('./vertacc')
                     unless xVerticalAccuracy.empty?
                        report = intMetadataClass.newDataQualityReport
                        report[:type] = 'DQ_AbsoluteExternalPositionalAccuracy'
                        # data quality 2.4.2.1 (vertaccr) - Vertical Positional Accuracy Report
                        xVerticalAccuracyReport = xVerticalAccuracy.xpath('./vertaccr')
                        unless xVerticalAccuracyReport.empty?
                           descriptiveResult = intMetadataClass.newDescriptiveResult
                           descriptiveResult[:name] = 'Vertical Positional Accuracy Report'
                           descriptiveResult[:statement] = xVerticalAccuracyReport.text
                           report[:descriptiveResult] << descriptiveResult
                        end
                        # data quality 2.4.2.2 (qvertpa) - Quantitative Vertical Positional Accuracy Assessment
                        xVerticalAccuracyAssessment = xVerticalAccuracy.xpath('./qvertpa')
                        unless xVerticalAccuracyAssessment.empty?
                           # data quality 2.4.2.2.1 (vertaccv) - Vertical Positional Accuracy Value
                           xVerticalAccuracyValue = xVerticalAccuracyAssessment.xpath('vertaccv')
                           unless xVerticalAccuracyValue.empty?
                              quantitativeResult = intMetadataClass.newQuantitativeResult
                              value = xVerticalAccuracyValue.text
                              quantitativeResult[:name] = 'Vertical Positional Accuracy Value'
                              quantitativeResult[:values] << value
                              report[:quantitativeResult] << quantitativeResult
                           end
                           # data quality 2.4.2.2.2 (vertacce) - Vertical Positional Accuracy Explanation
                           xVerticalAccuracyExplanation = xVerticalAccuracyAssessment.xpath('vertacce')
                           unless xVerticalAccuracyExplanation.empty?
                              descriptiveResult = intMetadataClass.newDescriptiveResult
                              descriptiveResult[:name] = 'Vertical Positional Accuracy Explanation'
                              descriptiveResult[:statement] = xVerticalAccuracyExplanation.text
                              report[:descriptiveResult] << descriptiveResult
                           end
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
