# unpack geographic element
# Reader - ADIwg JSON V1 to internal data structure
# determine element type

# History:
# 	Stan Smith 2013-11-04 original script
# 	Stan Smith 2013-11-13 added line string
# 	Stan Smith 2013-11-13 added multi line string
# 	Stan Smith 2013-11-18 added polygon
#   Stan Smith 2014-04-30 complete redesign for json schema 0.3.0
#   Stan Smith 2014-05-22 added multi polygon
#   Stan Smith 2014-05-23 cleaned up hash copy problem by using Marshal
#   Stan Smith 2014-05-23 added direct geometry support for Point, Line, Polygon
#   Stan Smith 2014-05-23 added direct geometry support for MultiPoint, MultiLine, MultiPolygon
#   Stan Smith 2014-05-23 added direct support for geometryCollection
#   Stan Smith 2014-07-07 resolve require statements using Mdtranslator.reader_module
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers

require $ReaderNS.readerModule('module_geoCoordSystem')
require $ReaderNS.readerModule('module_geoProperties')
require $ReaderNS.readerModule('module_boundingBox')
require $ReaderNS.readerModule('module_point')
require $ReaderNS.readerModule('module_lineString')
require $ReaderNS.readerModule('module_polygon')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module GeographicElement

                    def self.unpack(aGeoElements)

                        # only one geometry is allowed per geographic element.
                        # ... in GeoJSON each geometry is allowed a bounding box;
                        # ... This code splits bounding boxes to separate elements

                        # instance classes needed in script
                        aIntGeoEle = Array.new

                        aGeoElements.each do |hGeoJsonElement|

                            # instance classes needed in script
                            intMetadataClass = InternalMetadata.new
                            hGeoElement = intMetadataClass.newGeoElement

                            # find geographic element type
                            if hGeoJsonElement.has_key?('type')
                                elementType = hGeoJsonElement['type']
                            else
                                # invalid geographic element
                                return nil
                            end

                            # set geographic element id
                            if hGeoJsonElement.has_key?('id')
                                s = hGeoJsonElement['id']
                                if s != ''
                                    hGeoElement[:elementId] = s
                                end
                            end

                            # set geographic element coordinate reference system - CRS
                            if hGeoJsonElement.has_key?('crs')
                                hGeoCrs = hGeoJsonElement['crs']
                                $ReaderNS::GeoCoordSystem.unpack(hGeoCrs, hGeoElement)
                            end

                            # set geographic element properties
                            if hGeoJsonElement.has_key?('properties')
                                hGeoProps = hGeoJsonElement['properties']
                                $ReaderNS::GeoProperties.unpack(hGeoProps, hGeoElement)
                            end

                            # process geographic element bounding box
                            # the bounding box must be represented as a separate geographic element for ISO
                            # need to make a deep copy of current state of geographic element for bounding box
                            if hGeoJsonElement.has_key?('bbox')
                                if hGeoJsonElement['bbox'].length == 4
                                    aBBox = hGeoJsonElement['bbox']

                                    boxElement = Marshal.load(Marshal.dump(hGeoElement))
                                    boxElement[:elementGeometry] = $ReaderNS::BoundingBox.unpack(aBBox)

                                    aIntGeoEle << boxElement
                                end
                            end

                            # unpack geographic element
                            case elementType

                                # GeoJSON Features
                                when 'Feature'
                                    if hGeoJsonElement.has_key?('geometry')
                                        hGeometry = hGeoJsonElement['geometry']

                                        # geoJSON requires geometry to be 'null' when geometry is bounding box only
                                        # JSON null converts in parsing to ruby nil
                                        unless hGeometry.nil?
                                            unless hGeometry.empty?
                                                if hGeometry.has_key?('type')
                                                    geometryType = hGeometry['type']
                                                    aCoordinates = hGeometry['coordinates']
                                                    unless aCoordinates.empty?
                                                        case geometryType
                                                            when 'Point', 'MultiPoint'
                                                                hGeoElement[:elementGeometry] = $ReaderNS::Point.unpack(aCoordinates, geometryType)
                                                            when 'LineString', 'MultiLineString'
                                                                hGeoElement[:elementGeometry] = $ReaderNS::LineString.unpack(aCoordinates, geometryType)
                                                            when 'Polygon', 'MultiPolygon'
                                                                hGeoElement[:elementGeometry] = $ReaderNS::Polygon.unpack(aCoordinates, geometryType)
                                                            else
                                                                # log - the GeoJSON geometry type is not supported
                                                        end
                                                        aIntGeoEle << hGeoElement
                                                    end
                                                end
                                            end
                                        end

                                    end

                                # GeoJSON Feature Collection
                                when 'FeatureCollection'
                                    if hGeoJsonElement.has_key?('features')
                                        aFeatures = hGeoJsonElement['features']
                                        unless aFeatures.empty?
                                            intGeometry = intMetadataClass.newGeometry
                                            intGeometry[:geoType] = 'MultiGeometry'
                                            intGeometry[:geometry] = $ReaderNS::GeographicElement.unpack(aFeatures)
                                            hGeoElement[:elementGeometry] = intGeometry
                                            aIntGeoEle << hGeoElement
                                        end
                                    end

                                # GeoJSON Geometries
                                when 'Point', 'MultiPoint'
                                    aCoordinates = hGeoJsonElement['coordinates']
                                    hGeoElement[:elementGeometry] = $ReaderNS::Point.unpack(aCoordinates, elementType)
                                    aIntGeoEle << hGeoElement

                                when 'LineString', 'MultiLineString'
                                    aCoordinates = hGeoJsonElement['coordinates']
                                    hGeoElement[:elementGeometry] = $ReaderNS::LineString.unpack(aCoordinates, elementType)
                                    aIntGeoEle << hGeoElement

                                when 'Polygon', 'MultiPolygon'
                                    aCoordinates = hGeoJsonElement['coordinates']
                                    hGeoElement[:elementGeometry] = $ReaderNS::Polygon.unpack(aCoordinates, elementType)
                                    aIntGeoEle << hGeoElement

                                # GeoJSON Geometry Collection
                                when 'GeometryCollection'
                                    if hGeoJsonElement.has_key?('geometries')
                                        aGeometries = hGeoJsonElement['geometries']
                                        unless aGeometries.empty?
                                            intGeometry = intMetadataClass.newGeometry
                                            intGeometry[:geoType] = 'MultiGeometry'
                                            intGeometry[:geometry] = $ReaderNS::GeographicElement.unpack(aGeometries)
                                            hGeoElement[:elementGeometry] = intGeometry
                                            aIntGeoEle << hGeoElement
                                        end
                                    end

                            end

                        end

                        return aIntGeoEle

                    end

                end

            end
        end
    end
end
