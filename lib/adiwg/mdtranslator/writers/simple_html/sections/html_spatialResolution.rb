# HTML writer
# resolution

# History:
#  Stan Smith 2017-10-20 added coordinateResolution
#  Stan Smith 2017-10-20 added bearingDistanceResolution
#  Stan Smith 2017-10-20 added geographicResolution
#  Stan Smith 2017-03-29 refactored for mdTranslator 2.0
# 	Stan Smith 2015-03-26 original script

require_relative 'html_measure'
require_relative 'html_coordinateResolution'
require_relative 'html_bearingDistanceResolution'
require_relative 'html_geographicResolution'

module ADIWG
   module Mdtranslator
      module Writers
         module Simple_html

            class Html_SpatialResolution

               def initialize(html)
                  @html = html
               end

               def writeHtml(hResolution)

                  measureClass = Html_Measure.new(@html)
                  coordinateClass = Html_CoordinateResolution.new(@html)
                  bearingClass = Html_BearingDistanceResolution.new(@html)
                  geoClass = Html_GeographicResolution.new(@html)

                  # resolution - scale factor
                  unless hResolution[:scaleFactor].nil?
                     @html.em('Scale Factor: ')
                     @html.text!(hResolution[:scaleFactor].to_s)
                     @html.br
                  end

                  # resolution - measure
                  unless hResolution[:measure].empty?
                     @html.div do
                        @html.div('Resolution Measure', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           measureClass.writeHtml(hResolution[:measure])
                        end
                     end
                  end

                  # resolution - coordinate resolution
                  unless hResolution[:coordinateResolution].empty?
                     @html.div do
                        @html.div('Coordinate Resolution', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           coordinateClass.writeHtml(hResolution[:coordinateResolution])
                        end
                     end
                  end

                  # resolution - bearing distance resolution
                  unless hResolution[:bearingDistanceResolution].empty?
                     @html.div do
                        @html.div('Bearing Distance Resolution', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           bearingClass.writeHtml(hResolution[:bearingDistanceResolution])
                        end
                     end
                  end

                  # resolution - geographic resolution
                  unless hResolution[:geographicResolution].empty?
                     @html.div do
                        @html.div('Geographic Resolution', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           geoClass.writeHtml(hResolution[:geographicResolution])
                        end
                     end
                  end

                  # resolution - level of detail
                  unless hResolution[:levelOfDetail].nil?
                     @html.em('Level of Detail: ')
                     @html.div(:class => 'block') do
                        @html.text!(hResolution[:levelOfDetail])
                     end
                  end

               end # writeHtml
            end # Html_Resolution

         end
      end
   end
end
