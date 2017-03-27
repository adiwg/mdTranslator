# HTML writer
# datetime

# History:
# 	Stan Smith 2015-03-25 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_Datetime

               def initialize(html)
                  @html = html
               end

               def writeHtml(hDatetime)

                  date = hDatetime[:dateTime]
                  dateRes = hDatetime[:dateResolution]
                  dateStr = ''

                  unless date.nil?
                     case dateRes
                        when 'Y', 'YM', 'YMD'
                           dateStr = AdiwgDateTimeFun.stringDateFromDateTime(date, dateRes)
                        else
                           dateStr = AdiwgDateTimeFun.stringDateTimeFromDateTime(date, dateRes)
                     end
                  end

                  # datetime - return string
                  dateStr

               end # writeHtml
            end # Html_Datetime

         end
      end
   end
end
