# HTML writer
# spatial reference system parameter set

# History:
#  Stan Smith 2017-10-24 original script

require_relative 'html_projectionParameters'
require_relative 'html_geodeticParameters'
require_relative 'html_verticalDatumParameters'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_ReferenceSystemParameters

               def initialize(html)
                  @html = html
               end

               def writeHtml(hParamSet)

                  # classes used
                  projectionClass = Html_ProjectionParameters.new(@html)
                  ellipsoidClass = Html_GeodeticParameters.new(@html)
                  verticalClass = Html_VerticalDatumParameters.new(@html)

                  # reference parameter set - projection
                  unless hParamSet[:projection].empty?
                     @html.details do
                        @html.summary('Projection Parameters', {'id' => 'projection', 'class' => 'h5'})
                        @html.section(:class => 'block') do
                           projectionClass.writeHtml(hParamSet[:projection])
                        end
                     end
                  end

                  # reference parameter set - geodetic
                  unless hParamSet[:geodetic].empty?
                     @html.details do
                        @html.summary('Geodetic Parameters', {'id' => 'geodetic', 'class' => 'h5'})
                        @html.section(:class => 'block') do
                           ellipsoidClass.writeHtml(hParamSet[:geodetic])
                        end
                     end
                  end

                  # reference parameter set - vertical datum
                  unless hParamSet[:verticalDatum].empty?
                     @html.details do
                        @html.summary('Vertical Datum Parameters', {'id' => 'verticalDatum', 'class' => 'h5'})
                        @html.section(:class => 'block') do
                           verticalClass.writeHtml(hParamSet[:verticalDatum])
                        end
                     end
                  end

               end # writeHtml
            end # Html_ReferenceSystemParameters

         end
      end
   end
end
