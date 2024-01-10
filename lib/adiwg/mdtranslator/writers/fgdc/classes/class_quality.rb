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

            class Quality

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
                     # data quality 2.1 (attracc) - attribute accuracy (not implemented)
                     attribute_completeness_report = hDataQuality[:report].find do |report|
                        report[:type] == 'DQ_NonQuantitativeAttributeCompleteness' &&
                        !report.dig(:descriptiveResult, 0, :statement).nil?
                     end

                     if attribute_completeness_report
                        @xml.tag!('attracc') do
                           @xml.tag!('attraccr', attribute_completeness_report[:descriptiveResult][0][:statement])
                        end
                     elsif @hResponseObj[:writerShowTags]
                        @xml.tag!('attracc', 'Not Reported')
                     end

                     # data quality 2.2 (logic) - logical consistency (not implemented) (required)
                     logic_report = hDataQuality[:report].find do |report|
                        report[:type] == 'DQ_ConceptualConsistency' &&
                        !report.dig(:qualityMeasure, :description).nil?
                     end

                     if logic = logic_report&.dig(:qualityMeasure, :description)
                        @xml.tag!('logic', logic)
                     else
                        @xml.tag!('logic', 'Not Reported')
                     end

                     # data quality 2.3 (complete) - completion report (not implemented) (required)
                     completeness_report = hDataQuality[:report].find do |report|
                        report[:type] == 'DQ_CompletenessOmission' &&
                        !report.dig(:descriptiveResult, 0, :statement).nil?
                     end

                     if complete = completeness_report&.dig(:descriptiveResult, 0, :statement)
                        @xml.tag!('complete', complete)
                     else
                        @xml.tag!('complete', 'Not Reported')
                     end

                     # data quality 2.4 (position) - positional accuracy


                     horizontal_positional_accuracy_report = hDataQuality[:report].find do |report|
                        report[:type] == 'DQ_AbsoluteExternalPositionalAccuracy' &&
                        report.dig(:qualityMeasure, :name).any? { |name|
                           name == 'Horizontal Positional Accuracy Report'
                        }
                     end

                     horizpar = horizontal_positional_accuracy_report&.dig(:evaluationMethod, :methodDescription)


                     vertical_positional_accuracy_report = hDataQuality[:report].find do |report|
                        report[:type] == 'DQ_AbsoluteExternalPositionalAccuracy' &&
                        report.dig(:qualityMeasure, :name).any? { |name|
                           name == 'Vertical Positional Accuracy Report'
                        }
                     end

                     vertaccr = vertical_positional_accuracy_report&.dig(:evaluationMethod, :methodDescription)

                     if horizpar || vertaccr
                        @xml.tag!('posacc') do
                           if horizpar
                              @xml.tag!('horizpa') do
                                 @xml.tag!('horizpar', horizpar)
                              end
                           end

                           if vertaccr
                              @xml.tag!('vertacc') do
                                 @xml.tag!('vertaccr', vertaccr)
                              end
                           end
                        end
                     elsif @hResponseObj[:writerShowTags]
                        @xml.tag!('position', 'Not Reported')
                     end
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
            end # Quality

         end
      end
   end
end
