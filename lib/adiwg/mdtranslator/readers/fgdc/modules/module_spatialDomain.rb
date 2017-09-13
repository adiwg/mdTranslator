# Reader - fgdc to internal data structure
# unpack fgdc spatial domain

# History:
#  Stan Smith 2017-08-22 original script

require 'nokogiri'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/internal/module_coordinates'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module SpatialDomain

               def self.process_polygon(xPolygon)
                  aCoords = []

                  # polygon coordinates (grngpoin) - g ring points []
                  axPoints = xPolygon.xpath('./grngpoin')
                  unless axPoints.empty?
                     aCoords = coords_from_points(axPoints)
                  end

                  # polygon coordinates (gring) - g ring
                  xRing = xPolygon.xpath('./gring')
                  unless xRing.empty?
                     aCoords = coords_from_ring(xRing)
                  end

                  return aCoords
               end

               def self.coords_from_points(axPoints)
                  aCoords = []
                  axPoints.each do |xPoint|
                     lon = xPoint.xpath('./grnglon').text.to_f
                     lat = xPoint.xpath('./grnglat').text.to_f
                     aCoords << [lon, lat]
                  end
                  return aCoords
               end

               def self.coords_from_ring(xRing)
                  aCoords = []
                  sRing = xRing.text
                  aPoints = sRing.split(', ')
                  aPoints.each do |point|
                     aCoord = point.split(' ')
                     aCoords << [aCoord[0].to_f, aCoord[1].to_f]
                  end
                  return aCoords
               end

               def self.unpack(xDomain, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hExtent = intMetadataClass.newExtent
                  hGeoExtent = intMetadataClass.newGeographicExtent
                  hExtent[:geographicExtents] << hGeoExtent

                  # spatial domain 1.5.1 (bounding) - bounding box
                  xBbox = xDomain.xpath('./bounding')
                  unless xBbox.empty?
                     hBbox = intMetadataClass.newBoundingBox

                     # bounding box 1.5.1.1 (westbc) - west coordinate
                     hBbox[:westLongitude] = xBbox.xpath('./westbc').text.to_f

                     # bounding box 1.5.1.2 (eastbc) - east coordinate
                     hBbox[:eastLongitude] = xBbox.xpath('./eastbc').text.to_f

                     # bounding box 1.5.1.3 (northbc) - north coordinate
                     hBbox[:northLatitude] = xBbox.xpath('./northbc').text.to_f

                     # bounding box 1.5.1.4 (southbc) - south coordinate
                     hBbox[:southLatitude] = xBbox.xpath('./southbc').text.to_f

                     hGeoExtent[:boundingBox] = hBbox
                  end

                  # spatial domain 1.5.2 (dsgpoly) - data set geographic polygon
                  xPoly = xDomain.xpath('./dsgpoly')
                  unless xPoly.empty?

                     polygon = []

                     # polygon 1.5.2.1 (dsgpolyo) - polygon outer ring
                     xOring = xPoly.xpath('./dsgpolyo')
                     unless xOring.empty?

                        # outer ring 1.5.2.1.1 (grngpoin) - g ring point
                        # outer ring 1.5.2.1.2 (gring) - g ring
                        # outer ring must be counterclockwise
                        aOutCoords = process_polygon(xOring)
                        unless aOutCoords.empty?
                           if AdiwgCoordinates.is_polygon_clockwise(aOutCoords)
                              aOutCoords.reverse!
                           end
                           polygon << aOutCoords
                        end

                        # first ring must be outer
                        # only process if already have outer ring
                        # polygon 1.5.2.2 (dsgpolyx) - polygon exclusion ring []
                        axXring = xPoly.xpath('./dsgpolyx')
                        axXring.each do |xRing|

                           # exclusion ring 1.5.2.2.1 (grngpoin) - g ring point
                           # exclusion ring 1.5.2.2.2 (gring) - g ring
                           # exclusion ring must be clockwise
                           aInCoords = process_polygon(xRing)
                           unless aInCoords.empty?
                              unless AdiwgCoordinates.is_polygon_clockwise(aInCoords)
                                 aInCoords.reverse!
                              end
                              polygon << aInCoords
                           end

                        end
                     end

                     unless polygon.empty?

                        # make geoJson FeatureCollection from polygon
                        hGeometry = {
                           'type' => 'Polygon',
                           'coordinates' => polygon
                        }
                        hFeature = {
                           'type' => 'Feature',
                           'geometry' => hGeometry,
                           'properties' => {
                              'description' => 'FGDC bounding polygon'
                           }
                        }
                        hCollection = {
                           'type' => 'FeatureCollection',
                           'features' => [hFeature]
                        }
                        geoJson = hCollection

                        # make internal geometries from polygon
                        hIntGeo = intMetadataClass.newGeometryObject
                        hIntGeo[:type] = 'Polygon'
                        hIntGeo[:coordinates] = polygon
                        hIntGeo[:nativeGeoJson] = hGeometry

                        hIntProps = intMetadataClass.newGeometryProperties
                        hIntProps[:description] = 'FGDC bounding polygon'

                        hIntFeature = intMetadataClass.newGeometryFeature
                        hIntFeature[:type] = 'Feature'
                        hIntFeature[:geometryObject] = hIntGeo
                        hIntFeature[:nativeGeoJson] = hFeature
                        hIntFeature[:properties] = hIntProps

                        hIntCollect = intMetadataClass.newFeatureCollection
                        hIntCollect[:type] = 'FeatureCollection'
                        hIntCollect[:features] << hIntFeature
                        hIntCollect[:nativeGeoJson] = hCollection

                        hGeoExtent[:geographicElements] << hIntCollect
                        hGeoExtent[:nativeGeoJson] << geoJson

                        hExtent[:description] = 'FGDC spatial domain'

                     end
                  end

                  return hExtent

               end

            end

         end
      end
   end
end
