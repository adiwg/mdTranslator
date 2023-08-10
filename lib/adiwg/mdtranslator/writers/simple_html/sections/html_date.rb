# HTML writer
# date

# History:
# 	Stan Smith 2015-03-23 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Simple_html

            class Html_Date

               def initialize(html)
                  @html = html
               end

               def writeHtml(hDate)

                  date = hDate[:date]
                  dateRes = hDate[:dateResolution]
                  dateStr = ''

                  unless date.nil?
                     case dateRes
                        when 'Y', 'YM', 'YMD'
                           dateStr = AdiwgDateTimeFun.stringDateFromDateTime(date, dateRes)
                        else
                           dateStr = AdiwgDateTimeFun.stringDateTimeFromDateTime(date, dateRes)
                     end
                  end

                  # datetime - required
                  @html.text!(hDate[:dateType] + ': ' + dateStr)

               end # writeHtml
            end # Html_Date

         end
      end
   end
end
