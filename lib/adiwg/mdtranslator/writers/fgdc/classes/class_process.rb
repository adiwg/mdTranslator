# FGDC <<Class>> Process
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-03-19 refactored error and warning messaging
#  Stan Smith 2017-12-18 original script

require_relative '../fgdc_writer'
require_relative 'class_contact'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class Process

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(hStep)

                  # classes used
                  contactClass = Contact.new(@xml, @hResponseObj)

                  # process 2.5.2.1 (procdesc) - process description (required)
                  # <- resourceLineage.processStep.description
                  unless hStep[:description].nil?
                     @xml.tag!('procdesc', hStep[:description] )
                  end
                  if hStep[:description].nil?
                     @NameSpace.issueWarning(240, 'procdesc')
                  end

                  # process 2.5.2.2 (srcused) - source used citation abbreviation []
                  # <- processStep.stepSources.sourceId
                  haveSource = false
                  hStep[:stepSources].each do |hSource|
                     unless hSource[:sourceId].nil?
                        @xml.tag!('srcused', hSource[:sourceId])
                        haveSource = true
                     end
                  end
                  if !haveSource && @hResponseObj[:writerShowTags]
                     @xml.tag!('srcused')
                  end

                  # process 2.5.2.3 (procdate) - process date (required)
                  # process 2.5.2.4 (proctime) - process time
                  # <- processStep.timePeriod.endDateTime
                  haveProcDate = false
                  haveProcTime = false
                  unless hStep[:timePeriod].empty?
                     hTimePeriod = hStep[:timePeriod]
                     unless hTimePeriod.empty?
                        hEndDT = hTimePeriod[:endDateTime]
                        hEndDT = hTimePeriod[:startDateTime] if hEndDT.nil? || hEndDT.empty?
                        unless hEndDT.empty?
                           procDate = AdiwgDateTimeFun.stringDateFromDateTime(hEndDT[:dateTime], hEndDT[:dateResolution])
                           procTime = AdiwgDateTimeFun.stringTimeFromDateTime(hEndDT[:dateTime], hEndDT[:dateResolution])
                           procDate.gsub!(/[-]/,'')
                           unless procDate == 'ERROR'
                              @xml.tag!('procdate', procDate)
                              haveProcDate = true
                           end
                           unless procTime == 'ERROR'
                              @xml.tag!('proctime', procTime)
                              haveProcTime = true
                           end
                        end
                     end
                  end
                  unless haveProcDate
                     @NameSpace.issueWarning(241, 'procdate')
                  end
                  if !haveProcTime && @hResponseObj[:writerShowTags]
                     @xml.tag!('proctime')
                  end

                  # process 2.5.2.5 (srcprod) - source products citation abbreviation []
                  # <- processStep.stepProducts.sourceId
                  haveSource = false
                  hStep[:stepProducts].each do |hSource|
                     unless hSource[:sourceId].nil?
                        @xml.tag!('srcprod', hSource[:sourceId])
                        haveSource = true
                     end
                  end
                  if !haveSource && @hResponseObj[:writerShowTags]
                     @xml.tag!('srcprod')
                  end

                  # process 2.5.2.6 (proccont) - process contact {contact} first
                  haveProcessor = false
                  aRParties = hStep[:processors]
                  aProcessors = @NameSpace.find_responsibility(aRParties, 'processor')
                  aProcessors.each do |contactId|
                     hContact = @NameSpace.get_contact(contactId)
                     unless hContact.empty?
                        @xml.tag!('proccont') do
                           contactClass.writeXML(hContact)
                           haveProcessor = true
                           break
                        end
                     end
                  end
                  if !haveProcessor && @hResponseObj[:writerShowTags]
                     @xml.tag!('proccont')
                  end

               end # writeXML
            end # Process

         end
      end
   end
end
