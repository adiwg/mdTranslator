# sbJson 1.0 writer geographic extent

# History:
#  Stan Smith 2017-06-06 original script

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            module GeographicExtent

               def self.new_collection
                  {
                     'type' => 'FeatureCollection',
                     'features' => []
                  }
               end

               def self.new_feature
                  {
                     'type' => 'Feature',
                     'geometry' => {}
                  }
               end

               def self.build(aExtents)

                  aFeatureCollection = []

                  # gather geographicExtents geoJson blocks
                  aExtents.each do |hExtent|
                     hExtent[:geographicExtents].each do |hGeoExtent|

                        collection = new_collection()
                        hGeoExtent[:nativeGeoJson].each do |hGeoObj|

                           case hGeoObj['type']
                              when 'Point', 'LineString', 'Polygon', 'MultiPoint', 'MultiLineString', 'MultiPolygon'
                                 feature = new_feature()
                                 feature['geometry'] = hGeoObj
                                 collection['features'] << feature

                              when 'GeometryCollection'
                                 geoCollection = new_collection()
                                 hGeoObj['geometries'].each do |hGeometry|
                                    feature = new_feature()
                                    feature['geometry'] = hGeometry
                                    geoCollection['features'] << feature
                                 end
                                 aFeatureCollection << geoCollection

                              when 'Feature'
                                 collection['features'] << hGeoObj

                              when 'FeatureCollection'
                                 aFeatureCollection << hGeoObj
                           end

                        end

                        unless collection['features'].empty?
                           aFeatureCollection << collection
                        end

                     end
                  end

                  aFeatureCollection

               end

            end

         end
      end
   end
end
