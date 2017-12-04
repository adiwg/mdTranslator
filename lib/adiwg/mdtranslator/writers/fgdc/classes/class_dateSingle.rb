# FGDC <<Class>> DateSingle
# FGDC CSDGM writer output in XML

# History:
#   Stan Smith 2017-11-23 original script

require 'adiwg/mdtranslator/internal/module_dateTimeFun'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class DateSingle

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hDate)

                  sDate = AdiwgDateTimeFun.stringDateFromDateTime(hDate[:dateTime], hDate[:dateResolution])
                  sTime = AdiwgDateTimeFun.stringTimeFromDateTime(hDate[:dateTime], hDate[:dateResolution])

                  # single date 9.1 (sngdate) - single date (required)
                  @xml.tag!('sngdate') do

                     # single date 9.1.1 (caldate) - calendar date
                     unless sDate == 'ERROR'
                        @xml.tag!('caldate', sDate)
                     end
                     if sDate == 'ERROR'
                        @hResponseObj[:writerPass] = false
                        @hResponseObj[:writerMessages] << 'single date is missing or invalid'
                     end

                     # single date 9.1.2 (time) - time
                     unless sTime == 'ERROR'
                        @xml.tag!('time', sTime)
                     end
                     if sTime == 'ERROR' && @hResponseObj[:writerShowTags]
                        @xml.tag!('time')
                     end

                  end

               end # writeXML
            end # SingleDate

         end
      end
   end
end
