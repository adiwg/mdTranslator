# ISO <<Class>> TimeInstant
# writer output in XML

# History:
# 	Stan Smith 2013-11-04 original script.
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers

require 'module_dateTimeFun'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class TimeInstant

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hTempI)

                        timeID = hTempI[:timeId]
                        if timeID.nil?
                            @responseObj[:missingIdCount] = @responseObj[:missingIdCount].succ
                            timeID = 'timeInstant' + @responseObj[:missingIdCount]
                        end

                        @xml.tag!('gml:TimeInstant', {'gml:id' => timeID}) do

                            # time instant - description
                            s = hTempI[:description]
                            if !s.nil?
                                @xml.tag!('gml:description', s)
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gml:description')
                            end

                            # time instant - time position
                            hDateTime = hTempI[:timePosition]
                            timeInstant = hDateTime[:dateTime]
                            timeResolution = hDateTime[:dateResolution]
                            dateStr = AdiwgDateTimeFun.stringDateTimeFromDateTime(timeInstant, timeResolution)
                            @xml.tag!('gml:timePosition', dateStr)

                        end

                    end

                end

            end
        end
    end
end
