require_relative '../iso19115_3_writer'
require_relative 'class_format'
require_relative 'class_qualityResultFile'
require_relative 'class_date'
require_relative 'class_scope'
require_relative 'class_spatialRepresentation'
require_relative 'class_coverageDescription'
require_relative 'class_codelist'
require_relative 'class_identifier'

module ADIWG
  module Mdtranslator
    module Writers
      module Iso19115_3

        class DataQualityReport
          def initialize(xml, hResponseObj)
            @xml = xml
            @hResponseObj = hResponseObj
          end

          def writeXML(hReport)
            # require 'pry'; binding.pry

            formatClass = MD_Format.new(@xml, @hResponseObj)
            qualityResultFileClass = QualityResultFile.new(@xml, @hResponseObj)
            dateClass = CI_Date.new(@xml, @hResponseObj)
            scopeClass = MD_Scope.new(@xml, @hResponseObj)
            spatialRepresentationClass = SpatialRepresentation.new(@xml, @hResponseObj)
            coverageDescriptionClass = MD_CoverageDescription.new(@xml, @hResponseObj)
            codeListClass = MD_Codelist.new(@xml, @hResponseObj)
            identifierClass = MD_Identifier.new(@xml, @hResponseObj)

            @xml.tag!('mdq:report') do
              @xml.tag!("mdq:#{hReport[:type]}") do

                # standaloneQualityReportDetails
                unless hReport[:standaloneQualityReportDetails].nil?
                  @xml.tag!('mdq:standaloneQualityReportDetails') do
                    @xml.tag!('gco:CharacterString', hReport[:standaloneQualityReportDetails])
                  end
                end

                # qualityMeasure {}
                qualityMeasure = hReport[:qualityMeasure]
                unless qualityMeasure.empty?
                  @xml.tag!('mdq:measure') do
                    @xml.tag!('mdq:DQ_MeasureReference') do
                      unless qualityMeasure[:identifier].empty?
                        @xml.tag!('mdq:measureIdentification') do
                          identifierClass.writeXML(qualityMeasure[:identifier])
                        end
                      end
                      unless qualityMeasure[:nameOfMeasure].nil?
                        qualityMeasure[:nameOfMeasure].each do |value|
                          @xml.tag!('mdq:nameOfMeasure') do
                            @xml.tag!('gco:CharacterString', value)
                          end
                        end
                      end
                      unless qualityMeasure[:description].nil?
                        @xml.tag!('mdq:measureDescription') do
                          @xml.tag!('gco:CharacterString', qualityMeasure[:description])
                        end
                      end
                    end
                  end
                end # qualityMeasure

                # evaluationMethod {}
                evaluationMethod = hReport[:evaluationMethod]
                unless evaluationMethod.nil? || evaluationMethod.empty?
                  @xml.tag!('mdq:evaluationMethod') do
                    @xml.tag!('mdq:DQ_EvaluationMethod') do
                      @xml.tag!('mdq:evaluationMethodDescription') do
                        @xml.tag!('gco:CharacterString', evaluationMethod[:methodDescription]) 
                      end
                    end
                  end
                end # evaluationMethod

                # conformanceResult []

                # descriptiveResult []
                unless hReport[:descriptiveResult].nil? || hReport[:descriptiveResult].empty?
                  hReport[:descriptiveResult].each do |descriptiveResult|
                    @xml.tag!('mdq:result') do
                      @xml.tag!('mdq:DQ_DescriptiveResult') do
                        unless descriptiveResult[:statement].nil? || descriptiveResult[:statement].empty?
                          @xml.tag!('mdq:statement') do
                            @xml.tag!('gco:CharacterString', descriptiveResult[:statement])
                          end
                        end
                      end
                    end
                  end
                end # descriptiveResult

                # quantitativeResult []
                unless hReport[:quantitativeResult].nil? || hReport[:quantitativeResult].empty?
                  hReport[:quantitativeResult].each do |quantitativeResult|
                    @xml.tag!('mdq:result') do
                      @xml.tag!('mdq:DQ_QuantitativeResult') do
                        quantitativeResult[:value].each do |value|
                          @xml.tag!('mdq:value') do
                            @xml.tag!('gco:Record', value)
                          end
                        end
                      end
                    end
                  end
                end # quantitativeResult

                # coverageResult []
                unless hReport[:coverageResult].nil? || hReport[:coverageResult].empty?
                  hReport[:coverageResult].each do |coverageResult|
                    @xml.tag!('mdq:result') do
                      @xml.tag!('mdq:QE_CoverageResult') do
                        unless coverageResult[:dateTime].nil?
                          dateTimeValue = DateTime.parse(coverageResult[:dateTime]).strftime('%Y-%m-%dT%H:%M:%S')
                          @xml.tag!('mdq:dateTime') do
                            @xml.tag!('gco:DateTime', dateTimeValue)
                          end
                        end
                        unless coverageResult[:scope].empty?
                          @xml.tag!('mdq:resultScope') do
                            scopeClass.writeXML(coverageResult[:scope])
                          end
                        end
                        unless coverageResult[:spatialRepresentationType].nil?
                          @xml.tag!('mdq:spatialRepresentationType') do
                            codeListClass.writeXML('mcc', 'iso_spatialRepresentation', coverageResult[:spatialRepresentationType])
                          end
                        end
                        unless coverageResult[:resultFile].empty?
                          @xml.tag!('mdq:resultFile') do
                            qualityResultFileClass.writeXML(coverageResult[:resultFile])
                          end
                        end
                        unless coverageResult[:spatialRepresentation].empty?
                          @xml.tag!('mdq:resultSpatialRepresentation') do
                            spatialRepresentationClass.writeXML(coverageResult[:spatialRepresentation])
                          end
                        end
                        unless coverageResult[:resultContentDescription].empty?
                          @xml.tag!('mdq:resultContentDescription') do
                            coverageDescriptionClass.writeXML(coverageResult[:resultContentDescription])
                          end
                        end
                        unless coverageResult[:resourceFormat].empty?
                          @xml.tag!('mdq:resultFormat') do
                            formatClass.writeXML(coverageResult[:resourceFormat])
                          end
                        end
                      end
                    end
                  end
                end # coverageResult

              end # mdq:<type>
            end # mdq:report

          end # writeXML

        end # DataQualityReport class
      end
    end
  end
end
