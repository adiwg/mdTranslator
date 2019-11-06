# ISO <<Class>> LE_ProcessStepReport
# 19115-2 writer output in XML

# History:
# 	Stan Smith 2019-09-25 original script.

require_relative '../iso19115_2_writer'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class LE_ProcessStepReport

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_2
               end

               def writeXML(hReport, inContext = nil)

                  outContext = 'process step report'
                  outContext = inContext + ' ' + outContext unless inContext.nil?

                  @xml.tag!('gmi:LE_ProcessStepReport') do

                     # process step report - name (required)
                     unless hReport[:name].nil?
                        @xml.tag!('gmi:name') do
                           @xml.tag!('gco:CharacterString', hReport[:name])
                        end
                     end
                     if hReport[:name].nil?
                        @NameSpace.issueWarning(410, 'gmi:name', outContext)
                     end

                     # process step report - description
                     unless hReport[:description].nil?
                        @xml.tag!('gmi:description') do
                           @xml.tag!('gco:CharacterString', hReport[:description])
                        end
                     end
                     if hReport[:description].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmi:description')
                     end

                     # process step report - file type
                     unless hReport[:fileType].nil?
                        @xml.tag!('gmi:fileType') do
                           @xml.tag!('gco:CharacterString', hReport[:fileType])
                        end
                     end
                     if hReport[:fileType].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmi:fileType')
                     end

                  end # gmi:LE_ProcessStepReport
               end # writeXML
            end # LE_ProcessStepReport class

         end
      end
   end
end
