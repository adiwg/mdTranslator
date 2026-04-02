# unpack spatial
# Reader - DCAT-US to internal data structure
# Maps 'spatial' field to resourceInfo.extents[].geographicExtents[].boundingBox
#
# Supported input formats (DCAT-US v1.1 spec):
#   (1) Bounding box string: "minLong,minLat,maxLong,maxLat" (west,south,east,north)
#   (2) Point string: "longitude,latitude"
#   (3) GeoJSON object: {"type":"Polygon","coordinates":[[...]]}
#   (4) Place name string: stored as geographicExtent description

require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Dcat_us

            module Spatial

               def self.unpack(hDataset, hResourceInfo, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  return hResourceInfo unless hDataset.has_key?('spatial')

                  spatial = hDataset['spatial']
                  return hResourceInfo if spatial.nil?

                  # Handle GeoJSON object
                  if spatial.is_a?(Hash)
                     unpack_geojson(spatial, hResourceInfo, intMetadataClass)
                     return hResourceInfo
                  end

                  spatial_str = spatial.to_s.strip
                  return hResourceInfo if spatial_str == ''

                  # Try to parse as numeric coordinate string
                  coords = spatial_str.split(',').map(&:strip)

                  if coords.length == 4 && coords.all? { |c| c.match?(/\A[-+]?\d+(\.\d+)?\z/) }
                     # Bounding box: minLong, minLat, maxLong, maxLat (per DCAT-US spec)
                     west  = coords[0].to_f
                     south = coords[1].to_f
                     east  = coords[2].to_f
                     north = coords[3].to_f

                     hExtent = intMetadataClass.newExtent
                     hGeoExtent = intMetadataClass.newGeographicExtent
                     hBbox = intMetadataClass.newBoundingBox

                     hBbox[:westLongitude] = west
                     hBbox[:southLatitude] = south
                     hBbox[:eastLongitude] = east
                     hBbox[:northLatitude] = north

                     hGeoExtent[:boundingBox] = hBbox
                     hExtent[:geographicExtents] << hGeoExtent
                     hResourceInfo[:extents] << hExtent

                  elsif coords.length == 2 && coords.all? { |c| c.match?(/\A[-+]?\d+(\.\d+)?\z/) }
                     # Point: longitude, latitude
                     hExtent = intMetadataClass.newExtent
                     hGeoExtent = intMetadataClass.newGeographicExtent
                     hGeoExtent[:description] = spatial_str
                     hExtent[:geographicExtents] << hGeoExtent
                     hResourceInfo[:extents] << hExtent

                  else
                     # Named place or unrecognised format — store as description
                     hExtent = intMetadataClass.newExtent
                     hGeoExtent = intMetadataClass.newGeographicExtent
                     hGeoExtent[:description] = spatial_str
                     hExtent[:geographicExtents] << hGeoExtent
                     hResourceInfo[:extents] << hExtent
                  end

                  return hResourceInfo

               end

               def self.unpack_geojson(spatial_obj, hResourceInfo, intMetadataClass)

                  geo_type = spatial_obj['type']
                  coordinates = spatial_obj['coordinates']
                  return unless geo_type && coordinates

                  hExtent = intMetadataClass.newExtent
                  hGeoExtent = intMetadataClass.newGeographicExtent

                  if geo_type == 'Polygon'
                     # Compute bounding box from polygon coordinates
                     outer_ring = coordinates[0]
                     return unless outer_ring && !outer_ring.empty?

                     lons = outer_ring.map { |pt| pt[0] }
                     lats = outer_ring.map { |pt| pt[1] }

                     hBbox = intMetadataClass.newBoundingBox
                     hBbox[:westLongitude] = lons.min
                     hBbox[:eastLongitude] = lons.max
                     hBbox[:southLatitude] = lats.min
                     hBbox[:northLatitude] = lats.max
                     hGeoExtent[:boundingBox] = hBbox

                  elsif geo_type == 'Point'
                     lon = coordinates[0]
                     lat = coordinates[1]
                     hGeoExtent[:description] = "#{lon},#{lat}"
                  end

                  hExtent[:geographicExtents] << hGeoExtent
                  hResourceInfo[:extents] << hExtent

               end

            end

         end
      end
   end
end
