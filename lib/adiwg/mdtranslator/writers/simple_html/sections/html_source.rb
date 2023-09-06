# HTML writer
# source

# History:
#  Stan Smith 2019-09-24 add support for LE_Source
#  Stan Smith 2017-04-03 refactored for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
# 	Stan Smith 2015-03-27 original script

require_relative 'html_citation'
require_relative 'html_spatialResolution'
require_relative 'html_spatialReference'
require_relative 'html_processStep'
require_relative 'html_scope'
require_relative 'html_identifier'
require_relative 'html_nominalResolution'

module ADIWG
   module Mdtranslator
      module Writers
         module Simple_html

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
                  identifierClass = Html_Identifier.new(@html)
                  nominalClass = Html_NominalResolution.new(@html)

                  # source - source ID
                  unless hSource[:sourceId].nil?
                     @html.em('Source ID: ')
                     @html.text!(hSource[:sourceId])
                     @html.br
                  end

                  # source - description
                  unless hSource[:description].nil?
                     @html.em('Description: ')
                     @html.div(:class => 'block') do
                        @html.text!(hSource[:description])
                     end
                  end

                  # source - citation {citation}
                  unless hSource[:sourceCitation].empty?
                     @html.div do
                        @html.div('Source Citation', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           citationClass.writeHtml(hSource[:sourceCitation])
                        end
                     end
                  end

                  # source - metadata citation [] {citation}
                  unless hSource[:metadataCitations].empty?
                     @html.div do
                        @html.div('Metadata Citations', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           hSource[:metadataCitations].each do |hCitation|
                              @html.div do
                                 @html.div(hCitation[:title], {'class' => 'h5'})
                                 @html.div(:class => 'block') do
                                    citationClass.writeHtml(hCitation)
                                 end
                              end
                           end
                        end
                     end
                  end

                  # source - spatial resolution {resolution}
                  unless hSource[:spatialResolution].empty?
                     @html.div do
                        @html.div('Resolution', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           resolutionClass.writeHtml(hSource[:spatialResolution])
                        end
                     end
                  end

                  # source - reference system {spatialReference}
                  unless hSource[:referenceSystem].empty?
                     @html.div do
                        @html.div('Spatial Reference System', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           referenceClass.writeHtml(hSource[:referenceSystem])
                        end
                     end
                  end

                  # source - process steps [] {processStep}
                  unless hSource[:sourceSteps].empty?
                     @html.div do
                        @html.div('Source Processing Steps', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           hSource[:sourceSteps].each do |hStep|
                              @html.div do
                                 @html.div('Process Step', {'class' => 'h5'})
                                 @html.div(:class => 'block') do
                                    stepClass.writeHtml(hStep)
                                 end
                              end
                           end
                        end
                     end
                  end

                  # source - scope {scope}
                  unless hSource[:scope].empty?
                     @html.div do
                        @html.div('Scope', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           scopeClass.writeHtml(hSource[:scope])
                        end
                     end
                  end

                  # source - processed level {identifier}
                  unless hSource[:processedLevel].empty?
                     @html.div do
                        @html.div('Processed Level', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           identifierClass.writeHtml(hSource[:processedLevel])
                        end
                     end
                  end

                  # source - resolution {nominal resolution}
                  unless hSource[:resolution].empty?
                     @html.div do
                        @html.div('Nominal Resolution', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           nominalClass.writeHtml(hSource[:resolution])
                        end
                     end
                  end

               end # writeHtml
            end # Html_Source

         end
      end
   end
end
