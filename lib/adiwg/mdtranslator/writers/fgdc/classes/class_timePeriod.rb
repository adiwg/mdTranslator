# FGDC <<Class>> TimePeriod
# FGDC CSDGM writer output in XML

# History:
#   Stan Smith 2017-11-22 original script

require_relative 'class_dateSingle'
require_relative 'class_dateRange'
require_relative 'class_geologicAge'
require_relative 'class_geologicRange'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class TimePeriod

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hTimePeriod, currentTag)

                  # classes used
                  singDateClass = DateSingle.new(@xml, @hResponseObj)
                  rangeDateClass = DateRange.new(@xml, @hResponseObj)
                  geologicAgeClass = GeologicAge.new(@xml, @hResponseObj)
                  geologicRangeClass = GeologicRange.new(@xml, @hResponseObj)

                  hStartDate = hTimePeriod[:startDateTime]
                  hEndDate = hTimePeriod[:endDateTime]
                  hStartGeoAge = hTimePeriod[:startGeologicAge]
                  hEndGeoAge = hTimePeriod[:endGeologicAge]
                  current = hTimePeriod[:description]

                  dateCount = 0
                  ageCount = 0
                  dateCount += 1 unless hStartDate.empty?
                  dateCount += 1 unless hEndDate.empty?
                  ageCount += 1 unless hStartGeoAge.empty?
                  ageCount += 1 unless hEndGeoAge.empty?

                  if dateCount + ageCount == 0
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Time Period missing date item'
                  end

                  if dateCount > 0 && ageCount > 0
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Time Period must be either conventional or geologic time, not both'
                  end

                  @xml.tag!('timeinfo') do

                     # single date
                     if dateCount == 1
                        if hStartDate.empty?
                           singDateClass.writeXML(hEndDate)
                        else
                           singDateClass.writeXML(hStartDate)
                        end
                     end

                     # date range
                     if dateCount == 2
                        rangeDateClass.writeXML(hStartDate, hEndDate)
                     end

                     # single geologic age
                     if ageCount == 1
                        @xml.tag!('sngdate') do
                           @xml.tag!('geolage') do
                              if hStartGeoAge.empty?
                                 geologicAgeClass.writeXML(hEndGeoAge)
                              else
                                 geologicAgeClass.writeXML(hStartGeoAge)
                              end
                           end
                        end
                     end

                     # geologic age range
                     if ageCount == 2
                        @xml.tag!('rngdates') do
                           geologicRangeClass.writeXML(hStartGeoAge,hEndGeoAge )
                        end
                     end

                  end

                  # add timeInfo currentness (required)
                  unless current.nil?
                     @xml.tag!(currentTag, current)
                  end
                  if current.nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Time Info is missing time currentness'
                  end

               end # writeXML
            end # TimePeriod

         end
      end
   end
end
