# ISO <<Class>> geographicElement {abstract}
# 19115-3 writer output in XML

# History:
# 	Stan Smith 2019-03-19 original script

require_relative '../iso19115_3_writer'
require_relative 'class_point'
require_relative 'class_lineString'
require_relative 'class_polygon'
require_relative 'class_multiPoint'
require_relative 'class_multiLine'
require_relative 'class_multiPolygon'
require_relative 'class_geometryCollection'
require_relative 'class_feature'
require_relative 'class_featureCollection'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class GeographicElement

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_3
               end

               def writeXML(aGeoElement)

                  # classes used
                  pointClass = Point.new(@xml, @hResponseObj)
                  lineClass = LineString.new(@xml, @hResponseObj)
                  polyClass = Polygon.new(@xml, @hResponseObj)
                  multiPointClass = MultiPoint.new(@xml, @hResponseObj)
                  multiLineClass = MultiLineString.new(@xml, @hResponseObj)
                  multiPolyClass = MultiPolygon.new(@xml, @hResponseObj)
                  geoCollectClass = GeometryCollection.new(@xml, @hResponseObj)
                  featureClass = Feature.new(@xml, @hResponseObj)
                  featureCollectClass = FeatureCollection.new(@xml, @hResponseObj)

                  aGeoElement.each do |hGeoElement|
                     @xml.tag!('gex:polygon') do
                        case hGeoElement[:type]
                           when 'Point'
                              pointClass.writeXML(hGeoElement, {}, nil)
                           when 'LineString'
                              lineClass.writeXML(hGeoElement, {}, nil)
                           when 'Polygon'
                              polyClass.writeXML(hGeoElement, {}, nil)
                           when 'MultiPoint'
                              multiPointClass.writeXML(hGeoElement, {}, nil)
                           when 'MultiLineString'
                              multiLineClass.writeXML(hGeoElement, {}, nil)
                           when 'MultiPolygon'
                              multiPolyClass.writeXML(hGeoElement, {}, nil)
                           when 'GeometryCollection'
                              geoCollectClass.writeXML(hGeoElement, {}, nil)
                           when 'Feature'
                              featureClass.writeXML(hGeoElement)
                           when 'FeatureCollection'
                              featureCollectClass.writeXML(hGeoElement)
                           else
                              @NameSpace.issueNotice(110, "#{hGeoElement[:type]}")
                        end
                     end
                  end

               end # writeXML
            end # GeographicElement class

         end
      end
   end
end
