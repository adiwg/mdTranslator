# ISO <<Class>> TimePeriod
# writer output in XML

# History:
# 	Stan Smith 2013-11-04 original script
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure

require 'module_dateTimeFun'

class TimePeriod

    def initialize(xml)
        @xml = xml
    end

    def writeXML(hTempP)

        timeID = hTempP[:timeId]
        if timeID.nil?
            $idCount = $idCount.succ
            timeID = 'timePeriod' + $idCount
        end

        @xml.tag!('gml:TimePeriod', {'gml:id' => timeID}) do

            # time period - description
            s = hTempP[:description]
            if !s.nil?
                @xml.tag!('gml:description', s)
            elsif $showAllTags
                @xml.tag!('gml:description')
            end

            # time period - begin position
            hDateTime = hTempP[:beginTime]
            timeInstant = hDateTime[:dateTime]
            timeResolution = hDateTime[:dateResolution]
            dateStr = AdiwgDateTimeFun.stringDateTimeFromDateTime(timeInstant, timeResolution)
            @xml.tag!('gml:beginPosition', dateStr)

            # time period - begin position
            hDateTime = hTempP[:endTime]
            timeInstant = hDateTime[:dateTime]
            timeResolution = hDateTime[:dateResolution]
            dateStr = AdiwgDateTimeFun.stringDateTimeFromDateTime(timeInstant, timeResolution)
            @xml.tag!('gml:endPosition', dateStr)

        end

    end

end


