require_relative 'class_dataQualityReport'

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

            @xml.tag!('mdq:DQ_DataQuality') do

              @xml.tag!('mdq:scope') do
                @xml.tag!('mcc:MD_Scope') do
                  @xml.tag!('mcc:level') do
                    @xml.tag!('mcc:MD_ScopeCode', codeList: "http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_ScopeCode", codeListValue: "series")
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
