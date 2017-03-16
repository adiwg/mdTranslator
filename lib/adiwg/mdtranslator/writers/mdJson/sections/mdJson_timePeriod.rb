# mdJson 2.0 writer - time period

# History:
#   Stan Smith 2017-03-14 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

# TODO complete tests after extent

require 'jbuilder'
require_relative 'mdJson_identifier'
require_relative 'mdJson_timeInterval'
require_relative 'mdJson_duration'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module TimePeriod

               def self.build(hTimePeriod)

                  startDate = hTimePeriod[:startDateTime][:dateTime]
                  startRes = hTimePeriod[:startDateTime][:dateResolution]
                  startString = ''

                  unless startDate.nil?
                     case startRes
                        when 'Y', 'YM', 'YMD'
                           startString = AdiwgDateTimeFun.stringDateFromDateTime(startDate, startRes)
                        else
                           startString = AdiwgDateTimeFun.stringDateTimeFromDateTime(startDate, startRes)
                     end
                  end

                  endDate = hTimePeriod[:endDateTime][:dateTime]
                  endRes = hTimePeriod[:endDateTime][:dateResolution]
                  endString = ''

                  unless endDate.nil?
                     case endRes
                        when 'Y', 'YM', 'YMD'
                           endString = AdiwgDateTimeFun.stringDateFromDateTime(endDate, endRes)
                        else
                           endString = AdiwgDateTimeFun.stringDateTimeFromDateTime(endDate, endRes)
                     end
                  end

                  Jbuilder.new do |json|
                     json.id hTimePeriod[:timeId]
                     json.description hTimePeriod[:description]
                     json.identifier Identifier.build(hTimePeriod[:identifier]) unless hTimePeriod[:identifier].empty?
                     json.periodName hTimePeriod[:periodNames] unless hTimePeriod[:periodNames].empty?
                     json.startDateTime startString unless startString == ''
                     json.endDateTime endString unless endString == ''
                     json.timeInterval TimeInterval.build(hTimePeriod[:timeInterval]) unless hTimePeriod[:timeInterval].empty?
                     json.duration Duration.build(hTimePeriod[:duration]) unless hTimePeriod[:duration].empty?
                     # duration
                  end

               end # build
            end # TimePeriod

         end
      end
   end
end
