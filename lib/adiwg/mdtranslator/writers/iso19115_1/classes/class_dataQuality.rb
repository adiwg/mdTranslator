require_relative 'class_dataQualityReport'
require_relative 'class_citation'

module ADIWG
  module Mdtranslator
    module Writers
      module Iso19115_1

        class DQ_DataQuality
          def initialize(xml, hResponseObj)
            @xml = xml
            @hResponseObj = hResponseObj
          end

          def writeXML(hDataQuality)

            reportClass = DataQualityReport.new(@xml, @hResponseObj)
            citationClass = CI_Citation.new(@xml, @hResponseObj)

            @xml.tag!('mdq:DQ_DataQuality') do

              @xml.tag!('mdq:scope') do
                @xml.tag!('mcc:MD_Scope') do
                  @xml.tag!('mcc:level') do
                    @xml.tag!('mcc:MD_ScopeCode', codeList: "http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_ScopeCode", codeListValue: "series")
                  end
                end
              end

              unless hDataQuality[:standaloneQualityReport].nil? || hDataQuality[:standaloneQualityReport].empty?

                @xml.tag!('mdq:standaloneQualityReport') do
                  @xml.tag!('mdq:DQ_StandaloneQualityReportInformation') do
                    # reportReference

                    @xml.tag!('mdq:reportReference') do
                      citationClass.writeXML(hDataQuality[:standaloneQualityReport][:reportReference])
                    end


                    # abstract
                    @xml.tag!('mdq:abstract') do
                      @xml.tag!('gco:CharacterString', hDataQuality[:standaloneQualityReport][:abstract])
                    end
                  end
                end

              end

              # reports
              hDataQuality[:report].each do |hReport|
                unless hReport.nil? || hReport.empty?
                  reportClass.writeXML(hReport)
                end
                
              end
            end

          end
        end
      end
    end
  end
end
