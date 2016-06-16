require 'jbuilder'
require_relative 'mdJson_base'
require_relative 'mdJson_resourceIdentifier'
require_relative 'mdJson_temporalElement'
require_relative 'mdJson_verticalElement'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module GeographicElement
          extend MdJson::Base

          def self.build(intObj)
            geo = AdiwgGeoFormat.internal_to_geoJson(intObj, false)

            case intObj[:elementType]
            when 'GeometryCollection'
              geo[:type] = intObj[:elementType]

              geo[:geometries] = []
              intObj[:elementGeometry][:geometry].each do |geom|
                geo[:geometries] << AdiwgGeoFormat.internal_to_geoJson(geom, false)
              end

            when 'FeatureCollection'
              geo[:type] = intObj[:elementType]
              fc = build_feature(geo, intObj)
              fc[:features] = []
              intObj[:elementGeometry][:geometry].each do |fea|
                feaGeo = AdiwgGeoFormat.internal_to_geoJson(fea, false)
                fc[:features] << build_feature(feaGeo, fea)
              end
              geo = fc

            when 'BBOX'
              geo[:type] = 'Feature'

            when 'Feature'
              geo = build_feature(geo, intObj)
            end

            geo[:bbox] = build_bbox(intObj[:bbox]) if intObj.include?(:bbox)
            geo
          end

          def self.build_feature(geom, obj)
            j = Jbuilder.new do |json|
              json.type obj[:elementType]
              json.id obj[:elementId]
              json.geometry geom unless geom[:type] == 'FeatureCollection'
              json.crs obj[:elementSrs].empty? ? geom[:crs] : nil
              json.properties do
                json.includesData obj[:elementIncludeData]
                json.temporalElement TemporalElement.build(obj[:temporalElements])
                json.verticalElement json_map(obj[:verticalElements], VerticalElement)
                json.description obj[:elementDescription]
                json.featureName obj[:elementName]
                json.featureScope obj[:elementScope]
                json.featureAcquisitionMethod obj[:elementAcquisition]
                json.identifier json_map(obj[:elementIdentifiers], ResourceIdentifier)
              end
            end

            j.attributes!
          end

          def self.build_bbox(box)
            coor = box[:geometry]
            [
              [coor[:westLong], coor[:eastLong]].min,
              [coor[:northLat], coor[:southLat]].min,
              [coor[:westLong], coor[:eastLong]].max,
              [coor[:northLat], coor[:southLat]].max
            ]
          end
        end
      end
    end
  end
end
