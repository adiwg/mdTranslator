# HTML writer
# source

# History:
#  Stan Smith 2017-04-03 refactored for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
# 	Stan Smith 2015-03-27 original script

require_relative 'html_citation'
require_relative 'html_spatialResolution'
require_relative 'html_spatialReference'
require_relative 'html_processStep'
require_relative 'html_scope'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_Source

               def initialize(html)
                  @html = html
               end

               def writeHtml(hSource)

                  # classes used
                  citationClass = Html_Citation.new(@html)
                  resolutionClass = Html_SpatialResolution.new(@html)
                  referenceClass = Html_SpatialReference.new(@html)
                  stepClass = Html_ProcessStep.new(@html)
                  scopeClass = Html_Scope.new(@html)

                  # source - description
                  unless hSource[:description].nil?
                     @html.em('Description: ')
                     @html.section(:class => 'block') do
                        @html.text!(hSource[:description])
                     end
                  end

                  # source - citation {citation}
                  unless hSource[:sourceCitation].empty?
                     @html.details do
                        @html.summary('Source Citation', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           citationClass.writeHtml(hSource[:sourceCitation])
                        end
                     end
                  end

                  # source - metadata citation [] {citation}
                  unless hSource[:metadataCitation].empty?
                     @html.details do
                        @html.summary('Metadata Citations', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           hSource[:metadataCitation].each do |hCitation|
                              @html.details do
                                 @html.summary(hCitation[:title], {'class' => 'h5'})
                                 @html.section(:class => 'block') do
                                    citationClass.writeHtml(hCitation)
                                 end
                              end
                           end
                        end
                     end
                  end

                  # source - spatial resolution {resolution}
                  unless hSource[:spatialResolution].empty?
                     @html.details do
                        @html.summary('Resolution', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           resolutionClass.writeHtml(hSource[:spatialResolution])
                        end
                     end
                  end

                  # source - reference system {spatialReference}
                  unless hSource[:referenceSystem].empty?
                     @html.details do
                        @html.summary('Spatial Reference System', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           referenceClass.writeHtml(hSource[:referenceSystem])
                        end
                     end
                  end

                  # source - process steps [] {processStep}
                  unless hSource[:sourceSteps].empty?
                     @html.details do
                        @html.summary('Source Processing Steps', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           hSource[:sourceSteps].each do |hStep|
                              @html.details do
                                 @html.summary('Process Step', {'class' => 'h5'})
                                 @html.section(:class => 'block') do
                                    stepClass.writeHtml(hStep)
                                 end
                              end
                           end
                        end
                     end
                  end

                  # source - scope {scope}
                  unless hSource[:scope].empty?
                     @html.details do
                        @html.summary('Scope', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           scopeClass.writeHtml(hSource[:scope])
                        end
                     end
                  end

               end # writeHtml
            end # Html_Source

         end
      end
   end
end
