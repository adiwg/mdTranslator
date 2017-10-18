# HTML writer
# grid representation

# History:
#  Stan Smith 2017-03-28 refactored for mdTranslator 2.0
# 	Stan Smith 2015-07-31 original script

require_relative 'html_dimension'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_GridRepresentation

               def initialize(html)
                  @html = html
               end

               def writeHtml(hGrid)

                  # classes used
                  dimensionClass = Html_Dimension.new(@html)

                  # grid representation - number of dimensions
                  unless hGrid[:numberOfDimensions].nil?
                     @html.em('Number of dimensions: ')
                     @html.text!(hGrid[:numberOfDimensions].to_s)
                     @html.br
                  end

                  # grid representation - dimension []
                  dimensionCount = 0
                  hGrid[:dimension].each do |hDimension|
                     dimensionCount += 1
                     @html.details do
                        @html.summary('Dimension '+dimensionCount.to_s, 'class' => 'h5')
                        @html.section(:class => 'block') do
                           dimensionClass.writeHtml(hDimension)
                        end
                     end

                  end

                  # grid representation - cell geometry
                  unless hGrid[:cellGeometry].nil?
                     @html.em('Cell Geometry: ')
                     @html.text!(hGrid[:cellGeometry])
                     @html.br
                  end

                  # grid representation - transformation parameters available {Boolean}
                  @html.em('Transformation parameters available: ')
                  @html.text!(hGrid[:transformationParameterAvailable].to_s)

               end # writeHtml
            end # Html_GridRepresentation

         end
      end
   end
end
