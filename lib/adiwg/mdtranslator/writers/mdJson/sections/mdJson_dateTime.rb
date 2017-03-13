# mdJson 2.0 writer - citation

# History:
#   Stan Smith 2017-03-11 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

# TODO test all date formats

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module DateTime

               def self.build(hDate)

                  date = hDate[:date]
                  dateRes = hDate[:dateResolution]
                  dateStr = ''

                  unless date.nil?
                     case dateRes
                        when 'Y', 'YM', 'YMD'
                           dateStr = AdiwgDateTimeFun.stringDateFromDateTime(date, dateRes)
                        when 'YMDh', 'YMDhm', 'YMDhms'
                           dateStr = AdiwgDateTimeFun.stringDateTimeFromDateTime(date, 'YMDhms')
                        when 'YMDhZ', 'YMDhmZ', 'YMDhmsZ'
                           dateStr = AdiwgDateTimeFun.stringDateTimeFromDateTime(date, 'YMDhmsZ')
                        else
                           dateStr = AdiwgDateTimeFun.stringDateTimeFromDateTime(date, dateRes)
                     end
                  end

                  Jbuilder.new do |json|
                     json.date(dateStr)
                     json.dateType hDate[:dateType]
                  end

               end # build
            end # DateTime

         end
      end
   end
end
