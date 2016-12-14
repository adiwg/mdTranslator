# ISO <<Class>> geographicElement {abstract}
# 19115-2 writer output in XML

# History:
#   Stan Smith 2016-12-05 refactored for mdTranslator/mdJson 2.0
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#   Stan Smith 2014-05-30 added multi-point, multi-linestring, multi-polygon support
# 	Stan Smith 2014-05-29 original script

require_relative 'class_point'
require_relative 'class_lineString'
require_relative 'class_polygon'
require_relative 'class_multiPoint'
require_relative 'class_multiLine'
require_relative 'class_multiPolygon'
require_relative 'class_geometryCollection'
require_relative 'class_feature'
require_relative 'class_featureCollection'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class GeographicElement

                    def initialize(xml, hResponseObj)
                        @xml = xml
                        @hResponseObj = hResponseObj
                    end

                    def writeXML(aGeoElement)

                        # classes used
                        pointClass =  Point.new(@xml, @hResponseObj)
                        lineClass =  LineString.new(@xml, @hResponseObj)
                        polyClass =  Polygon.new(@xml, @hResponseObj)
                        multiPointClass =  MultiPoint.new(@xml, @hResponseObj)
                        multiLineClass =  MultiLineString.new(@xml, @hResponseObj)
                        multiPolyClass =  MultiPolygon.new(@xml, @hResponseObj)
                        geoCollectClass =  GeometryCollection.new(@xml, @hResponseObj)
                        featureClass =  Feature.new(@xml, @hResponseObj)
                        featureCollectClass =  FeatureCollection.new(@xml, @hResponseObj)

                        aGeoElement.each do |hElement|
                            @xml.tag!('gmd:polygon') do
                                case hElement[:type]
                                    when 'Point'
                                        pointClass.writeXML(hElement, {}, nil)
                                    when 'LineString'
                                        lineClass.writeXML(hElement, {}, nil)
                                    when 'Polygon'
                                        polyClass.writeXML(hElement, {}, nil)
                                    when 'MultiPoint'
                                        multiPointClass.writeXML(hElement, {}, nil)
                                    when 'MultiLineString'
                                        multiLineClass.writeXML(hElement, {}, nil)
                                    when 'MultiPolygon'
                                        multiPolyClass.writeXML(hElement, {}, nil)
                                    when 'GeometryCollection'
                                        geoCollectClass.writeXML(hElement, {}, nil)
                                    when 'Feature'
                                        featureClass.writeXML(hElement)
                                    when 'FeatureCollection'
                                        featureCollectClass.writeXML(hElement)
                                end
                            end
                        end

                    end # writeXML
                end # GeographicElement class

            end
        end
    end
end
