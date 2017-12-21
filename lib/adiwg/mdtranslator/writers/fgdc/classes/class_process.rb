# FGDC <<Class>> Process
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2017-12-18 original script

require 'adiwg/mdtranslator/internal/module_dateTimeFun'
require_relative 'class_contact'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class Process

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
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
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Lineage Source is missing description'
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
                        unless hEndDT.empty?
                           procDate = AdiwgDateTimeFun.stringDateFromDateTime(hEndDT[:dateTime], hEndDT[:dateResolution])
                           procTime = AdiwgDateTimeFun.stringTimeFromDateTime(hEndDT[:dateTime], hEndDT[:dateResolution])
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
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Process Step is missing process date'
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

                  # process 2.5.2.6 (proccont) - process contact {contact}
                  unless hStep[:processors].empty?
                     @xml.tag!('proccont') do
                        contactClass.writeXML(hStep[:processors][0])
                     end
                  end
                  if hStep[:processors].empty? && @hResponseObj[:writerShowTags]
                     @xml.tag!('proccont')
                  end

               end # writeXML
            end # Process

         end
      end
   end
end
