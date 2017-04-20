# HTML writer
# geometry object

# History:
#  Stan Smith 2017-04-06 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_GeometryObject

               def initialize(html)
                  @html = html
               end

               def writeHtml(hObject)

                  # geometry object - coordinates
                  unless hObject[:coordinates].nil?
                     @html.details do
                        @html.summary('Coordinates', 'class' => 'h5')
                        @html.section(:class => 'block') do
                           @html.text!(hObject[:coordinates].to_s)
                        end
                     end
                  end

                  # geographic element - native GeoJson
                  unless hObject[:nativeGeoJson].empty?
                     @html.details do
                        @html.summary('GeoJson', 'class' => 'h5')
                        @html.section(:class => 'block') do
                           @html.text!(hObject[:nativeGeoJson].to_json)
                        end
                     end
                  end

               end # writeHtml
            end # Html_GeometryObject

         end
      end
   end
end
