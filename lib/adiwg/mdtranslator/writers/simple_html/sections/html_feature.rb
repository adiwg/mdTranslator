# HTML writer
# feature

# History:
#  Stan Smith 2017-04-08 original script

require_relative 'html_geometryObject'
require_relative 'html_boundingBox'
require_relative 'html_featureProperties'

module ADIWG
   module Mdtranslator
      module Writers
         module Simple_html

            class Html_Feature

               def initialize(html)
                  @html = html
               end

               def writeHtml(hFeature)

                  # classes used
                  geometryClass = Html_GeometryObject.new(@html)
                  boxClass = Html_BoundingBox.new(@html)
                  propertyClass = Html_FeatureProperty.new(@html)

                  # feature - id
                  unless hFeature[:id].nil?
                     @html.em('ID: ')
                     @html.text!(hFeature[:id])
                     @html.br
                  end

                  # feature - geometry object
                  unless hFeature[:geometryObject].empty?
                     @html.div do
                        @html.h5(hFeature[:geometryObject][:type], 'class' => 'h5')
                        @html.div(:class => 'block') do
                           geometryClass.writeHtml(hFeature[:geometryObject])
                        end
                     end
                  end

                  # feature - user bounding box
                  unless hFeature[:bbox].empty?
                     @html.div do
                        @html.h5('User Provided Bounding Box', 'class' => 'h5')
                        @html.div(:class => 'block') do
                           bbox = {}
                           bbox[:westLongitude] = hFeature[:bbox][0]
                           bbox[:eastLongitude] = hFeature[:bbox][2]
                           bbox[:southLatitude] = hFeature[:bbox][1]
                           bbox[:northLatitude] = hFeature[:bbox][3]
                           boxClass.writeHtml(bbox)
                        end
                     end
                  end

                  # feature - computed bounding box
                  unless hFeature[:computedBbox].empty?
                     @html.div do
                        @html.h5('Computed Bounding Box', 'class' => 'h5')
                        @html.div(:class => 'block') do
                           boxClass.writeHtml(hFeature[:computedBbox])
                        end
                     end
                  end

                  # feature - properties
                  unless hFeature[:properties].empty?
                     @html.div do
                        @html.h5('Properties', 'class' => 'h5')
                        @html.div(:class => 'block') do
                           propertyClass.writeHtml(hFeature[:properties])
                        end
                     end
                  end

                  # feature - native GeoJson
                  unless hFeature[:nativeGeoJson].empty?
                     @html.div do
                        @html.h5('GeoJson', 'class' => 'h5')
                        @html.div(:class => 'block') do
                           @html.text!(hFeature[:nativeGeoJson].to_json)
                        end
                     end
                  end

               end # writeHtml
            end # Html_Feature

         end
      end
   end
end
