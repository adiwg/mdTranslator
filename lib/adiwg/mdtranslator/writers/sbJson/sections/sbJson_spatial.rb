require 'jbuilder'
require 'rgeo'

module ADIWG
  module Mdtranslator
    module Writers
      module SbJson
        module Spatial
          def self.build(intObj)
            geo = []
            intObj.each do |ext|
              ext[:extGeoElements].each do |ge|
                case ge[:elementType]
                when 'GeometryCollection'
                  ge[:elementGeometry][:geometry].each do |geom|
                    geo << AdiwgGeoFormat.internal_to_wkt(geom[:elementGeometry])
                  end

                when 'FeatureCollection'
                  ge[:elementGeometry][:geometry].each do |fea|
                    geo << AdiwgGeoFormat.internal_to_wkt(fea[:elementGeometry])
                  end
                else
                  geo << AdiwgGeoFormat.internal_to_wkt(ge[:elementGeometry])
                end
              end
            end
            # puts geo
            # calculate the bounds
            reader = RGeo::WKRep::WKTParser.new(nil, support_wkt12: true)
            fact = RGeo::Geographic.spherical_factory
            bbox = RGeo::Cartesian::BoundingBox.new(fact, ignore_z: true)
            geo.each { |geom| bbox.add(reader.parse(geom)) }

            {
              boundingBox: {
                minX: bbox.min_x,
                maxX: bbox.max_x,
                minY: bbox.min_y,
                maxY: bbox.max_y
              }
            }

          end
        end
      end
    end
  end
end
