# HTML writer
# grid representation

# History:
#  Stan Smith 2017-03-28 refactored for mdTranslator 2.0
# 	Stan Smith 2015-07-31 original script

require_relative 'html_dimension'
require_relative 'html_scope'

module ADIWG
   module Mdtranslator
      module Writers
         module SimpleHtml

            class Html_GridRepresentation

               def initialize(html)
                  @html = html
               end

               def writeHtml(hGrid)

                  # classes used
                  dimensionClass = Html_Dimension.new(@html)
                  scopeClass = Html_Scope.new(@html)

                  # grid representation - scope
                  hGrid[:scope].each do |scope|
                     @html.div do
                        @html.div('Scope ', 'class' => 'h5')
                        @html.div(:class => 'block') do
                           scopeClass.writeHtml(hGrid[:scope])
                        end
                     end
                  end


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
                     @html.div do
                        @html.div('Dimension '+dimensionCount.to_s, 'class' => 'h5')
                        @html.div(:class => 'block') do
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
