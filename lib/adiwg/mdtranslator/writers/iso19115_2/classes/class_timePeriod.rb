# ISO <<Class>> TimePeriod
# writer output in XML

# History:
# 	Stan Smith 2013-11-04 original script.
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class TimePeriod

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hTempP)

                        timeID = hTempP[:timeId]
                        if timeID.nil?
                            @responseObj[:missingIdCount] = @responseObj[:missingIdCount].succ
                            timeID = 'timePeriod' + @responseObj[:missingIdCount]
                        end

                        @xml.tag!('gml:TimePeriod', {'gml:id' => timeID}) do

                            # time period - description
                            s = hTempP[:description]
                            if !s.nil?
                                @xml.tag!('gml:description', s)
                            elsif @responseObj[:writerShowTags]
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

            end
        end
    end
end
