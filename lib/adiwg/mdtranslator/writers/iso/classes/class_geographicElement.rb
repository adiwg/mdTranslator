# ISO <<Class>> geographicElement {abstract}
# writer output in XML

# History:
# 	Stan Smith 2014-05-29 original script
#   Stan Smith 2014-05-30 added multi-point, multi-linestring, multi-polygon support
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)

require 'class_geographicBoundingBox'
require 'class_boundingPolygon'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class GeographicElement

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hGeoElement)

                        # classes used
                        geoBBoxClass = $IsoNS::EX_GeographicBoundingBox.new(@xml, @responseObj)
                        geoBPolyClass = $IsoNS::EX_BoundingPolygon.new(@xml, @responseObj)

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
