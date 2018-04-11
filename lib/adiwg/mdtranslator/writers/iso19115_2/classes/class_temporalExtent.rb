# ISO <<Class>> EX_TemporalExtent
# 19115-2 writer output in XML

# History:
#  Stan Smith 2016-12-01 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#  Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#  Stan Smith 2014-06-03 add support for date as time instant
# 	Stan Smith 2013-11-15 original script

require_relative 'class_timeInstant'
require_relative 'class_timePeriod'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

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
