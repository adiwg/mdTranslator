# GeoJSON GeometryCollection
# 19115-3 writer output in XML

# History:
#  Stan Smith 2019-03-20 original script

require_relative '../iso19115_3_writer'
require_relative 'class_point'
require_relative 'class_lineString'
require_relative 'class_polygon'
require_relative 'class_multiPoint'
require_relative 'class_multiLine'
require_relative 'class_multiPolygon'
require_relative 'class_featureProperties'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class GeometryCollection

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_3
               end

               def writeXML(hGeoObject, hProperties, objId)

                  # classes used
                  pointClass = Point.new(@xml, @hResponseObj)
                  lineClass = LineString.new(@xml, @hResponseObj)
                  polyClass = Polygon.new(@xml, @hResponseObj)
                  multiPointClass = MultiPoint.new(@xml, @hResponseObj)
                  multiLineClass = MultiLineString.new(@xml, @hResponseObj)
                  multiPolyClass = MultiPolygon.new(@xml, @hResponseObj)
                  geoPropClass = FeatureProperties.new(@xml, @hResponseObj)

                  # geometry collection attributes
                  attributes = {}

                  # geometry collection attributes - gml:id (required)
                  if objId.nil?
                     @hResponseObj[:writerMissingIdCount] = @hResponseObj[:writerMissingIdCount].succ
                     objId = 'geometryCollection' + @hResponseObj[:writerMissingIdCount]
                  else
                     objId.gsub!(/[^0-9a-zA-Z]/, '')
                  end
                  attributes['gml:id'] = objId

                  # geometry collection attributes - srsName (GeoJSON is WGS84)
                  attributes[:srsName] = 'WGS84'

                  @xml.tag!('gml:MultiGeometry', attributes) do

                     # geometry collection - properties for Feature
                     unless hProperties.empty?
                        geoPropClass.writeXML(hProperties)
                     end

                     # geometry collection - geometry objects (required)
                     unless hGeoObject[:geometryObjects].empty?
                        @xml.tag!('gml:geometryMembers') do
                           aObjects = hGeoObject[:geometryObjects]
                           aObjects.each do |hGeoObj|
                              case hGeoObj[:type]
                                 when 'Point'
                                    pointClass.writeXML(hGeoObj, {}, nil)
                                 when 'LineString'
                                    lineClass.writeXML(hGeoObj, {}, nil)
                                 when 'Polygon'
                                    polyClass.writeXML(hGeoObj, {}, nil)
                                 when 'MultiPoint'
                                    multiPointClass.writeXML(hGeoObj, {}, nil)
                                 when 'MultiLineString'
                                    multiLineClass.writeXML(hGeoObj, {}, nil)
                                 when 'MultiPolygon'
                                    multiPolyClass.writeXML(hGeoObj, {}, nil)
                                 else
                                    @NameSpace.issueNotice(160, "#{hGeoObj[:type]}")
                              end
                           end
                        end
                     end
                     if hGeoObject[:geometryObjects].empty?
                        @NameSpace.issueWarning(161, nil, 'geometry collection')
                     end

                  end # gml:MultiGeometry tag
               end # writeXML
            end # GeometryCollection class

         end
      end
   end
end
