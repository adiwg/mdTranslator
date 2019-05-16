# ISO <<Class>> MD_StandardOrderProcess
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-04-10 original script.

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class MD_StandardOrderProcess

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hOrder)
                  
                  @xml.tag!('mrd:MD_StandardOrderProcess') do

                     # order process - fees
                     unless hOrder[:fees].nil?
                        @xml.tag!('mrd:fees') do
                           @xml.tag!('gco:CharacterString', hOrder[:fees])
                        end
                     end
                     if hOrder[:fees].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrd:fees')
                     end

                     # order process - plannedAvailableDateTime {DateTime}
                     hDateTime = hOrder[:plannedAvailability]
                     unless hDateTime.empty?
                        paDateTime = hDateTime[:dateTime]
                        paDateRes = hDateTime[:dateResolution]
                        @xml.tag!('mrd:plannedAvailableDateTime') do
                           dateTimeStr =
                              AdiwgDateTimeFun.stringDateTimeFromDateTime(paDateTime, paDateRes)
                           @xml.tag!('gco:DateTime', dateTimeStr)
                        end
                     end
                     if hDateTime.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrd:plannedAvailableDateTime')
                     end

                     # order process - orderingInstructions
                     unless hOrder[:orderingInstructions].nil?
                        @xml.tag!('mrd:orderingInstructions') do
                           @xml.tag!('gco:CharacterString', hOrder[:orderingInstructions])
                        end
                     end
                     if hOrder[:orderingInstructions].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrd:orderingInstructions')
                     end

                     # order process - turnaround
                     unless hOrder[:turnaround].nil?
                        @xml.tag!('mrd:turnaround') do
                           @xml.tag!('gco:CharacterString', hOrder[:turnaround])
                        end
                     end
                     if hOrder[:turnaround].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrd:turnaround')
                     end

                     # order process - orderOptions -  not implemented

                     # order process - orderOptionsType -  not implemented

                  end # mrd:MD_StandardOrderProcess tag
               end # writeXML
            end # MD_StandardOrderProcess class

         end
      end
   end
end
