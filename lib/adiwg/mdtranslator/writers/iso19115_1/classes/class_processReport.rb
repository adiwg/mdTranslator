# ISO <<Class>> LE_ProcessStepReport
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-09-27 original script.

require_relative '../iso19115_1_writer'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class LE_ProcessStepReport

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_1
               end

               def writeXML(hReport, inContext = nil)

                  outContext = 'process step report'
                  outContext = inContext + ' ' + outContext unless inContext.nil?

                  @xml.tag!('mrl:LE_ProcessStepReport') do

                     # process step report - name (required)
                     unless hReport[:name].nil?
                        @xml.tag!('mrl:name') do
                           @xml.tag!('gco:CharacterString', hReport[:name])
                        end
                     end
                     if hReport[:name].nil?
                        @NameSpace.issueWarning(440, 'mrl:name', outContext)
                     end

                     # process step report - description
                     unless hReport[:description].nil?
                        @xml.tag!('mrl:description') do
                           @xml.tag!('gco:CharacterString', hReport[:description])
                        end
                     end
                     if hReport[:description].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrl:description')
                     end

                     # process step report - file type
                     unless hReport[:fileType].nil?
                        @xml.tag!('mrl:fileType') do
                           @xml.tag!('gco:CharacterString', hReport[:fileType])
                        end
                     end
                     if hReport[:fileType].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrl:fileType')
                     end

                  end # mrl:LE_ProcessStepReport
               end # writeXML
            end # LE_ProcessStepReport class

         end
      end
   end
end
