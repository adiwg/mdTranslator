# ISO <<Class>> geographicElement {abstract}
# writer output in XML

# History:
# 	Stan Smith 2014-05-29 original script
#   Stan Smith 2014-05-30 added multi-point, multi-linestring, multi-polygon support
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS

require_relative 'class_geographicBoundingBox'
require_relative 'class_boundingPolygon'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class GeographicElement

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hGeoElement)

                        # classes used
                        geoBBoxClass =  EX_GeographicBoundingBox.new(@xml, @responseObj)
                        geoBPolyClass =  EX_BoundingPolygon.new(@xml, @responseObj)

                        geoType = hGeoElement[:elementGeometry][:geoType]
                        case geoType
                            when 'BoundingBox'
                                geoBBoxClass.writeXML(hGeoElement)
                            when 'Point', 'LineString', 'Polygon', 'MultiPoint', 'MultiLineString', 'MultiPolygon'
                                geoBPolyClass.writeXML(hGeoElement)
                            when 'MultiGeometry'
                                geoBPolyClass.writeXML(hGeoElement)
                        end

                    end

                end

            end
        end
    end
end
