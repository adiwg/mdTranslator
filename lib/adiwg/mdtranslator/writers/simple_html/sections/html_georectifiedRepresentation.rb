# HTML writer
# georectified representation

# History:
#  Stan Smith 2017-03-28 original script

require_relative 'html_gridRepresentation'
require_relative 'html_scope'

module ADIWG
   module Mdtranslator
      module Writers
         module Simple_html

            class Html_GeorectifiedRepresentation

               def initialize(html)
                  @html = html
               end

               def writeHtml(hGeorectified)

                  # classes used
                  gridClass = Html_GridRepresentation.new(@html)
                  scopeClass = Html_Scope.new(@html)

                  # georectified representation - scope
                  hGeorectified[:scope].each do |scope|
                     @html.div do
                        @html.h5('Scope ', 'class' => 'h5')
                        @html.div(:class => 'block') do
                           scopeClass.writeHtml(hGeorectified[:scope])
                        end
                     end
                  end

                  # georectified representation - grid {gridRepresentation}
                  unless hGeorectified[:gridRepresentation].empty?
                     @html.div do
                        @html.h5('Grid Information ', 'class' => 'h5')
                        @html.div(:class => 'block') do
                           gridClass.writeHtml(hGeorectified[:gridRepresentation])
                        end
                     end
                  end

                  # georectified representation - check point available {Boolean}
                  @html.em('Check Point Available: ')
                  @html.text!(hGeorectified[:checkPointAvailable].to_s)
                  @html.br

                  # georectified representation - check point description
                  unless hGeorectified[:checkPointDescription].nil?
                     @html.em('Check Point Description: ')
                     @html.div(:class => 'block') do
                        @html.text!(hGeorectified[:checkPointDescription])
                     end
                  end

                  # georectified representation - corner points [ 4 coordinates ]
                  unless hGeorectified[:cornerPoints].nil?
                     @html.em('Corner Points: ')
                     @html.div(:class => 'block') do
                        @html.text!(hGeorectified[:cornerPoints].to_s)
                     end
                  end

                  # georectified representation - center point [ 1 coordinate ]
                  unless hGeorectified[:centerPoint].nil?
                     @html.em('Center Point: ')
                     @html.div(:class => 'block') do
                        @html.text!(hGeorectified[:centerPoint].to_s)
                     end
                  end

                  # georectified representation - point in pixel
                  unless hGeorectified[:pointInPixel].nil?
                     @html.em('Point in Pixel: ')
                     @html.text!(hGeorectified[:pointInPixel].to_s)
                     @html.br
                  end

                  # georectified representation - transformation dimension description
                  unless hGeorectified[:transformationDimensionDescription].nil?
                     @html.em('Transformation Dimension Description: ')
                     @html.div(:class => 'block') do
                        @html.text!(hGeorectified[:transformationDimensionDescription])
                     end
                  end

                  # georectified representation - transformation dimension mapping
                  unless hGeorectified[:transformationDimensionMapping].nil?
                     @html.em('Transformation Dimension Mapping: ')
                     @html.div(:class => 'block') do
                        @html.text!(hGeorectified[:transformationDimensionMapping])
                     end
                  end

               end # writeHtml
            end # Html_GeorectifiedRepresentation

         end
      end
   end
end
