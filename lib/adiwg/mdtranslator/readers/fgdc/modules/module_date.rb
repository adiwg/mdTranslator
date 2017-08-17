# Reader - fgdc to internal data structure
# unpack fgdc metadata date

# History:
#  Stan Smith 2017-08-15 original script

require 'nokogiri'
require 'date'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/internal/module_dateTimeFun'
require_relative 'module_fgdc'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module Date

               def self.unpack(date, time, type, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hDate = intMetadataClass.newDate

                  if date.nil? || date == ''
                     hResponseObj[:readerExecutionMessages] << 'date string is missing from date conversion'
                     hResponseObj[:readerExecutionPass] = false
                     return nil
                  end

                  if type.nil? || type == ''
                     hResponseObj[:readerExecutionMessages] << 'date type is missing from date conversion'
                     hResponseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # convert date from fgdc to iso format
                  year = date.byteslice(0,4)
                  month = date.byteslice(4,2)
                  day = date.byteslice(6,2)
                  month = '00' if month.nil? || month == ''
                  day = '00' if day.nil? || day == ''
                  dtIn = year + '-' + month + '-' + day

                  # add time element to date string
                  if time.empty?
                     dtIn = dtIn + 'T' + '00:00:00'
                  else
                     aTime = time.split(':')
                     hour = aTime[0]
                     minute = aTime[1]
                     second = aTime[2]
                     minute = '00' if minute.nil? || minute == ''
                     second = '00' if second.nil? || second == ''
                     dtIn = dtIn + 'T' + hour + ':' + minute + ':' + second
                  end

                  # determine if date/time is 'universal time' or other
                  timeFlag = Fgdc.get_metadata_time_convention
                  timeFlag = 'local time' if timeFlag.nil? || timeFlag == ''

                  # add offset to date/time string
                  if timeFlag == 'universal time'
                     dtIn = dtIn + '+00:00'
                  else
                     timeOffset = Time.now.gmt_offset
                     aOffset = timeOffset.divmod(3600)
                     hOffset = aOffset[0]
                     mOffset = aOffset[1] * 60
                     if hOffset >= 0
                        zone = '+' + '%02d' % hOffset + ':' + '%02d' % mOffset
                     else
                        zone = '%03d' % hOffset + ':' + '%02d' % mOffset
                     end
                     dtIn = dtIn + zone
                  end

                  # if dateTimeFromString fails, [0] = nil; [1] = 'ERROR'
                  aDateTimeReturn = AdiwgDateTimeFun.dateTimeFromString(dtIn)
                  if aDateTimeReturn[1] == 'ERROR'
                     hResponseObj[:readerExecutionMessages] << 'Date string is invalid'
                     hResponseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # if not 'universal time' change the offset to utc
                  dateTimeReturn = aDateTimeReturn[0]
                  if timeFlag == 'universal time'
                     utc = dateTimeReturn
                  else
                     utc = dateTimeReturn.new_offset(Rational(0,24))
                  end

                  # build internal date object
                  hDate[:date] = utc
                  hDate[:dateResolution] = aDateTimeReturn[1]
                  hDate[:dateType] = type

                  return hDate

               end

            end

         end
      end
   end
end
