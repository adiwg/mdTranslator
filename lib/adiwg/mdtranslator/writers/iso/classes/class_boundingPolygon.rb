# ISO <<Class>> EX_BoundingPolygon
# writer output in XML

# History:
# 	Stan Smith 2013-11-01 original script
# 	Stan Smith 2013-11-12 added multi geometry
# 	Stan Smith 2013-11-13 added line string
# 	Stan Smith 2013-11-18 added polygon
#   Stan Smith 2014-05-30 modified for version 0.5.0
#   Stan Smith 2014-05-30 added multi-point, multi-linestring, multi-polygon support
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)

require 'class_point'
require 'class_lineString'
require 'class_multiGeometry'
require 'class_polygon'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class EX_BoundingPolygon

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hGeoElement)

                        # classes used
                        pointClass = $IsoNS::Point.new(@xml, @responseObj)
                        lineClass = $IsoNS::LineString.new(@xml, @responseObj)
                        multiGeoClass = $IsoNS::MultiGeometry.new(@xml, @responseObj)
                        polygonClass = $IsoNS::Polygon.new(@xml, @responseObj)

                        hGeometry = hGeoElement[:elementGeometry]
                        polyType = hGeometry[:geoType]

                        @xml.tag!('gmd:EX_BoundingPolygon') do

                            # bounding polygon - extent type - required
                            extentType = hGeoElement[:elementIncludeData]
                            if extentType.nil?
                                @xml.tag!('gmd:extentTypeCode', {'gco:nilReason' => 'missing'})
                            elsif extentType == true || extentType == false
                                @xml.tag!('gmd:extentTypeCode') do
                                    @xml.tag!('gco:Boolean', extentType)
                                end
                            else
                                @xml.tag!('gmd:extentTypeCode', {'gco:nilReason' => extentType})
                            end

                            # bounding polygon - polygon - required
                            if hGeometry[:geometry].empty?
                                @xml.tag!('gmd:polygon', {'gco:nilReason' => 'missing'})
                            else
                                @xml.tag!('gmd:polygon') do
                                    case polyType
                                        when 'Point'
                                            pointClass.writeXML(hGeoElement)
                                        when 'LineString'
                                            lineClass.writeXML(hGeoElement)
                                        when 'Polygon'
                                            polygonClass.writeXML(hGeoElement)
                                        when 'MultiPoint', 'MultiLineString', 'MultiPolygon', 'MultiGeometry'
                                            multiGeoClass.writeXML(hGeoElement)
                                        when 'MultiGeometry'
                                            multiGeoClass.writeXML(hGeoElement)
                                        else
                                            # log - the bounding polygon type is not supported
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
