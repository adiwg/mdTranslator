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

            class HTML_GridRepresentation

               def initialize(html)
                  @html = html
               end

               def writeHtml(hGrid)

                  # classes used
                  dimensionClass = Html_Dimension.new(@html)

                  # grid representation - number of dimensions
                  @html.em('Number of dimensions: ')
                  @html.text!(hGrid[:numberOfDimensions].to_s)
                  @html.br

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

                  # # grid information - cell geometry
                  # s = hGrid[:dimensionGeometry]
                  # if !s.nil?
                  #    @html.em('Cell Geometry: ')
                  #    @html.text!(s)
                  #    @html.br
                  # end
                  #
                  # # grid information - transformation parameters available
                  # @html.em('Transformation parameters available: ')
                  # s = hGrid[:dimensionTransformParams]
                  # if s
                  #    @html.text!('true')
                  # else
                  #    @html.text!('false')
                  # end
                  # @html.br
                  #
                  # # grid information - dimensions
                  # aDims = hGrid[:dimensionInfo]
                  # aDims.each do |hDim|
                  #    @html.details do
                  #       @html.summary('Dimension', {'class' => 'h4'})
                  #       @html.section(:class => 'block') do
                  #          htmlDim.writeHtml(hDim)
                  #       end
                  #    end
                  # end

               end # writeHtml
            end # HTML_GridRepresentation

         end
      end
   end
end
