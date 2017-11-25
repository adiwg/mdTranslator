# Reader - fgdc to internal data structure
# unpack fgdc time period

# History:
#  Stan Smith 2017-11-06 add geologic time
#  Stan Smith 2017-08-17 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_dateTime'
require_relative 'module_geologicAge'

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

                  # current may have different element tags depending on timePeriod source
                  xCurrent = xTimePeriod.at('./current')
                  if xCurrent.nil?
                     xCurrent = xTimePeriod.at('./srccurr')
                  end
                  unless xCurrent.nil?
                     hTimePeriod[:description] = xCurrent.text
                  end

                  unless xTimeInfo.empty?

                     # time period 9.1 (sngdate) - single date
                     xSingle = xTimeInfo.xpath('./sngdate')
                     unless xSingle.empty?

                        # single date 9.1.1/9.1.2 (caldate/time) - single date/time {date} (required) {time}
                        date = xSingle.xpath('./caldate').text
                        time = xSingle.xpath('./time').text
                        unless date.empty?
                           hDateTime = DateTime.unpack(date, time, hResponseObj)
                           unless hDateTime.nil?
                              hTimePeriod[:endDateTime] = hDateTime
                              return hTimePeriod
                           end
                        end

                        # or bio extension's geologic age
                        xGeoAge = xSingle.xpath('./geolage')
                        unless xGeoAge.empty?
                           hGeoAge = GeologicAge.unpack(xGeoAge, hResponseObj)
                           unless hGeoAge.nil?
                              hTimePeriod[:endGeologicAge] = hGeoAge
                              return hTimePeriod
                           end
                        end

                     end

                     # time period 9.2 (mdattim) - multiple date times
                     # -> place into timePeriod since mdJson does not handle multi-date
                     # -> did not put multi-date in temporalExtent since it would be
                     # -> difficult to return it to the same context
                     xMulti = xTimeInfo.xpath('./mdattim')
                     unless xMulti.empty?

                        # use first occurrence of the multiple date-times as start date
                        xStart = xMulti.xpath('//sngdate').first
                        startDate = xStart.xpath('./caldate').text
                        startTime = xStart.xpath('./time').text
                        unless startDate.empty?
                           hStartDateTime = DateTime.unpack(startDate, startTime, hResponseObj)
                           unless hStartDateTime.nil?
                              hTimePeriod[:startDateTime] = hStartDateTime
                           end
                        end

                        # use last occurrence of the multiple date-times as end date
                        xEnd = xMulti.xpath('//sngdate').last
                        endDate = xEnd.xpath('./caldate').text
                        endTime = xEnd.xpath('./time').text
                        unless endDate.empty?
                           hEndDateTime = DateTime.unpack(endDate, endTime, hResponseObj)
                           unless hEndDateTime.nil?
                              hTimePeriod[:endDateTime] = hEndDateTime
                           end
                        end

                        # and/or bio extension's geologic age
                        axGeoAge = xMulti.xpath('//geolage')
                        unless axGeoAge.empty?

                           # use first occurrence of the multiple geologic age as start age
                           xGeoAge = axGeoAge.xpath('//geolage').first
                           unless xGeoAge.nil?
                              hGeoAge = GeologicAge.unpack(xGeoAge, hResponseObj)
                              unless hGeoAge.nil?
                                 hTimePeriod[:startGeologicAge] = hGeoAge
                              end
                           end

                           # use lase occurrence of the multiple geologic age as end age
                           if axGeoAge.length > 1
                              xGeoAge = axGeoAge.xpath('//geolage').last
                              unless xGeoAge.nil?
                                 hGeoAge = GeologicAge.unpack(xGeoAge, hResponseObj)
                                 unless hGeoAge.nil?
                                    hTimePeriod[:endGeologicAge] = hGeoAge
                                 end
                              end
                           end

                        end

                        return hTimePeriod

                     end

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

                        # and/or bio extension's geologic age
                        # start geologic age
                        xBegGeoAge = xRange.xpath('./beggeol')
                        unless xBegGeoAge.empty?
                           hGeoAge = GeologicAge.unpack(xBegGeoAge, hResponseObj)
                           unless hGeoAge.nil?
                              hTimePeriod[:startGeologicAge] = hGeoAge
                           end
                        end

                        # end geologic age
                        xEndGeoAge = xRange.xpath('./endgeol')
                        unless xEndGeoAge.empty?
                           hGeoAge = GeologicAge.unpack(xEndGeoAge, hResponseObj)
                           unless hGeoAge.nil?
                              hTimePeriod[:endGeologicAge] = hGeoAge
                           end
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
