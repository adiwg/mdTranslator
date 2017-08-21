# Reader - fgdc to internal data structure
# unpack fgdc time period

# History:
#  Stan Smith 2017-08-17 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_dateTime'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module TimePeriod

               def self.unpack(xTimePeriod, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hTimePeriod = intMetadataClass.newTimePeriod

                  # time period 9 (timeinfo) - time period information
                  xTimeInfo = xTimePeriod.xpath('./timeinfo')

                  unless xTimeInfo.empty?

                     # time period 9.1 (sngdate) - single date
                     xSingle = xTimeInfo.xpath('./sngdate')
                     unless xSingle.empty?

                        # single date 9.1.1/9.1.2 (caldate/time) - single date/time {date} (required) {time}
                        date = xSingle.xpath('./caldate').text
                        time = xSingle.xpath('./time').text
                        hDateTime = DateTime.unpack(date, time, hResponseObj)
                        unless hDateTime.nil?
                           hTimePeriod[:endDateTime] = hDateTime
                        end

                        return hTimePeriod

                     end

                     # time period 9.2 (mdattim) - multiple date times
                     # placed in temporal extent

                     # time period 9.3 (rngdates) - range of dates
                     xRange = xTimeInfo.xpath('./rngdates')
                     unless xRange.empty?

                        # range of dates 9.3.1 (begdate) - begin date {date} (required)
                        # range of dates 9.3.2 (begtime) - begin time {time}
                        beginDate = xRange.xpath('./begdate').text
                        beginTime = xRange.xpath('./begtime').text
                        hDateTime = DateTime.unpack(beginDate, beginTime, hResponseObj)
                        unless hDateTime.nil?
                           hTimePeriod[:startDateTime] = hDateTime
                        end

                        # range of dates 9.3.3 (enddate) - end date {date} (required)
                        # range of dates 9.3.4 (endtime) - end time {time}
                        endDate = xRange.xpath('./enddate').text
                        endTime = xRange.xpath('./endtime').text
                        hDateTime = DateTime.unpack(endDate, endTime, hResponseObj)
                        unless hDateTime.nil?
                           hTimePeriod[:endDateTime] = hDateTime
                        end

                        return hTimePeriod

                     end

                  end

                  return nil

               end

            end

         end
      end
   end
end
