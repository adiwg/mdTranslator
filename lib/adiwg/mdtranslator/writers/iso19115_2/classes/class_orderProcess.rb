# ISO <<Class>> MD_StandardOrderProcess
# 19115-2 writer output in XML

# History:
#  Stan Smith 2016-12-07 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#  Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
# 	Stan Smith 2013-09-25 original script.

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class MD_StandardOrderProcess

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hOrder)

                  # classes used

                  @xml.tag!('gmd:MD_StandardOrderProcess') do

                     # order process - fees
                     s = hOrder[:fees]
                     unless s.nil?
                        @xml.tag!('gmd:fees') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:fees')
                     end

                     # order process - plannedAvailableDateTime
                     hDateTime = hOrder[:plannedAvailability]
                     unless hDateTime.empty?
                        paDateTime = hDateTime[:dateTime]
                        paDateRes = hDateTime[:dateResolution]
                        @xml.tag!('gmd:plannedAvailableDateTime') do
                           dateTimeStr =
                              AdiwgDateTimeFun.stringDateTimeFromDateTime(paDateTime, paDateRes)
                           @xml.tag!('gco:DateTime', dateTimeStr)
                        end
                     end
                     if hDateTime.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:plannedAvailableDateTime')
                     end

                     # order process - orderingInstructions
                     s = hOrder[:orderingInstructions]
                     unless s.nil?
                        @xml.tag!('gmd:orderingInstructions') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:orderingInstructions')
                     end

                     # order process - turnaround
                     s = hOrder[:turnaround]
                     unless s.nil?
                        @xml.tag!('gmd:turnaround') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:turnaround')
                     end

                  end # gmd:MD_StandardOrderProcess tag
               end # writeXML
            end # MD_StandardOrderProcess class

         end
      end
   end
end
