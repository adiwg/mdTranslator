# HTML writer
# georeferenceable representation

# History:
#  Stan Smith 2017-03-29 original script

require_relative 'html_gridRepresentation'
require_relative 'html_citation'
require_relative 'html_scope'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_GeoreferenceableRepresentation

               def initialize(html)
                  @html = html
               end

               def writeHtml(hGeoreferenceable)

                  # classes used
                  gridClass = Html_GridRepresentation.new(@html)
                  citationClass = Html_Citation.new(@html)
                  scopeClass = Html_Scope.new(@html)

                  # georeferenceable representation - scope
                  hGeoreferenceable[:scope].each do |scope|
                     @html.details do
                        @html.summary('Scope ', 'class' => 'h5')
                        @html.section(:class => 'block') do
                           scopeClass.writeHtml(hGeoreferenceable[:scope])
                        end
                     end
                  end


                  # georeferenceable representation - grid {gridRepresentation}
                  unless hGeoreferenceable[:gridRepresentation].empty?
                     @html.details do
                        @html.summary('Grid Information ', 'class' => 'h5')
                        @html.section(:class => 'block') do
                           gridClass.writeHtml(hGeoreferenceable[:gridRepresentation])
                        end
                     end
                  end

                  # georeferenceable representation - control point available {Boolean}
                  @html.em('Control Point Available: ')
                  @html.text!(hGeoreferenceable[:controlPointAvailable].to_s)
                  @html.br

                  # georeferenceable representation - orientation parameter available {Boolean}
                  @html.em('Orientation Parameter Available: ')
                  @html.text!(hGeoreferenceable[:orientationParameterAvailable].to_s)
                  @html.br

                  # georeferenceable representation - orientation parameter description
                  unless hGeoreferenceable[:orientationParameterDescription].nil?
                     @html.em('Orientation Parameter Description: ')
                     @html.section(:class => 'block') do
                        @html.text!(hGeoreferenceable[:orientationParameterDescription])
                     end
                  end

                  # georeferenceable representation - georeferenced parameter
                  unless hGeoreferenceable[:georeferencedParameter].nil?
                     @html.em('Georeferenced Parameter: ')
                     @html.text!(hGeoreferenceable[:georeferencedParameter])
                     @html.br
                  end

                  # georeferenceable representation - parameter citation {citation}
                  hGeoreferenceable[:parameterCitation].each do |hCitation|
                     @html.details do
                        @html.summary('Parameter Citation ', 'class' => 'h5')
                        @html.section(:class => 'block') do
                           citationClass.writeHtml(hCitation)
                        end
                     end
                  end

               end # writeHtml
            end # Html_GeoreferenceableRepresentation

         end
      end
   end
end
