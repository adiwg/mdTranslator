# FGDC <<Class>> DateSingle
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-02-26 refactored error and warning messaging
#  Stan Smith 2018-01-19 convert ISO date formats to FGDC
#  Stan Smith 2017-11-23 original script

require 'adiwg/mdtranslator/internal/module_dateTimeFun'
require_relative '../fgdc_writer'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class DateSingle

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(hDate)

                  sDate = AdiwgDateTimeFun.stringDateFromDateTime(hDate[:dateTime], hDate[:dateResolution])
                  sTime = AdiwgDateTimeFun.stringTimeFromDateTime(hDate[:dateTime], hDate[:dateResolution])

                  # convert ISO date format to FGDC
                  sDate.gsub!(/[-]/,'')

                  # single date 9.1 (sngdate) - single date (required)
                  @xml.tag!('sngdate') do

                     # single date 9.1.1 (caldate) - calendar date
                     unless sDate == 'ERROR'
                        @xml.tag!('caldate', sDate)
                     end
                     if sDate == 'ERROR'
                        @NameSpace.issueError('single date is invalid',
                                              'multi date/time time period')
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
