# HTML writer
# spatial representation

# History:
#  Stan Smith 2017-03-28 original script

require_relative 'html_gridRepresentation'
require_relative 'html_vectorRepresentation'
require_relative 'html_georectifiedRepresentation'
require_relative 'html_georeferenceableRepresentation'

module ADIWG
   module Mdtranslator
      module Writers
         module SimpleHtml

            class Html_SpatialRepresentation

               def initialize(html)
                  @html = html
               end

               def writeHtml(hRepresentation)

                  # classes used
                  gridClass = Html_GridRepresentation.new(@html)
                  vectorClass = Html_VectorRepresentation.new(@html)
                  georectifiedClass = Html_GeorectifiedRepresentation.new(@html)
                  georeferenceableClass = Html_GeoreferenceableRepresentation.new(@html)

                  # spatial Representation - grid {gridRepresentation}
                  unless hRepresentation[:gridRepresentation].empty?
                     @html.div do
                        @html.div('Grid Representation ', 'class' => 'h5')
                        @html.div(:class => 'block') do
                           gridClass.writeHtml(hRepresentation[:gridRepresentation])
                        end
                     end
                  end

                  # spatial Representation - vector {vectorRepresentation}
                  unless hRepresentation[:vectorRepresentation].empty?
                     @html.div do
                        @html.div('Vector Representation ', 'class' => 'h5')
                        @html.div(:class => 'block') do
                           vectorClass.writeHtml(hRepresentation[:vectorRepresentation])
                        end
                     end
                  end

                  # spatial Representation - georectified {georectifiedRepresentation}
                  unless hRepresentation[:georectifiedRepresentation].empty?
                     @html.div do
                        @html.div('Georectified Representation ', 'class' => 'h5')
                        @html.div(:class => 'block') do
                           georectifiedClass.writeHtml(hRepresentation[:georectifiedRepresentation])
                        end
                     end
                  end

                  # spatial Representation - georeferenceable {georeferenceableRepresentation}
                  unless hRepresentation[:georeferenceableRepresentation].empty?
                     @html.div do
                        @html.div('Georeferenceable Representation ', 'class' => 'h5')
                        @html.div(:class => 'block') do
                           georeferenceableClass.writeHtml(hRepresentation[:georeferenceableRepresentation])
                        end
                     end
                  end

               end # writeHtml
            end # Html_SpatialRepresentation

         end
      end
   end
end
