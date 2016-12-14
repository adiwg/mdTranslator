# ISO <<Class>> EX_GeographicBoundingBox
# 19115-2 writer output in XML

# History:
#   Stan Smith 2016-12-02 refactored for mdTranslator/mdJson 2.0
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2014-05-30 hBBox attributes changed for version 0.5.0
# 	Stan Smith 2013-11-01 original script

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class EX_GeographicBoundingBox

                    def initialize(xml, hResponseObj)
                        @xml = xml
                        @hResponseObj = hResponseObj
                    end

                    def writeXML(hBBox)

                            # bounding box - west longitude (required)
                            s = hBBox[:westLongitude]
                            if s.nil?
                                @xml.tag!('gmd:westBoundLongitude', {'gco:nilReason' => 'missing'})
                            else
                                @xml.tag!('gmd:westBoundLongitude') do
                                    @xml.tag!('gco:Decimal', s)
                                end
                            end

                            # bounding box - east longitude (required)
                            s = hBBox[:eastLongitude]
                            if s.nil?
                                @xml.tag!('gmd:eastBoundLongitude', {'gco:nilReason' => 'missing'})
                            else
                                @xml.tag!('gmd:eastBoundLongitude') do
                                    @xml.tag!('gco:Decimal', s)
                                end
                            end

                            # bounding box - south latitude (required)
                            s = hBBox[:southLatitude]
                            if s.nil?
                                @xml.tag!('gmd:southBoundLatitude', {'gco:nilReason' => 'missing'})
                            else
                                @xml.tag!('gmd:southBoundLatitude') do
                                    @xml.tag!('gco:Decimal', s)
                                end
                            end

                            # bounding box - north latitude (required)
                            s = hBBox[:northLatitude]
                            if s.nil?
                                @xml.tag!('gmd:northBoundLatitude', {'gco:nilReason' => 'missing'})
                            else
                                @xml.tag!('gmd:northBoundLatitude') do
                                    @xml.tag!('gco:Decimal', s)
                                end
                            end

                    end # writeXML
                end # EX_GeographicBoundingBox class

            end
        end
    end
end
