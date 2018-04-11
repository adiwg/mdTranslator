# GeoJSON Feature
# 19115-2 writer output in XML

# History:
#  Stan Smith 2018-04-09 add error and warning messaging
#  Stan Smith 2016-12-06 original script

require_relative '../iso19115_2_writer'
require_relative 'class_point'
require_relative 'class_lineString'
require_relative 'class_polygon'
require_relative 'class_multiPoint'
require_relative 'class_multiLine'
require_relative 'class_multiPolygon'
require_relative 'class_geometryCollection'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class Feature

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_2
               end

               def writeXML(hGeoObject)

                  # classes used
                  pointClass = Point.new(@xml, @hResponseObj)
                  lineClass = LineString.new(@xml, @hResponseObj)
                  polyClass = Polygon.new(@xml, @hResponseObj)
                  multiPointClass = MultiPoint.new(@xml, @hResponseObj)
                  multiLineClass = MultiLineString.new(@xml, @hResponseObj)
                  multiPolyClass = MultiPolygon.new(@xml, @hResponseObj)
                  geoCollectionClass = GeometryCollection.new(@xml, @hResponseObj)

                  # feature - geometry object (required)
                  unless hGeoObject.empty?
                     id = hGeoObject[:id]
                     hProps = hGeoObject[:properties]
                     hGeometry = hGeoObject[:geometryObject]
                     case hGeometry[:type]
                        when 'Point'
                           pointClass.writeXML(hGeometry, hProps, id)
                        when 'LineString'
                           lineClass.writeXML(hGeometry, hProps, id)
                        when 'Polygon'
                           polyClass.writeXML(hGeometry, hProps, id)
                        when 'MultiPoint'
                           multiPointClass.writeXML(hGeometry, hProps, id)
                        when 'MultiLineString'
                           multiLineClass.writeXML(hGeometry, hProps, id)
                        when 'MultiPolygon'
                           multiPolyClass.writeXML(hGeometry, hProps, id)
                        when 'GeometryCollection'
                           geoCollectionClass.writeXML(hGeometry, hProps, id)
                        else
                           @NameSpace.issueNotice(140, "#{hGeometry[:type]}")
                     end
                  end

               end # writeXML
            end # Feature class

         end
      end
   end
end
