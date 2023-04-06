module ADIWG
  module Mdtranslator
    module Writers
      module Iso19115_2

        class DataQualityReport
          def initialize(xml, hResponseObj)
            @xml = xml
            @hResponseObj = hResponseObj
          end

          def writeXML(hReport)
            # require 'pry'; binding.pry

            @xml.tag!('mdq:report') do
              @xml.tag!("mdq:#{hReport[:type]}") do

                # conformanceResult []

                # coverageResult []

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
                end

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
                end

                # qualityMeasure {}
                qualityMeasure = hReport[:qualityMeasure]
                unless qualityMeasure.nil? || qualityMeasure.empty?
                  @xml.tag!('mdq:measure') do
                    @xml.tag!('mdq:DQ_MeasureReference') do
                      unless qualityMeasure[:name].nil?
                        qualityMeasure[:name].each do |value|
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
                end


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
                end

              end
            end
          end

        end
      end
    end
  end
end
