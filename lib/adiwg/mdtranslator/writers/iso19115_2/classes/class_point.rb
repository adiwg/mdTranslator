# ISO <<Class>> Point
# writer output in XML

# History:
# 	Stan Smith 2013-11-01 original script
#   Stan Smith 2014-05-30 modified for version 0.5.0
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS

require $ReaderNS.readerModule('module_coordinates')

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class Point

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hGeoElement)

                        # gml:Point attributes
                        attributes = {}

                        # gml:Point attributes - gml:id - required
                        pointID = hGeoElement[:elementId]
                        if pointID.nil?
                            @responseObj[:missingIdCount] = @responseObj[:missingIdCount].succ
                            pointID = 'point' + @responseObj[:missingIdCount]
                        end
                        attributes['gml:id'] = pointID

                        # gml:Point attributes - srsDimension
                        s = hGeoElement[:elementGeometry][:dimension]
                        if !s.nil?
                            attributes[:srsDimension] = s
                        end

                        # gml:Point attributes - srsName
                        s = hGeoElement[:elementSrs][:srsName]
                        if !s.nil?
                            attributes[:srsName] = s
                        end

                        @xml.tag!('gml:Point', attributes) do

                            # point - description
                            s = hGeoElement[:elementDescription]
                            if !s.nil?
                                @xml.tag!('gml:description', s)
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gml:description')
                            end

                            # point - name
                            s = hGeoElement[:elementName]
                            if !s.nil?
                                @xml.tag!('gml:name', s)
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gml:name')
                            end

                            # point - coordinates - required
                            # gml does not support nilReason for coordinates
                            # convert coordinate string from geoJSON to gml
                            s = hGeoElement[:elementGeometry][:geometry]
                            if !s.nil?
                                s = $ReaderNS::Coordinates.unpack(s, @responseObj)
                                @xml.tag!('gml:coordinates', s)
                            else
                                @xml.tag!('gml:coordinates')
                            end
                        end

                    end

                end

            end
        end
    end
end
