# HTML writer
# spatial representation

# History:
#  Stan Smith 2017-03-28 original script

require_relative 'html_gridRepresentation'
require_relative 'html_vectorRepresentation'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_SpatialRepresentation

               def initialize(html)
                  @html = html
               end

               def writeHtml(hRepresentation)

                  # classes used
                  gridClass = HTML_GridRepresentation.new(@html)
                  vectorClass = HTML_VectorRepresentation.new(@html)

                  # spatial Representation - grid {gridRepresentation}
                  unless hRepresentation[:gridRepresentation].empty?
                     @html.details do
                        @html.summary('Grid Representation ', 'class' => 'h5')
                        @html.section(:class => 'block') do
                           gridClass.writeHtml(hRepresentation[:gridRepresentation])
                        end
                     end
                  end

                  # spatial Representation - vector {vectorRepresentation}
                  unless hRepresentation[:vectorRepresentation].empty?
                     @html.details do
                        @html.summary('Vector Representation ', 'class' => 'h5')
                        @html.section(:class => 'block') do
                           vectorClass.writeHtml(hRepresentation[:vectorRepresentation])
                        end
                     end
                  end

               end # writeHtml
            end # Html_SpatialRepresentation

         end
      end
   end
end
