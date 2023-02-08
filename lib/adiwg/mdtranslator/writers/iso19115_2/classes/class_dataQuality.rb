# ISO <<Class>> DQ_DataQuality
# 19115-2 writer output in XML

# History:
#  Stan Smith 2018-04-09 add error and warning messaging
#  Stan Smith 2016-12-13 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#  Stan Smith 2015-06-11 change all codelists to use 'class_codelist' method
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#  Stan Smith 2014-07-09 modify require statements to function in RubyGem structure
# 	Stan Smith 2013-11-20 original script

require_relative '../iso19115_2_writer'
require_relative 'class_scope'
require_relative 'class_lineage'
require_relative 'class_dataQualityReport'
require_relative 'class_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class DQ_DataQuality

               def initialize(xml, responseObj)
                  @xml = xml
                  @hResponseObj = responseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_2
               end

               def writeXML(hLineage, options = {})

                  hDataQuality = {}
                  dataQualityNamespace = 'gmd'
                  if options[:dataQualityType] == 'mdb'
                     hDataQuality = hLineage
                     dataQualityNamespace = 'mdq'
                  end

                  # classes used
                  scopeClass = DQ_Scope.new(@xml, @hResponseObj)
                  lineClass = LI_Lineage.new(@xml, @hResponseObj)
                  reportClass = DataQualityReport.new(@xml, @hResponseObj)
                  citationClass = CI_Citation.new(@xml, @hResponseObj)

                  outContext = 'data quality'

                  @xml.tag!("#{dataQualityNamespace}:DQ_DataQuality") do

                     # data quality - scope {DQ_Scope} (required)
                     if options[:dataQualityType] == 'mdb'
                        @xml.tag!('mdq:scope') do
                           @xml.tag!('mcc:MD_Scope') do
                              @xml.tag!('mcc:level') do
                                 @xml.tag!('mcc:MD_ScopeCode', codeList: "http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_ScopeCode", codeListValue: "series")
                              end
                           end
                        end
                     else
                        hScope = hLineage[:resourceScope]
                        unless hScope.nil? || hScope.empty?
                           @xml.tag!('gmd:scope') do
                              scopeClass.writeXML(hScope, outContext)
                           end
                        end
                        if hScope.nil? || hScope.empty?
                           @NameSpace.issueWarning(60, 'gmd:scope', outContext)
                        end
                     end


                     unless hDataQuality[:standaloneQualityReport].nil? || hDataQuality[:standaloneQualityReport].empty?

                        @xml.tag!('mdq:standaloneQualityReport') do
                           @xml.tag!('mdq:DQ_StandaloneQualityReportInformation') do
                              # reportReference
                              unless hDataQuality[:standaloneQualityReport][:reportReference].nil? || hDataQuality[:standaloneQualityReport][:reportReference].empty?
                                 @xml.tag!('mdq:reportReference') do
                                    citationClass.writeXML(hDataQuality[:standaloneQualityReport][:reportReference])
                                 end
                              end

                              unless hDataQuality[:standaloneQualityReport][:abstract].nil? || hDataQuality[:standaloneQualityReport][:abstract].empty?
                                 # abstract
                                 @xml.tag!('mdq:abstract') do
                                    @xml.tag!('gco:CharacterString', hDataQuality[:standaloneQualityReport][:abstract])
                                 end
                              end
                           end
                        end

                     end

                     # date quality - report (moved to ISO 19157)
                     unless hDataQuality[:report].nil?
                        hDataQuality[:report].each do |hReport|
                           unless hReport.nil? || hReport.empty?
                              reportClass.writeXML(hReport)
                           end
                        end
                     end

                     # data quality - lineage
                     unless options[:dataQualityType] == 'mdb'
                        @xml.tag!('gmd:lineage') do
                           lineClass.writeXML(hLineage)
                        end
                     end

                  end # gmd:DQ_DataQuality tag
               end # writeXML
            end # DQ_DataQuality class

         end
      end
   end
end
