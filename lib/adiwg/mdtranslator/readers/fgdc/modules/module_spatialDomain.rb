# Reader - fgdc to internal data structure
# unpack fgdc spatial domain

# History:
#  Stan Smith 2017-11-25 fix: allows multiple bounding polygons
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
                  hIntExtent = intMetadataClass.newExtent
                  hIntGeoExtent = intMetadataClass.newGeographicExtent
                  hIntExtent[:geographicExtents] << hIntGeoExtent
                  hIntExtent[:description] = 'FGDC spatial domain'

                  # spatial domain bio (descgeog) - geographic description (required)
                  description = xDomain.xpath('./descgeog').text
                  unless description.empty?
                     hIntGeoExtent[:description] = description
                  end
                  if description.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC BIO geographic description is missing'
                  end

                  # spatial domain 1.5.1 (bounding) - bounding box (required)
                  xBbox = xDomain.xpath('./bounding')
                  unless xBbox.empty?
                     hBbox = intMetadataClass.newBoundingBox

                     # bounding box 1.5.1.1 (westbc) - west coordinate (required)
                     hBbox[:westLongitude] = xBbox.xpath('./westbc').text.to_f
                     if hBbox[:westLongitude].nil?
                        hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC bounding box west boundary is missing'
                     end

                     # bounding box 1.5.1.2 (eastbc) - east coordinate (required)
                     hBbox[:eastLongitude] = xBbox.xpath('./eastbc').text.to_f
                     if hBbox[:eastLongitude].nil?
                        hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC bounding box east boundary is missing'
                     end

                     # bounding box 1.5.1.3 (northbc) - north coordinate (required)
                     hBbox[:northLatitude] = xBbox.xpath('./northbc').text.to_f
                     if hBbox[:northLatitude].nil?
                        hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC bounding box north boundary is missing'
                     end

                     # bounding box 1.5.1.4 (southbc) - south coordinate (required)
                     hBbox[:southLatitude] = xBbox.xpath('./southbc').text.to_f
                     if hBbox[:southLatitude].nil?
                        hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC bounding box south boundary is missing'
                     end

                     # bounding box bio (boundalt) - altitude
                     xAltitude = xBbox.xpath('./boundalt')
                     unless xAltitude.empty?

                        # bounding box bio (altmin) - minimum altitude (required)
                        hBbox[:minimumAltitude] = xAltitude.xpath('./altmin').text.to_f
                        if hBbox[:minimumAltitude].nil?
                           hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC BIO bounding box minimum altitude is missing'
                        end

                        # bounding box bio (altmax) - maximum altitude (required)
                        hBbox[:maximumAltitude] = xAltitude.xpath('./altmax').text.to_f
                        if hBbox[:maximumAltitude].nil?
                           hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC BIO bounding box maximum altitude is missing'
                        end

                        # bounding box bio (altunit) - altitude unit of measure
                        hBbox[:unitsOfAltitude] = xAltitude.xpath('./altunit').text

                     end

                     hIntGeoExtent[:boundingBox] = hBbox
                  end
                  if xBbox.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC bounding box is missing'
                  end

                  # spatial domain 1.5.2 (dsgpoly) - data set geographic polygon []
                  axPoly = xDomain.xpath('//dsgpoly')
                  unless axPoly.empty?

                     # start new feature collection
                     hIntCollect = intMetadataClass.newFeatureCollection
                     hIntCollect[:type] = 'FeatureCollection'
                     hCollection = {
                        'type' => 'FeatureCollection',
                        'features' => []
                     }

                     axPoly.each do |xPoly|

                        # place the polygon in a feature
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
                           unless axXring.empty?
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
                           hCollection['features'] << hFeature

                           # make internal geometry object from polygon
                           hIntGeo = intMetadataClass.newGeometryObject
                           hIntGeo[:type] = 'Polygon'
                           hIntGeo[:coordinates] = polygon
                           hIntGeo[:nativeGeoJson] = hGeometry

                           # make internal geometry feature from geometry object
                           hIntFeature = intMetadataClass.newGeometryFeature
                           hIntFeature[:type] = 'Feature'
                           hIntFeature[:geometryObject] = hIntGeo
                           hIntFeature[:nativeGeoJson] = hFeature

                           # add properties to geometry feature
                           hIntProps = intMetadataClass.newGeometryProperties
                           hIntProps[:description] = 'FGDC bounding polygon'
                           hIntFeature[:properties] = hIntProps

                           # place feature into collection
                           # the collection nativeGeoJson is rewritten each pass
                           hIntCollect[:features] << hIntFeature
                           hIntCollect[:nativeGeoJson] = hCollection

                        end
                     end

                     # place collection into geographic extent
                     hIntGeoExtent[:geographicElements] << hIntCollect
                     hIntGeoExtent[:nativeGeoJson] << hIntCollect[:nativeGeoJson]

                  end

                  return hIntExtent

               end # unpack
            end # SpatialDomain

         end
      end
   end
end
