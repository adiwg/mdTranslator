# HTML writer
# process step

# History:
#  Stan Smith 2017-04-03 refactored for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
# 	Stan Smith 2015-03-27 original script

require_relative 'html_temporalExtent'
require_relative 'html_responsibility'
require_relative 'html_citation'
require_relative 'html_scope'

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
                  temporalClass = Html_TemporalExtent.new(@html)
                  responsibilityClass = Html_Responsibility.new(@html)
                  citationClass = Html_Citation.new(@html)
                  scopeClass = Html_Scope.new(@html)

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
                     temporalObj = {}
                     temporalObj[:timeInstant] = {}
                     temporalObj[:timePeriod] = hStep[:timePeriod]
                     temporalClass.writeHtml(temporalObj)
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

               end # writeHtml
            end # Html_ProcessStep

         end
      end
   end
end
