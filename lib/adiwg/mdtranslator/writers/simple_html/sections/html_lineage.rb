# HTML writer
# lineage

# History:
#  Stan Smith 2017-04-03 refactored for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
# 	Stan Smith 2015-03-27 original script

require_relative 'html_scope'
require_relative 'html_citation'
require_relative 'html_processStep'
require_relative 'html_source'

module ADIWG
   module Mdtranslator
      module Writers
         module SimpleHtml

            class Html_Lineage

               def initialize(html)
                  @html = html
               end

               def writeHtml(hLineage)

                  # classes used
                  scopeClass = Html_Scope.new(@html)
                  citationClass = Html_Citation.new(@html)
                  stepClass = Html_ProcessStep.new(@html)
                  sourceClass = Html_Source.new(@html)

                  # lineage - statement
                  unless hLineage[:statement].nil?
                     @html.em('Statement: ')
                     @html.div(:class => 'block') do
                        @html.text!(hLineage[:statement])
                     end
                  end

                  # lineage - scope
                  unless hLineage[:resourceScope].empty?
                     @html.div do
                        @html.div('Scope', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           scopeClass.writeHtml(hLineage[:resourceScope])
                        end
                     end
                  end

                  # lineage - citation
                  hLineage[:lineageCitation].each do |hCitation|
                     @html.div do
                        @html.div('Citation', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           citationClass.writeHtml(hCitation)
                        end
                     end
                  end

                  # lineage - data sources
                  hLineage[:dataSources].each do |hsource|
                     @html.div do
                        @html.div('Data Source', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           sourceClass.writeHtml(hsource)
                        end
                     end
                  end

                  # lineage - process steps
                  hLineage[:processSteps].each do |hStep|
                     @html.div do
                        @html.div('Process Step', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           stepClass.writeHtml(hStep)
                        end
                     end
                  end

               end # writeHtml
            end # Html_Lineage

         end
      end
   end
end
