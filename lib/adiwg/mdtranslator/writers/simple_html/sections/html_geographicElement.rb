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
         module Simple_html

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

                  # geographic element - geometry objects
                  case hElement[:type]
                     when 'Point', 'LineString', 'Polygon', 'MultiPoint', 'MultiLineString', 'MultiPolygon'
                        @html.div do
                           @html.div(hElement[:type], 'class' => 'h5')
                           @html.div(:class => 'block') do
                              geometryClass.writeHtml(hElement)
                           end
                        end

                     when 'GeometryCollection'
                        @html.div do
                           @html.div('Geometry Collection', 'class' => 'h5')
                           @html.div(:class => 'block') do
                              geoCollectionClass.writeHtml(hElement)
                           end
                        end

                     when 'Feature'
                        @html.div do
                           title = 'Feature'
                           unless hElement[:id].nil?
                              title += ': '+hElement[:id].to_s
                           end
                           @html.div(title, 'class' => 'h5')
                           @html.div(:class => 'block') do
                              featureClass.writeHtml(hElement)
                           end
                        end

                     when 'FeatureCollection'
                        @html.div do
                           @html.div(hElement[:type], 'class' => 'h5')
                           @html.div(:class => 'block') do
                              featCollectionClass.writeHtml(hElement)
                           end
                        end

                     else
                        @html.text!('Bad GeoJSON Type: '+hElement[:type])
                  end

               end # writeHtml
            end # Html_GeographicElement

         end
      end
   end
end
