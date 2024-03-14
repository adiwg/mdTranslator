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
                  accuracyReport = xAccuracy.xpath('./attraccr').text
                  report = intMetadataClass.newDataQualityReport
                  report[:type] = 'NonQuantitativeAttributeAccuracy'
                  descriptiveResult = intMetadataClass.newDescriptiveResult
                  descriptiveResult[:statement] = accuracyReport
                  report[:descriptiveResult] << descriptiveResult
                  hDataQuality[:report] << report

                  # data quality 2.1 (qattracc) - Quantitative Attribute Accuracy Assessment
                  xQuantitativeAccuracy = xDataQual.xpath('./qattracc')
                  unless xQuantitativeAccuracy.xpath('./attraccv').empty?
                     value = xQuantitativeAccuracy.xpath('./attraccv').text
                     report = intMetadataClass.newDataQualityReport
                     report[:type] = 'QuantitativeAttributeAccuracy'
                     quantitativeResult = intMetadataClass.newQuantitativeResult
                     quantitativeResult[:values] << value
                     report[:quantitativeResult] << quantitativeResult
                     hDataQuality[:report] << report
                  end

                  # data quality 2.2 (logic) - logical consistency (required) (not implemented)
                  xLogic = xDataQual.xpath('./logic')
                  if xLogic.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: data quality logical consistency section is missing'
                  else
                     logic = xLogic.text
                     report = intMetadataClass.newDataQualityReport
                     report[:type] = 'ConceptualConsistency'
                     report[:qualityMeasure] = intMetadataClass.newQualityMeasure
                     report[:qualityMeasure][:description] = logic
                     hDataQuality[:report] << report
                  end

                  # data quality 2.3 (complete) - completion report (required)
                  xComplete = xDataQual.xpath('./complete')
                  if xComplete.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: data quality completion report section is missing'
                  else
                     complete = xComplete.text
                     report = intMetadataClass.newDataQualityReport
                     report[:type] = 'CompletenessOmission'
                     descriptiveResult = intMetadataClass.newDescriptiveResult
                     descriptiveResult[:statement] = complete
                     report[:descriptiveResult] << descriptiveResult
                     hDataQuality[:report] << report
                  end

                  # data quality 2.4 (position) - positional accuracy
                  xPositionalAccuracy = xDataQual.xpath('./posacc')
                  unless xPositionalAccuracy.empty?
                     # horizontal positional accuracy
                     xHorizontal = xPositionalAccuracy.xpath('./horizpa')
                     unless xHorizontal.empty?
                        report = intMetadataClass.newDataQualityReport
                        report[:type] = 'AbsoluteExternalPositionalAccuracy'
                        unless xHorizontal.xpath('qhorizpa/horizpae').empty?
                           report[:qualityMeasure] = intMetadataClass.newQualityMeasure
                           report[:qualityMeasure][:description] = xHorizontal.xpath('qhorizpa/horizpae').text
                           name = 'Horizontal Positional Accuracy Report'
                           report[:qualityMeasure][:nameOfMeasure] << name
                        end
                        unless xHorizontal.xpath('horizpar').empty?
                           report[:evaluationMethod] = intMetadataClass.newEvaluationMethod
                           report[:evaluationMethod][:methodDescription] = xHorizontal.xpath('horizpar').text
                        end
                        unless xHorizontal.xpath('qhorizpa/horizpav').empty?
                           quantitativeResult = intMetadataClass.newQuantitativeResult
                           value = xHorizontal.xpath('qhorizpa/horizpav').text
                           quantitativeResult[:values] << value
                           report[:quantitativeResult] << quantitativeResult
                        end
                        hDataQuality[:report] << report
                     end
                     # vertical positional accuracy
                     xVertical = xPositionalAccuracy.xpath('./vertacc')
                     unless xVertical.empty?
                        report = intMetadataClass.newDataQualityReport
                        report[:type] = 'AbsoluteExternalPositionalAccuracy'
                        unless xVertical.xpath('qvertpa/vertacce').empty?
                           report[:qualityMeasure] = intMetadataClass.newQualityMeasure
                           report[:qualityMeasure][:description] = xVertical.xpath('qvertpa/vertacce').text
                           name = 'Vertical Positional Accuracy Report'
                           report[:qualityMeasure][:nameOfMeasure] << name
                        end
                        unless xVertical.xpath('vertaccr').empty?
                           report[:evaluationMethod] = intMetadataClass.newEvaluationMethod
                           report[:evaluationMethod][:methodDescription] = xVertical.xpath('vertaccr').text
                        end
                        unless xVertical.xpath('qvertpa/vertaccv').empty?
                           quantitativeResult = intMetadataClass.newQuantitativeResult
                           value = xVertical.xpath('qvertpa/vertaccv').text
                           quantitativeResult[:values] << value
                           report[:quantitativeResult] << quantitativeResult
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
