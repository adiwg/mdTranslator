# HTML writer
# geographic extent

# History:
#  Stan Smith 2017-04-06 refactored for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
# 	Stan Smith 2015-03-31 original script

require_relative 'html_identifier'
require_relative 'html_boundingBox'
require_relative 'html_geographicElement'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_GeographicExtent

               def initialize(html)
                  @html = html
               end

               def writeHtml(hExtent)

                  # classes used
                  identifierClass = Html_Identifier.new(@html)
                  boundingClass = Html_BoundingBox.new(@html)
                  geographicClass = Html_GeographicElement.new(@html)

                  # geographic extent - contains data {Boolean}
                  @html.em('Geographic Extent Encompasses Data: ')
                  @html.text!(hExtent[:containsData].to_s)
                  @html.br

                  # geographic extent - map {div}
                  @html.details do
                     @html.summary('Map', 'class' => 'h5 map-summary')
                     @html.section(:class => 'block') do
                        @html.div('class' => 'map', 'id' => 'map') do
                           # map drawn by html_bodyScript.js
                        end
                     end
                  end

                  # geographic extent - geographic element [] {geographicElement}
                  unless hExtent[:geographicElements].empty?
                     @html.details do
                        @html.summary('Elements', 'class' => 'h5')
                        @html.section(:class => 'block') do
                           hExtent[:geographicElements].each do |hElement|
                              geographicClass.writeHtml(hElement)
                           end
                        end
                     end
                  end

                  # geographic extent - user bounding box
                  unless hExtent[:boundingBox].empty?
                     @html.details do
                        @html.summary('User Provided Bounding Box', 'class' => 'h5')
                        @html.section(:class => 'block') do
                           boundingClass.writeHtml(hExtent[:boundingBox])
                           @html.div(:class =>'userBBox hidden') do
                              @html.text!(hExtent[:boundingBox].to_json)
                           end
                        end
                     end
                  end

                  # computed bounding box - {boundingBox}
                  unless hExtent[:computedBbox].empty?
                     @html.details do
                        @html.summary('Computed Bounding Box', 'class' => 'h5')
                        @html.section(:class => 'block') do
                           boundingClass.writeHtml(hExtent[:computedBbox])
                           @html.div(:class =>'computedBBox hidden') do
                              @html.text!(hExtent[:computedBbox].to_json)
                           end
                        end
                     end
                  end

                  # geographic extent - identifier {identifier}
                  unless hExtent[:identifier].empty?
                     @html.details do
                        @html.summary('Identifier', 'class' => 'h5')
                        @html.section(:class => 'block') do
                           identifierClass.writeHtml(hExtent[:identifier])
                        end
                     end
                  end

                  # geographic extent - native GeoJson
                  unless hExtent[:nativeGeoJson].empty?
                     @html.details do
                        @html.summary('GeoJson', 'class' => 'h5')
                        @html.section(:class => 'block') do
                           @html.div(:class =>'geojson', :dataPopup => 'fill in popData') do
                              @html.text!(hExtent[:nativeGeoJson].to_json)
                           end
                        end
                     end
                  end

               end # writeHtml
            end # Html_GeographicExtent

         end
      end
   end
end
