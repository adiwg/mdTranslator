# mdJson 2.0 writer - citation

# History:
#   Stan Smith 2017-03-20 original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module DateTime

               def self.build(hDateTime)

                  date = hDateTime[:dateTime]
                  dateRes = hDateTime[:dateResolution]
                  dateStr = ''

                  unless date.nil?
                     case dateRes
                        when 'Y', 'YM', 'YMD'
                           dateStr = AdiwgDateTimeFun.stringDateFromDateTime(date, dateRes)
                        else
                           dateStr = AdiwgDateTimeFun.stringDateTimeFromDateTime(date, dateRes)
                     end
                  end

                  return dateStr

               end # build
            end # DateTime

         end
      end
   end
end
