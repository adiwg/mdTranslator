# ISO <<Class>> Polygon
# writer output in XML

# History:
# 	Stan Smith 2013-11-18 original script.
#   Stan Smith 2014-05-30 modified for version 0.5.0
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)

require $ReaderNS.readerModule('module_coordinates')

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class Polygon

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hGeoElement)

                        # gml:Polygon attributes
                        attributes = {}

                        # gml:Polygon attributes - gml:id - required
                        lineID = hGeoElement[:elementId]
                        if lineID.nil?
                            @responseObj[:missingIdCount] = @responseObj[:missingIdCount].succ
                            lineID = 'polygon' + @responseObj[:missingIdCount]
                        end
                        attributes['gml:id'] = lineID

                        # gml:Polygon attributes - srsDimension
                        s = hGeoElement[:elementGeometry][:dimension]
                        if !s.nil?
                            attributes[:srsDimension] = s
                        end

                        # gml:Polygon attributes - srsName
                        s = hGeoElement[:elementSrs][:srsName]
                        if !s.nil?
                            attributes[:srsName] = s
                        end

                        @xml.tag!('gml:Polygon', attributes) do

                            # polygon - description
                            s = hGeoElement[:elementDescription]
                            if !s.nil?
                                @xml.tag!('gml:description', s)
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gml:description')
                            end

                            # polygon - name
                            s = hGeoElement[:elementName]
                            if !s.nil?
                                @xml.tag!('gml:name', s)
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gml:name')
                            end


                            # polygon - exterior ring
                            # convert coordinate string from geoJSON to gml
                            aCoords = hGeoElement[:elementGeometry][:geometry][:exteriorRing]
                            if !aCoords.empty?
                                s = $ReaderNS::Coordinates.unpack(aCoords, @responseObj)
                                @xml.tag!('gml:exterior') do
                                    @xml.tag!('gml:LinearRing') do
                                        @xml.tag!('gml:coordinates', s)
                                    end
                                end
                            else
                                @xml.tag!('gml:exterior')
                            end

                            # polygon - interior ring
                            # convert coordinate string from geoJSON to gml
                            # XSDs do not all gml:interior to be displayed empty
                            aRings = hGeoElement[:elementGeometry][:geometry][:exclusionRings]
                            unless aRings.empty?
                                aRings.each do |aRing|
                                    s = $ReaderNS::Coordinates.unpack(aRing, @responseObj)
                                    @xml.tag!('gml:interior') do
                                        @xml.tag!('gml:LinearRing') do
                                            @xml.tag!('gml:coordinates', s)
                                        end
                                    end
                                end
                            end

                        end

                    end

                end

            end
        end
    end
end
