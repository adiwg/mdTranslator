require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_geoCoordSystem')
require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_geoProperties')
require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_boundingBox')
#require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_point')
#require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_lineString')
#require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_polygon')

module ADIWG
    module Mdtranslator
        module Readers
            module SbJson

                module GeographicElement

                    def self.unpack(aGeoElements, responseObj)

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
                                GeoCoordSystem.unpack(hGeoCrs, hGeoElement, responseObj)
                            end

                            # set geographic element properties
                            if hGeoJsonElement.has_key?('properties')
                                hGeoProps = hGeoJsonElement['properties']
                                GeoProperties.unpack(hGeoProps, hGeoElement, responseObj)
                            end

                            # process geographic element bounding box
                            # the bounding box must be represented as a separate geographic element for ISO
                            # need to make a deep copy of current state of geographic element for bounding box
                            if hGeoJsonElement.has_key?('bbox')
                                if hGeoJsonElement['bbox'].length == 4
                                    aBBox = hGeoJsonElement['bbox']

                                    boxElement = Marshal.load(Marshal.dump(hGeoElement))
                                    boxElement[:elementGeometry] = BoundingBox.unpack(aBBox, responseObj)

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
                                                                hGeoElement[:elementGeometry] = ADIWG::Mdtranslator::Point.unpack(aCoordinates, geometryType, responseObj)
                                                            when 'LineString', 'MultiLineString'
                                                                hGeoElement[:elementGeometry] = ADIWG::Mdtranslator::LineString.unpack(aCoordinates, geometryType, responseObj)
                                                            when 'Polygon', 'MultiPolygon'
                                                                hGeoElement[:elementGeometry] = Polygon.unpack(aCoordinates, geometryType, responseObj)
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
                                            intGeometry[:geometry] = GeographicElement.unpack(aFeatures, responseObj)
                                            hGeoElement[:elementGeometry] = intGeometry
                                            aIntGeoEle << hGeoElement
                                        end
                                    end

                                # GeoJSON Geometries
                                when 'Point', 'MultiPoint'
                                    aCoordinates = hGeoJsonElement['coordinates']
                                    hGeoElement[:elementGeometry] = ADIWG::Mdtranslator::Point.unpack(aCoordinates, elementType, responseObj)
                                    aIntGeoEle << hGeoElement

                                when 'LineString', 'MultiLineString'
                                    aCoordinates = hGeoJsonElement['coordinates']
                                    hGeoElement[:elementGeometry] = ADIWG::Mdtranslator::LineString.unpack(aCoordinates, elementType, responseObj)
                                    aIntGeoEle << hGeoElement

                                when 'Polygon', 'MultiPolygon'
                                    aCoordinates = hGeoJsonElement['coordinates']
                                    hGeoElement[:elementGeometry] = Polygon.unpack(aCoordinates, elementType, responseObj)
                                    aIntGeoEle << hGeoElement

                                # GeoJSON Geometry Collection
                                when 'GeometryCollection'
                                    if hGeoJsonElement.has_key?('geometries')
                                        aGeometries = hGeoJsonElement['geometries']
                                        unless aGeometries.empty?
                                            intGeometry = intMetadataClass.newGeometry
                                            intGeometry[:geoType] = 'MultiGeometry'
                                            intGeometry[:geometry] = GeographicElement.unpack(aGeometries, responseObj)
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
