# HTML writer
# spatial reference system parameter set

# History:
#  Stan Smith 2017-10-24 original script

require_relative 'html_projectionParameters'
require_relative 'html_ellipsoidParameters'
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
                  ellipsoidClass = Html_EllipsoidParameters.new(@html)
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

                  # reference parameter set - ellipsoid
                  unless hParamSet[:ellipsoid].empty?
                     @html.details do
                        @html.summary('Ellipsoid Parameters', {'id' => 'ellipsoid', 'class' => 'h5'})
                        @html.section(:class => 'block') do
                           ellipsoidClass.writeHtml(hParamSet[:ellipsoid])
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
