# ISO <<Class>> Date, DateTime
# 19115-2 writer output in XML

# History:
# 	Stan Smith 2017-02-10 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class GcoDateTime

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hDate)

                  date = hDate[:date]
                  dateRes = hDate[:dateResolution]

                  # date - date (required)
                  unless date.nil?
                     case dateRes
                        when 'Y', 'YM', 'YMD'
                           dateStr = AdiwgDateTimeFun.stringDateFromDateTime(date, dateRes)
                           @xml.tag!('gco:Date', dateStr)
                        when 'YMDh', 'YMDhm', 'YMDhms'
                           dateStr = AdiwgDateTimeFun.stringDateTimeFromDateTime(date, 'YMDhms')
                           @xml.tag!('gco:DateTime', dateStr)
                        when 'YMDhZ', 'YMDhmZ', 'YMDhmsZ'
                           dateStr = AdiwgDateTimeFun.stringDateTimeFromDateTime(date, 'YMDhmsZ')
                           @xml.tag!('gco:DateTime', dateStr)
                        else
                           dateStr = AdiwgDateTimeFun.stringDateTimeFromDateTime(date, dateRes)
                           @xml.tag!('gco:DateTime', dateStr)
                     end
                  end

               end # write XML
            end # Date class

         end
      end
   end
end
