# ISO <<Class>> TimePeriod
# 19115-3 writer output in XML

# History:
# 	Stan Smith 2019-03-19 original script.

require_relative 'class_gmlIdentifier'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class TimePeriod

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hPeriod)

                  # classes used
                  gmlClass = GMLIdentifier.new(@xml, @hResponseObj)

                  # TimePeriod must have a uniqueID
                  timeID = hPeriod[:timeId]
                  if timeID.nil?
                     @hResponseObj[:writerMissingIdCount] = @hResponseObj[:writerMissingIdCount].succ
                     timeID = 'timePeriod' + @hResponseObj[:writerMissingIdCount]
                  else
                     timeID.gsub!(/[^0-9a-zA-Z]/, '')
                  end

                  @xml.tag!('gml:TimePeriod', {'gml:id' => timeID}) do

                     # time period - description
                     unless hPeriod[:description].nil?
                        @xml.tag!('gml:description', hPeriod[:description])
                     end
                     if hPeriod[:description].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gml:description')
                     end

                     # time period - identifier {gmlIdentifier}
                     hGMLid = hPeriod[:identifier]
                     unless hGMLid.empty?
                        gmlClass.writeXML(hGMLid)
                     end
                     if hGMLid.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gml:identifier', {'codeSpace' => ''})
                     end

                     # time period - names []
                     aNames = hPeriod[:periodNames]
                     aNames.each do |name|
                        @xml.tag!('gml:name', name)
                     end
                     if aNames.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gml:name')
                     end

                     # time period - begin position
                     # tag always required, however value may be empty
                     # if empty add indeterminatePosition="unknown"
                     unless hPeriod[:startDateTime].empty?
                        hDateTime = hPeriod[:startDateTime]
                        dateTime = hDateTime[:dateTime]
                        timeResolution = hDateTime[:dateResolution]
                        dateStr = AdiwgDateTimeFun.stringDateTimeFromDateTime(dateTime, timeResolution)
                        @xml.tag!('gml:beginPosition', dateStr)
                     end
                     if hPeriod[:startDateTime].empty?
                        @xml.tag!('gml:beginPosition', {indeterminatePosition: 'unknown'})
                     end

                     # time period - begin position
                     # tag always required, however value may be empty
                     # if empty add indeterminatePosition="unknown"
                     unless hPeriod[:endDateTime].empty?
                        hDateTime = hPeriod[:endDateTime]
                        dateTime = hDateTime[:dateTime]
                        timeResolution = hDateTime[:dateResolution]
                        dateStr = AdiwgDateTimeFun.stringDateTimeFromDateTime(dateTime, timeResolution)
                        @xml.tag!('gml:endPosition', dateStr)
                     end
                     if hPeriod[:endDateTime].empty?
                        @xml.tag!('gml:endPosition', {indeterminatePosition: 'unknown'})
                     end

                     # time period - time interval
                     hInterval = hPeriod[:timeInterval]
                     unless hInterval.empty?
                        units = hInterval[:units]
                        interval = hInterval[:interval]
                        @xml.tag!('gml:timeInterval', {'unit' => units}, interval)
                     end

                     # time period - duration (do not output if have time interval)
                     hDuration = hPeriod[:duration]
                     if hInterval.empty? && !hDuration.empty?
                        duration = AdiwgDateTimeFun.writeDuration(hDuration)
                        @xml.tag!('gml:duration', duration)
                     end

                  end # TimePeriod tag
               end # writeXML
            end # TimePeriod class

         end
      end
   end
end
