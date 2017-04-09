# HTML writer
# geographic element

# History:
#  Stan Smith 2017-04-06 original script

require_relative 'html_geometryObject'
require_relative 'html_geometryCollection'
require_relative 'html_feature'
require_relative 'html_featureCollection'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_GeographicElement

               def initialize(html)
                  @html = html
               end

               def writeHtml(hElement)

                  # classes used
                  geometryClass = Html_GeometryObject.new(@html)
                  geoCollectionClass =Html_GeometryCollection.new(@html)
                  featureClass =Html_Feature.new(@html)
                  featCollectionClass =Html_FeatureCollection.new(@html)

                  geoElement = hElement[:geographicElement]

                  # geographic element - geometry objects
                  case geoElement[:type]
                     when 'Point', 'LineString', 'Polygon', 'MultiPoint', 'MultiLineString', 'MultiPolygon'
                        @html.details do
                           @html.summary(geoElement[:type], 'class' => 'h5')
                           @html.section(:class => 'block') do
                              geometryClass.writeHtml(geoElement)
                           end
                        end

                     when 'GeometryCollection'
                        @html.details do
                           @html.summary('Geometry Collection', 'class' => 'h5')
                           @html.section(:class => 'block') do
                              geoCollectionClass.writeHtml(geoElement)
                           end
                        end

                     when 'Feature'
                        @html.details do
                           title = 'Feature'
                           unless geoElement[:id].nil?
                              title += ': '+geoElement[:id].to_s
                           end
                           @html.summary(title, 'class' => 'h5')
                           @html.section(:class => 'block') do
                              featureClass.writeHtml(geoElement)
                           end
                        end

                     when 'FeatureCollection'
                        @html.details do
                           @html.summary(geoElement[:type], 'class' => 'h5')
                           @html.section(:class => 'block') do
                              featCollectionClass.writeHtml(geoElement)
                           end
                        end

                     else
                        @html.text!('Bad GeoJSON Type: '+geoElement[:type])
                  end

                  # geographic element - native GeoJson
                  unless hElement[:nativeGeoJson].empty?
                     @html.details do
                        @html.summary('GeoJson', 'class' => 'h5')
                        @html.section(:class => 'block') do
                           @html.text!(hElement[:nativeGeoJson].to_s)
                        end
                     end
                  end

               end # writeHtml
            end # Html_GeographicElement

         end
      end
   end
end
