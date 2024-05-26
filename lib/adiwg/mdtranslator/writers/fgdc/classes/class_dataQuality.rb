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
                     attribute_accuracy_report = hDataQuality[:report].find do |report|
                        report[:type] == 'DQ_NonQuantitativeAttributeCorrectness' &&
                        !report.dig(:descriptiveResult, 0, :statement).nil?
                     end
                     attribute_accuracy_value = hDataQuality[:report].find do |report|
                        report[:type] == 'DQ_QuantitativeAttributeAccuracy' &&
                        !report.dig(:quantitativeResult, 0, :values).nil?
                     end
                     attribute_evaluation_method = hDataQuality[:report].find do |report|
                        report[:type] == 'DQ_QuantitativeAttributeAccuracy' &&
                        !report.dig(:evaluationMethod, :methodDescription).nil?
                     end
                     if attribute_accuracy_report || attribute_accuracy_value || attribute_evaluation_method
                        # data quality 2.1 (attracc) - Attribute Accuracy
                        @xml.tag!('attracc') do
                           if attribute_accuracy_report
                              # data quality 2.1.1 (attraccr) - Attribute Accuracy Report
                              @xml.tag!('attraccr', attribute_accuracy_report[:descriptiveResult][0][:statement])
                           end
                           if attribute_accuracy_value || attribute_evaluation_method
                              # data quality 2.1.2 (qattracc) - Quantitative Attribute Accuracy Assessment
                              @xml.tag!('qattracc') do
                                 if attribute_accuracy_value
                                    # data quality 2.1.2.1 (attraccv) - Attribute Accuracy Value
                                    @xml.tag!('attraccv', attribute_accuracy_value[:quantitativeResult][0][:values][0])
                                 end
                                 if attribute_evaluation_method
                                    # data quality 2.1.2.2 (attracce) - Attribute Accuracy Explanation
                                    @xml.tag!('attracce', attribute_evaluation_method[:evaluationMethod][:methodDescription])
                                 end
                              end
                           end
                        end
                     elsif @hResponseObj[:writerShowTags]
                        @xml.tag!('attracc', 'Not Reported')
                     end

                     # data quality 2.2 (logic) - logical consistency (required)
                     logic_report = hDataQuality[:report].find do |report|
                        report[:type] == 'DQ_ConceptualConsistency' &&
                        !report.dig(:descriptiveResult, 0, :statement).nil?
                     end
                     if logic = logic_report&.dig(:descriptiveResult, 0, :statement)
                        @xml.tag!('logic', logic)
                     else
                        @xml.tag!('logic', 'Not Reported')
                     end

                     # data quality 2.3 (complete) - completion report (required)
                     omission_report = hDataQuality[:report].find do |report|
                        report[:type] == 'DQ_CompletenessOmission' &&
                        !report.dig(:descriptiveResult, 0, :statement).nil?
                     end
                     omission = omission_report&.dig(:descriptiveResult, 0, :statement)
                     commission_report = hDataQuality[:report].find do |report|
                        report[:type] == 'DQ_CompletenessCommission' &&
                        !report.dig(:descriptiveResult, 0, :statement).nil?
                     end
                     commission = commission_report&.dig(:descriptiveResult, 0, :statement)
                     complete = ''
                     if omission
                        complete = omission
                     end
                     if commission
                        if complete != ''
                           complete = complete + ' ' + commission
                        else
                           complete = commission
                        end
                     end
                     if complete != ''
                        @xml.tag!('complete', complete)
                     else
                        @xml.tag!('complete', 'Not Reported')
                     end

                     # data quality 2.4 (position) - Positional Accuracy

                     # data quality 2.4.1 (horizpa) - Horizontal Positional Accuracy
                     horizontal_positional_accuracy_report = hDataQuality[:report].find do |report|
                        report[:type] == 'DQ_AbsoluteExternalPositionalAccuracy' &&
                        report.dig(:descriptiveResult, 0, :name) == 'Horizontal Positional Accuracy Report' &&
                        !report.dig(:descriptiveResult, 0, :statement).nil? 
                     end
                     horizpar = horizontal_positional_accuracy_report&.dig(:descriptiveResult, 0, :statement)
                     horizpav = horizontal_positional_accuracy_report&.dig(:quantitativeResult, 0, :values, 0)
                     horizpae = horizontal_positional_accuracy_report&.dig(:descriptiveResult, 1, :statement)

                     # data quality 2.4.2 (vertacc) - Vertical Positional Accuracy
                     vertical_positional_accuracy_report = hDataQuality[:report].find do |report|
                        report[:type] == 'DQ_AbsoluteExternalPositionalAccuracy' &&
                        report.dig(:descriptiveResult, 0, :name) == 'Vertical Positional Accuracy Report' &&
                        !report.dig(:descriptiveResult, 0, :statement).nil?
                     end
                     vertaccr = vertical_positional_accuracy_report&.dig(:descriptiveResult, 0, :statement)
                     vertaccv = vertical_positional_accuracy_report&.dig(:quantitativeResult, 0, :values, 0)
                     vertacce = vertical_positional_accuracy_report&.dig(:descriptiveResult, 1, :statement)

                     if horizpar || vertaccr
                        # data quality 2.4 (posacc) - Positional Accuracy
                        @xml.tag!('posacc') do
                           if horizpar
                              # data quality 2.4.1 (horizpa) - Horizontal Positional Accuracy
                              @xml.tag!('horizpa') do
                                 # data quality 2.4.1.1 (horizpar) - Horizontal Positional Accuracy Report
                                 @xml.tag!('horizpar', horizpar)
                                 if horizpav || horizpae
                                    # data quality 2.4.1.2 (qhorizpa) - Quantitative Horizontal Positional Accuracy
                                    @xml.tag!('qhorizpa') do
                                       if horizpav
                                          # data quality 2.4.1.2.1 (horizpav) - Horizontal Positional Accuracy Value
                                          @xml.tag!('horizpav', horizpav)
                                       end
                                       if horizpae
                                          # data quality 2.4.1.2.2 (horizpae) - Horizontal Positional Accuracy Explanation
                                          @xml.tag!('horizpae', horizpae)
                                       end
                                    end
                                 end
                              end
                           end

                           if vertaccr
                              # data quality 2.4.2 (vertacc) - Vertical Positional Accuracy
                              @xml.tag!('vertacc') do
                                 # data quality 2.4.2.1 (vertaccr) - Vertical Positional Accuracy Report
                                 @xml.tag!('vertaccr', vertaccr)
                                 if vertaccv || vertacce
                                    # data quality 2.4.2.2 (qvertpa) - Quantitative Vertical Positional Accuracy
                                    @xml.tag!('qvertpa') do
                                       if vertaccv
                                          # data quality 2.4.2.2.1 (vertaccv) - Vertical Positional Accuracy Value
                                          @xml.tag!('vertaccv', vertaccv)
                                       end
                                       if vertacce
                                          # data quality 2.4.2.2.2 (vertacce) - Vertical Positional Accuracy Explanation
                                          @xml.tag!('vertacce', vertacce)
                                       end
                                    end
                                 end
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
