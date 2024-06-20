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
                     thematic_classification_report = hDataQuality[:report].find do |report|
                        report[:type] == 'DQ_ThematicClassificationCorrectness'
                     end
                     attribute_accuracy_report_text = ''
                     if attribute_accuracy_report
                        attribute_accuracy_report_text = attribute_accuracy_report[:descriptiveResult][0][:statement]
                     end
                     if thematic_classification_report
                        if attribute_accuracy_report_text != ''
                           attribute_accuracy_report_text = attribute_accuracy_report_text + ' ' + thematic_classification_report[:descriptiveResult][0][:statement]
                        else
                           attribute_accuracy_report_text = thematic_classification_report[:descriptiveResult][0][:statement]
                        end
                     end
                     quantitative_attribute_accuracy = hDataQuality[:report].find do |report|
                        report[:type] == 'DQ_QuantitativeAttributeAccuracy'
                     end
                     attribute_accuracy_value = quantitative_attribute_accuracy.dig(:quantitativeResult, 0, :values, 0) if quantitative_attribute_accuracy
                     attribute_evaluation_method = quantitative_attribute_accuracy.dig(:evaluationMethod, :methodDescription) if quantitative_attribute_accuracy
                     if attribute_accuracy_report_text != '' || attribute_accuracy_value || attribute_evaluation_method
                        # data quality 2.1 (attracc) - Attribute Accuracy
                        @xml.tag!('attracc') do
                           if attribute_accuracy_report_text != ''
                              # data quality 2.1.1 (attraccr) - Attribute Accuracy Report
                              @xml.tag!('attraccr', attribute_accuracy_report_text)
                           end
                           if attribute_accuracy_value || attribute_evaluation_method
                              # data quality 2.1.2 (qattracc) - Quantitative Attribute Accuracy Assessment
                              @xml.tag!('qattracc') do
                                 if attribute_accuracy_value
                                    # data quality 2.1.2.1 (attraccv) - Attribute Accuracy Value
                                    @xml.tag!('attraccv', attribute_accuracy_value)
                                 end
                                 if attribute_evaluation_method
                                    # data quality 2.1.2.2 (attracce) - Attribute Accuracy Explanation
                                    @xml.tag!('attracce', attribute_evaluation_method)
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
                     domain_report = hDataQuality[:report].find do |report|
                        report[:type] == 'DQ_DomainConsistency' &&
                        !report.dig(:descriptiveResult, 0, :statement).nil?
                     end
                     format_report = hDataQuality[:report].find do |report|
                        report[:type] == 'DQ_FormatConsistency' &&
                        !report.dig(:descriptiveResult, 0, :statement).nil?
                     end
                     topological_report = hDataQuality[:report].find do |report|
                        report[:type] == 'DQ_TopologicalConsistency' &&
                        !report.dig(:descriptiveResult, 0, :statement).nil?
                     end
                     logic = ''
                     if logic_report
                        logic = logic_report[:descriptiveResult][0][:statement]
                     end
                     if domain_report
                        if logic != ''
                           logic = logic + ' ' + domain_report[:descriptiveResult][0][:statement]
                        else
                           logic = domain_report[:descriptiveResult][0][:statement]
                        end
                     end
                     if format_report
                        if logic != ''
                           logic = logic + ' ' + format_report[:descriptiveResult][0][:statement]
                        else
                           logic = format_report[:descriptiveResult][0][:statement]
                        end
                     end
                     if topological_report
                        if logic != ''
                           logic = logic + ' ' + topological_report[:descriptiveResult][0][:statement]
                        else
                           logic = topological_report[:descriptiveResult][0][:statement]
                        end
                     end
                     if logic != ''
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

                     # data quality 2.4 (posacc) - Positional Accuracy
                     # data quality 2.4.1 (horizpa) - Horizontal Positional Accuracy
                     reports = hDataQuality[:report].select do |report|
                        [
                          'DQ_AbsoluteExternalPositionalAccuracy',
                          'DQ_RelativeInternalPositionalAccuracy',
                          'DQ_GriddedDataPositionalAccuracy'
                        ].include?(report[:type]) &&
                        report.dig(:descriptiveResult, 0, :name) == 'Horizontal Positional Accuracy Report' &&
                        !report.dig(:descriptiveResult, 0, :statement).nil?
                     end
                     
                     horizpar = ''
                     horizpav = ''
                     horizpae = ''
                      
                     reports.each do |report|
                        if report[:descriptiveResult]
                           report[:descriptiveResult].each do |result|
                              if result[:name] == 'Horizontal Positional Accuracy Report'
                                 horizpar = horizpar.empty? ? result[:statement] : "#{horizpar} #{result[:statement]}"
                              elsif result[:name] == 'Horizontal Positional Accuracy Explanation'
                                 horizpae = horizpae.empty? ? result[:statement] : "#{horizpae} #{result[:statement]}"
                              end
                           end
                        end
                        if report[:quantitativeResult]
                           report[:quantitativeResult].each do |result|
                              if result[:name] == 'Horizontal Positional Accuracy Value' && horizpav.empty?
                                 horizpav = result[:values][0]
                              end
                           end
                        end
                     end
                      
                     # data quality 2.4.2 (vertacc) - Vertical Positional Accuracy
                     reports = hDataQuality[:report].select do |report|
                        [
                          'DQ_AbsoluteExternalPositionalAccuracy',
                          'DQ_RelativeInternalPositionalAccuracy',
                          'DQ_GriddedDataPositionalAccuracy'
                        ].include?(report[:type]) &&
                        report.dig(:descriptiveResult, 0, :name) == 'Vertical Positional Accuracy Report' &&
                        !report.dig(:descriptiveResult, 0, :statement).nil?
                      end
                     
                     vertaccr = ''
                     vertaccv = ''
                     vertacce = ''

                     reports.each do |report|
                        if report[:descriptiveResult]
                           report[:descriptiveResult].each do |result|
                              if result[:name] == 'Vertical Positional Accuracy Report'
                                 vertaccr = vertaccr.empty? ? result[:statement] : "#{vertaccr} #{result[:statement]}"
                              elsif result[:name] == 'Vertical Positional Accuracy Explanation'
                                 vertacce = vertacce.empty? ? result[:statement] : "#{vertacce} #{result[:statement]}"
                              end
                           end
                        end
                        if report[:quantitativeResult]
                           report[:quantitativeResult].each do |result|
                              if result[:name] == 'Vertical Positional Accuracy Value' && vertaccv.empty?
                                 vertaccv = result[:values][0]
                              end
                           end
                        end
                     end

                     if !horizpar.empty? || !vertaccr.empty?
                        # Data quality 2.4 (posacc) - Positional Accuracy
                        @xml.tag!('posacc') do
                           if !horizpar.empty?
                              # Data quality 2.4.1 (horizpa) - Horizontal Positional Accuracy
                              @xml.tag!('horizpa') do
                                 # Data quality 2.4.1.1 (horizpar) - Horizontal Positional Accuracy Report
                                 @xml.tag!('horizpar', horizpar)
                                 if horizpav != '' || !horizpae.empty?
                                    # Data quality 2.4.1.2 (qhorizpa) - Quantitative Horizontal Positional Accuracy
                                    @xml.tag!('qhorizpa') do
                                       if horizpav != ''
                                          # Data quality 2.4.1.2.1 (horizpav) - Horizontal Positional Accuracy Value
                                          @xml.tag!('horizpav', horizpav)
                                       end
                                       if !horizpae.empty?
                                          # Data quality 2.4.1.2.2 (horizpae) - Horizontal Positional Accuracy Explanation
                                          @xml.tag!('horizpae', horizpae)
                                       end
                                    end
                                 end
                              end
                           end
                        
                           if !vertaccr.empty?
                              # Data quality 2.4.2 (vertacc) - Vertical Positional Accuracy
                              @xml.tag!('vertacc') do
                                 # Data quality 2.4.2.1 (vertaccr) - Vertical Positional Accuracy Report
                                 @xml.tag!('vertaccr', vertaccr)
                                 if vertaccv != '' || !vertacce.empty?
                                    # Data quality 2.4.2.2 (qvertpa) - Quantitative Vertical Positional Accuracy
                                    @xml.tag!('qvertpa') do
                                       if vertaccv != ''
                                          # Data quality 2.4.2.2.1 (vertaccv) - Vertical Positional Accuracy Value
                                          @xml.tag!('vertaccv', vertaccv)
                                       end
                                       if !vertacce.empty?
                                          # Data quality 2.4.2.2.2 (vertacce) - Vertical Positional Accuracy Explanation
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
