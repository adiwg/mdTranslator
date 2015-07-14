# ISO <<Class>> GenericMetaData
# writer output in XML
# generic metadata only supports ...
# time instant
# time period

# History:
# 	Stan Smith 2013-11-04 original script
#   Stan Smith 2014-07-08 class no longer used
#   ... use replaced by creating new geographic extents for geometries
#   ... containing supplemental identifier, temporal, and vertical information
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS

require 'class_timeInstant'
require 'class_timePeriod'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class GenericMetaData

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(aTempExt)

                        # classes used
                        timeIClass = $IsoNS::TimeInstant.new(@xml)
                        timePClass = $IsoNS::TimePeriod.new(@xml)

                        @xml.tag!('gml:GenericMetaData') do

                            aTempExt.each do |hTempExt|

                                # metadata - data
                                hTimeD = hTempExt[:date]
                                unless hTimeD.empty?
                                    date = hTimeD[:dateTime]
                                    dateResolution = hTimeD[:dateResolution]
                                    s = AdiwgDateTimeFun.stringDateFromDateTime(date, dateResolution)
                                    if s != 'ERROR'
                                        @xml.tag!('gco:Date', s)
                                    end
                                end

                                # metadata - time instant
                                hTimeI = hTempExt[:timeInstant]
                                unless hTimeI.empty?
                                    timeIClass.writeXML(hTimeI)
                                end

                                # metadata - time period
                                hTimeP = hTempExt[:timePeriod]
                                unless hTimeP.empty?
                                    timePClass.writeXML(hTimeP)
                                end

                            end

                        end

                    end

                end

            end
        end
    end
end
