# HTML writer
# process step

# History:
#  Stan Smith 2019-09-24 add support for LE_ProcessStep
#  Stan Smith 2017-08-30 add support for process step sources
#  Stan Smith 2017-04-03 refactor for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactor to remove global namespace $HtmlNS
# 	Stan Smith 2015-03-27 original script

require_relative 'html_temporalExtent'
require_relative 'html_responsibility'
require_relative 'html_citation'
require_relative 'html_scope'
require_relative 'html_source'
require_relative 'html_processing'
require_relative 'html_processReport'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_ProcessStep

               def initialize(html)
                  @html = html
               end

               def writeHtml(hStep)

                  # classes used
                  temporalClass = Html_TimePeriod.new(@html)
                  responsibilityClass = Html_Responsibility.new(@html)
                  citationClass = Html_Citation.new(@html)
                  scopeClass = Html_Scope.new(@html)
                  sourceClass = Html_Source.new(@html)
                  processingClass = Html_Processing.new(@html)
                  reportClass = Html_ProcessStepReport.new(@html)

                  # process step - id
                  unless hStep[:stepId].nil?
                     @html.em('Step ID: ')
                     @html.text!(hStep[:stepId])
                     @html.br
                  end

                  # process step - description
                  unless hStep[:description].nil?
                     @html.em('Description: ')
                     @html.section(:class => 'block') do
                        @html.text!(hStep[:description])
                     end
                  end

                  # process step - step rationale
                  unless hStep[:rationale].nil?
                     @html.em('Rationale: ')
                     @html.section(:class => 'block') do
                        @html.text!(hStep[:rationale])
                     end
                  end

                  # process step - time period {timePeriod}
                  unless hStep[:timePeriod].empty?
                     @html.details do
                        @html.summary('Time Period', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           temporalClass.writeHtml(hStep[:timePeriod])
                        end
                     end
                  end

                  # process step - references [] {citation}
                  unless hStep[:references].empty?
                     @html.details do
                        @html.summary('Step References', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           hStep[:references].each do |hCitation|
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

                  # process step - step sources [] {source}
                  unless hStep[:stepSources].empty?
                     @html.details do
                        @html.summary('Step Source Datasets', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           hStep[:stepSources].each do |hSource|
                              @html.details do
                                 @html.summary('Data Source', {'class' => 'h5'})
                                 @html.section(:class => 'block') do
                                    sourceClass.writeHtml(hSource)
                                 end
                              end
                           end
                        end
                     end
                  end

                  # process step - step products [] {source}
                  unless hStep[:stepProducts].empty?
                     @html.details do
                        @html.summary('Step Product Datasets', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           hStep[:stepProducts].each do |hSource|
                              @html.details do
                                 @html.summary('Data Product', {'class' => 'h5'})
                                 @html.section(:class => 'block') do
                                    sourceClass.writeHtml(hSource)
                                 end
                              end
                           end
                        end
                     end
                  end

                  # process step - processors [] {responsibility}
                  hStep[:processors].each do |hResponsibility|
                     @html.details do
                        @html.summary(hResponsibility[:roleName], {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           responsibilityClass.writeHtml(hResponsibility)
                        end
                     end
                  end

                  # process step - scope {scope}
                  unless hStep[:scope].empty?
                     @html.details do
                        @html.summary('Scope', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           scopeClass.writeHtml(hStep[:scope])
                        end
                     end
                  end

                  # process step - processing information {processingInformation}
                  unless hStep[:processingInformation].empty?
                     @html.details do
                        @html.summary('Processing Information', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           processingClass.writeHtml(hStep[:processingInformation])
                        end
                     end
                  end

                  # process step - report [] {processStepReport}
                  hStep[:reports].each do |hReport|
                     @html.details do
                        @html.summary(hReport[:name], {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           reportClass.writeHtml(hReport)
                        end
                     end
                  end

               end # writeHtml
            end # Html_ProcessStep

         end
      end
   end
end
