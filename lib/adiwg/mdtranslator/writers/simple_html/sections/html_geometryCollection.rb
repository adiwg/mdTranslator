# HTML writer
# geometry collection

# History:
#  Stan Smith 2017-04-06 original script

require_relative 'html_geometryObject'
require_relative 'html_boundingBox'

module ADIWG
   module Mdtranslator
      module Writers
         module Simple_html

            class Html_GeometryCollection

               def initialize(html)
                  @html = html
               end

               def writeHtml(hCollection)

                  # classes used
                  geometryClass = Html_GeometryObject.new(@html)
                  boxClass = Html_BoundingBox.new(@html)

                  # geometry collection - objects
                  hCollection[:geometryObjects].each do |hObject|
                     @html.div do
                        @html.div(hObject[:type], 'class' => 'h5')
                        @html.div(:class => 'block') do
                           geometryClass.writeHtml(hObject)
                        end
                     end
                  end

                  # geometry collection - user bounding box
                  unless hCollection[:bbox].empty?
                     @html.div do
                        @html.div('User Provided Bounding Box', 'class' => 'h5')
                        @html.div(:class => 'block') do
                           bbox = {}
                           bbox[:westLongitude] = hCollection[:bbox][0]
                           bbox[:eastLongitude] = hCollection[:bbox][2]
                           bbox[:southLatitude] = hCollection[:bbox][1]
                           bbox[:northLatitude] = hCollection[:bbox][3]
                           boxClass.writeHtml(bbox)
                        end
                     end
                  end

                  # geometry collection - computed bounding box
                  unless hCollection[:computedBbox].empty?
                     @html.div do
                        @html.div('Computed Bounding Box', 'class' => 'h5')
                        @html.div(:class => 'block') do
                           boxClass.writeHtml(hCollection[:computedBbox])
                        end
                     end
                  end

                  # geographic element - native GeoJson
                  unless hCollection[:nativeGeoJson].empty?
                     @html.div do
                        @html.div('GeoJson', 'class' => 'h5')
                        @html.div(:class => 'block') do
                           @html.text!(hCollection[:nativeGeoJson].to_json)
                        end
                     end
                  end

               end # writeHtml
            end # Html_GeometryCollection

         end
      end
   end
end
