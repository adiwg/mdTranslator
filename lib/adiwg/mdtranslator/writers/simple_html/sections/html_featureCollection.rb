# HTML writer
# feature collection

# History:
#  Stan Smith 2017-04-08 original script

require_relative 'html_feature'
require_relative 'html_boundingBox'

module ADIWG
   module Mdtranslator
      module Writers
         module Simple_html

            class Html_FeatureCollection

               def initialize(html)
                  @html = html
               end

               def writeHtml(hCollection)

                  # classes used
                  featureClass = Html_Feature.new(@html)
                  boxClass = Html_BoundingBox.new(@html)

                  # feature collection - feature [] {feature}
                  hCollection[:features].each do |feature|
                     @html.div do
                        title = 'Feature'
                        unless feature[:id].nil?
                           title += ': '+feature[:id].to_s
                        end
                        @html.h5(title, 'class' => 'h5')
                        @html.div(:class => 'block') do
                           featureClass.writeHtml(feature)
                        end
                     end
                  end

                  # feature collection - user bounding box
                  unless hCollection[:bbox].empty?
                     @html.div do
                        @html.h5('User Provided Bounding Box', 'class' => 'h5')
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

                  # feature collection - computed bounding box
                  unless hCollection[:computedBbox].empty?
                     @html.div do
                        @html.h5('Computed Bounding Box', 'class' => 'h5')
                        @html.div(:class => 'block') do
                           boxClass.writeHtml(hCollection[:computedBbox])
                        end
                     end
                  end

                  # feature collection - native GeoJson
                  unless hCollection[:nativeGeoJson].empty?
                     @html.div do
                        @html.h5('GeoJson', 'class' => 'h5')
                        @html.div(:class => 'block') do
                           @html.text!(hCollection[:nativeGeoJson].to_json)
                        end
                     end
                  end

               end # writeHtml
            end # Html_FeatureCollection

         end
      end
   end
end
