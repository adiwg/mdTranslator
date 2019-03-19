# ISO <<Class>> EX_TemporalExtent
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-03-19 original script

require_relative 'class_timeInstant'
require_relative 'class_timePeriod'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class EX_TemporalExtent

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hTempEle)

                  # classes used
                  timeInstClass = TimeInstant.new(@xml, @hResponseObj)
                  timePeriodClass = TimePeriod.new(@xml, @hResponseObj)

                  @xml.tag!('gmd:EX_TemporalExtent') do

                     # temporal extent - time instant
                     hTimeInst = hTempEle[:timeInstant]
                     unless hTimeInst.empty?
                        @xml.tag!('gmd:extent') do
                           timeInstClass.writeXML(hTimeInst)
                        end
                     end

                     # temporal extent - time period
                     hTimePeriod = hTempEle[:timePeriod]
                     unless hTimePeriod.empty?
                        @xml.tag!('gmd:extent') do
                           timePeriodClass.writeXML(hTimePeriod)
                        end
                     end

                  end # EX_TemporalExtent tag
               end # writeXML
            end # EX_TemporalExtent class

         end
      end
   end
end
