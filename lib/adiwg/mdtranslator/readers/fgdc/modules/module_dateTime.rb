# Reader - fgdc to internal data structure
# unpack fgdc metadata date

# History:
#  Stan Smith 2017-08-15 original script

require 'date'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/internal/module_dateTimeFun'
require_relative 'module_fgdc'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module DateTime

               def self.unpack(date, time, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hDateTime = intMetadataClass.newDateTime

                  if date.nil? || date == ''
                     hResponseObj[:readerExecutionMessages] << 'ERROR: FGDC reader: date missing from dateTime creation'
                     hResponseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # remove invalid date and time input strings
                  unless date =~ /^[0-9\-]*$/
                     return nil
                  end
                  unless time =~ /^[0-9:]*$/
                     time = ''
                  end

                  # convert date from fgdc to iso format
                  year = date.byteslice(0,4)
                  month = date.byteslice(4,2)
                  day = date.byteslice(6,2)

                  haveFullDate = false
                  dtIn = year
                  unless month.nil? || month == ''
                     dtIn += '-' + month
                     unless day.nil? || day == ''
                        dtIn += '-' + day
                        haveFullDate = true
                     end
                  end

                  # if have full date
                  # add time element to date string
                  if haveFullDate
                     aScan = time.scan(/:/)
                     if aScan.empty?
                        hour = time.byteslice(0,2)
                        minute = time.byteslice(2,2)
                        second = time.byteslice(4,2)
                     else
                        aTime = time.split(':')
                        hour = aTime[0]
                        minute = aTime[1]
                        second = aTime[2]
                     end
                     tmIn = ''
                     unless hour.nil? || hour == ''
                        tmIn += 'T' + hour
                        unless minute.nil? || minute == ''
                           tmIn += ':' + minute
                           unless second.nil? || second == ''
                              tmIn += ':' + second
                           end
                        end
                     end
                     unless tmIn == ''
                        dtIn += tmIn

                        # determine if date/time is 'universal time' or other
                        # default to other (local time)
                        zoneFlag = Fgdc.get_metadata_time_convention
                        zoneFlag = 'local time' if zoneFlag.nil? || zoneFlag == ''

                        # add offset to date/time string
                        if zoneFlag == 'universal time'
                           dtIn = dtIn + '+00:00'
                        else
                           timeOffset = Time.now.gmt_offset
                           aOffset = timeOffset.divmod(3600)
                           hourOff = aOffset[0]
                           minOff = aOffset[1] * 60
                           if hourOff >= 0
                              zone = '+' + '%02d' % hourOff + ':' + '%02d' % minOff
                           else
                              zone = '%03d' % hourOff + ':' + '%02d' % minOff
                           end
                           dtIn = dtIn + zone
                        end

                     end
                  end

                  # if dateTimeFromString fails, [0] = nil; [1] = 'ERROR'
                  aDateTimeReturn = AdiwgDateTimeFun.dateTimeFromString(dtIn)
                  if aDateTimeReturn[1] == 'ERROR'
                     hResponseObj[:readerExecutionMessages] << 'ERROR: FGDC reader: Conversion of dateTime string to object failed'
                     hResponseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # output in 'universal time' 
                  dateTimeReturn = aDateTimeReturn[0]
                  if zoneFlag == 'universal time'
                     utc = dateTimeReturn
                  else
                     utc = dateTimeReturn.new_offset(Rational(0,24))
                  end

                  # build internal dateTime object
                  hDateTime[:dateTime] = utc
                  hDateTime[:dateResolution] = aDateTimeReturn[1]

                  return hDateTime

               end

            end

         end
      end
   end
end
