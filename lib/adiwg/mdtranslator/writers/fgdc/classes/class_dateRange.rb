# FGDC <<Class>> DateRange
# FGDC CSDGM writer output in XML

# History:
#   Stan Smith 2017-11-23 original script

require 'adiwg/mdtranslator/internal/module_dateTimeFun'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class DateRange

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hStartDT, hEndDT)

                  sSDate = AdiwgDateTimeFun.stringDateFromDateTime(hStartDT[:dateTime], hStartDT[:dateResolution])
                  sSTime = AdiwgDateTimeFun.stringTimeFromDateTime(hStartDT[:dateTime], hStartDT[:dateResolution])
                  sEDate = AdiwgDateTimeFun.stringDateFromDateTime(hEndDT[:dateTime], hEndDT[:dateResolution])
                  sETime = AdiwgDateTimeFun.stringTimeFromDateTime(hEndDT[:dateTime], hEndDT[:dateResolution])

                  # single date 9.3 (rngdates) - date range
                  @xml.tag!('rngdates') do

                     # range date 9.3.1 (begdate) - range start date (required)
                     unless sSDate == 'ERROR'
                        @xml.tag!('begdate', sSDate)
                     end
                     if sSDate == 'ERROR'
                        @hResponseObj[:writerPass] = false
                        @hResponseObj[:writerMessages] << 'Date Range start date is missing or invalid'
                     end

                     # range date 9.3.2 (begtime) - range start date
                     unless sSTime == 'ERROR'
                        @xml.tag!('begtime', sSTime)
                     end
                     if sSTime == 'ERROR' && @hResponseObj[:writerShowTags]
                        @xml.tag!('begtime')
                     end

                     # range date 9.3.3 (enddate) - range end date (required)
                     unless sEDate == 'ERROR'
                        @xml.tag!('enddate', sEDate)
                     end
                     if sEDate == 'ERROR'
                        @hResponseObj[:writerPass] = false
                        @hResponseObj[:writerMessages] << 'Date Range end date is missing or invalid'
                     end

                     # range date 9.3.4 (endtime) - range end date
                     unless sETime == 'ERROR'
                        @xml.tag!('endtime', sETime)
                     end
                     if sETime == 'ERROR' && @hResponseObj[:writerShowTags]
                        @xml.tag!('endtime')
                     end

                  end

               end # writeXML
            end # DateRange

         end
      end
   end
end
