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

            module Quality

               def self.unpack(xDataQual, hMetadata, hDataQuality, hResponseObj)

                  hDataQuality[:scope] = {scopeCode: 'tabularDataset'}
                  hDataQuality[:systemIdentifier] = {
                     uid: UUIDTools::UUID.random_create.to_s,
                     label: "CSDGM Data Quality"
                  }


                  # data quality 2.1 (attracc) - attribute accuracy
                  xAccuracy = xDataQual.xpath('./attracc')
                  accuracyReport = xAccuracy.xpath('./attraccr').text
                  hDataQuality[:report] << {
                     type: 'DQ_NonQuantitativeAttributeCompleteness',
                     descriptiveResult: [ {statement: accuracyReport} ]
                  }

                  # data quality 2.1 (qattracc) - Quantitative Attribute Accuracy Assessment

                  xQuantitativeAccuracy = xDataQual.xpath('./qattracc')
                  unless xQuantitativeAccuracy.xpath('./attraccv').empty?
                     hDataQuality[:report] << {
                        type: 'DQ_QuantitativeAttributeAccuracy',
                        quantitativeResult: [{
                           value: xQuantitativeAccuracy.xpath('./attraccv').text
                        }]
                     }
                  end

                  # data quality 2.2 (logic) - logical consistency (required) (not implemented)
                  xLogic = xDataQual.xpath('./logic')
                  if xLogic.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: data quality logical consistency section is missing'
                  else
                     logic = xLogic.text
                     hDataQuality[:report] << {
                        type: 'DQ_ConceptualConsistency',
                        qualityMeasure: {
                           description: logic
                        }
                     }
                  end

                  # data quality 2.3 (complete) - completion report (required)
                  xComplete = xDataQual.xpath('./complete')
                  if xComplete.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: data quality completion report section is missing'
                  else
                     complete = xComplete.text
                     hDataQuality[:report] << {
                        type: 'DQ_CompletenessOmission',
                        descriptiveResult: [{
                           statement: complete
                        }]
                     }
                  end

                  # data quality 2.4 (position) - positional accuracy
                  xPositionalAccuracy = xDataQual.xpath('./posacc')
                  unless xPositionalAccuracy.empty?

                     # horizontal positional accuracy
                     xHorizontal = xPositionalAccuracy.xpath('./horizpa')
                     unless xHorizontal.empty?

                        report = {}

                        unless xHorizontal.xpath('horizpar').empty?
                           report[:evaluationMethod] = {
                              methodDescription: xHorizontal.xpath('horizpar').text
                           }
                        end

                        unless xHorizontal.xpath('qhorizpa/horizpae').empty?
                           report[:qualityMeasure] = {
                              description: xHorizontal.xpath('qhorizpa/horizpae').text
                           }
                        end

                        unless xHorizontal.xpath('qhorizpa/horizpav').empty?
                           report[:quantitativeResult] = [{
                              value: [ xHorizontal.xpath('qhorizpa/horizpav').text ]
                           }]
                        end

                        unless report.empty?
                           if report[:qualityMeasure].nil?
                              report[:qualityMeasure] = {
                                 name: ['Horizontal Positional Accuracy Report']
                              }
                           else
                              report[:qualityMeasure][:name] = ['Horizontal Positional Accuracy Report']
                           end

                           report[:type] = 'DQ_AbsoluteExternalPositionalAccuracy'

                           hDataQuality[:report] << report
                        end
                     end

                     # vertical positional accuracy
                     xVertical = xPositionalAccuracy.xpath('./vertacc')
                     unless xVertical.empty?

                        report = {}

                        unless xVertical.xpath('vertaccr').empty?
                           report[:evaluationMethod] = {
                              methodDescription: xVertical.xpath('vertaccr').text
                           }
                        end

                        unless xVertical.xpath('qvertpa/vertacce').empty?
                           report[:qualityMeasure] = {
                              description: xVertical.xpath('qvertpa/vertacce').text
                           }
                        end

                        unless xVertical.xpath('qvertpa/vertaccv').empty?
                           report[:quantitativeResult] = [{
                              value: [ xVertical.xpath('qvertpa/vertaccv').text ]
                           }]
                        end

                        unless report.empty?
                           if report[:qualityMeasure].nil?
                              report[:qualityMeasure] = {
                                 name: ['Vertical Positional Accuracy Report']
                              }
                           else
                              report[:qualityMeasure][:name] = ['Vertical Positional Accuracy Report']
                           end

                           report[:type] = 'DQ_AbsoluteExternalPositionalAccuracy'

                           hDataQuality[:report] << report
                        end
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

                  # data quality 2.6 (cloud) - cloud cover (not implemented)

                  return hDataQuality

               end

            end

         end
      end
   end
end
