# ISO <<Class>> CI_Date
# 19115-2 writer output in XML

# History:
#   Stan Smith 2016-11-29 refactored for mdTranslator/mdJson 2.0
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#   Stan Smith 2015-06-11 change all codelists to use 'class_codelist' method
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
# 	Stan Smith 2013-11-21 support for date or datetime
# 	Stan Smith 2013-08-26 original script

require_relative 'class_codelist'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class CI_Date

                    def initialize(xml, hResponseObj)
                        @xml = xml
                        @hResponseObj = hResponseObj
                    end

                    def writeXML(hDate)

                        # classes used
                        codelistClass =  MD_Codelist.new(@xml, @hResponseObj)

                        date = hDate[:date]
                        dateRes = hDate[:dateResolution]
                        dateType = hDate[:dateType]

                        @xml.tag!('gmd:CI_Date') do

                            # date - date (required)
                            unless date.nil?
                                @xml.tag!('gmd:date') do
                                    case dateRes
                                        when 'Y', 'YM', 'YMD'
                                            dateStr = AdiwgDateTimeFun.stringDateFromDateTime(date, dateRes)
                                            @xml.tag!('gco:Date', dateStr)
                                        when 'YMDh', 'YMDhm', 'YMDhms'
                                            dateStr = AdiwgDateTimeFun.stringDateTimeFromDateTime(date, 'YMDhms')
                                            @xml.tag!('gco:DateTime', dateStr)
                                        when 'YMDhZ', 'YMDhmZ', 'YMDhmsZ'
                                            dateStr = AdiwgDateTimeFun.stringDateTimeFromDateTime(date, 'YMDhmsZ')
                                            @xml.tag!('gco:DateTime', dateStr)
                                        else
                                            dateStr = AdiwgDateTimeFun.stringDateTimeFromDateTime(date, dateRes)
                                            @xml.tag!('gco:DateTime', dateStr)
                                    end
                                end
                            end
                            if date.nil?
                                @xml.tag!('gmd:date', {'gco:nilReason' => 'missing'})
                            end

                            # date - date type (required)
                            unless dateType.nil?
                                @xml.tag!('gmd:dateType') do
                                    codelistClass.writeXML('gmd', 'iso_dateType',dateType)
                                end
                            end
                            if dateType.nil?
                                @xml.tag!('gmd:dateType', {'gco:nilReason' => 'missing'})
                            end

                        end # CI_Date tag
                    end # write XML
                end # CI_Date class

            end
        end
    end
end
