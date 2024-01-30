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
         module Html

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
                  unless hRepresentation[:gridRepresentation].nil? || hRepresentation[:gridRepresentation].empty?
                     @html.details do
                        @html.summary('Grid Representation ', 'class' => 'h5')
                        @html.section(:class => 'block') do
                           gridClass.writeHtml(hRepresentation[:gridRepresentation])
                        end
                     end
                  end

                  # spatial Representation - vector {vectorRepresentation}
                  unless hRepresentation[:vectorRepresentation].nil? || hRepresentation[:vectorRepresentation].empty?
                     @html.details do
                        @html.summary('Vector Representation ', 'class' => 'h5')
                        @html.section(:class => 'block') do
                           vectorClass.writeHtml(hRepresentation[:vectorRepresentation])
                        end
                     end
                  end

                  # spatial Representation - georectified {georectifiedRepresentation}
                  unless hRepresentation[:georectifiedRepresentation].nil? || hRepresentation[:georectifiedRepresentation].empty?
                     @html.details do
                        @html.summary('Georectified Representation ', 'class' => 'h5')
                        @html.section(:class => 'block') do
                           georectifiedClass.writeHtml(hRepresentation[:georectifiedRepresentation])
                        end
                     end
                  end

                  # spatial Representation - georeferenceable {georeferenceableRepresentation}
                  unless hRepresentation[:georeferenceableRepresentation].nil? || hRepresentation[:georeferenceableRepresentation].empty?
                     @html.details do
                        @html.summary('Georeferenceable Representation ', 'class' => 'h5')
                        @html.section(:class => 'block') do
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
