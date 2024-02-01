# HTML writer
# processing

# History:
#  Stan Smith 2019-09-24 original script

require_relative 'html_identifier'
require_relative 'html_citation'
require_relative 'html_algorithm'

module ADIWG
   module Mdtranslator
      module Writers
         module Simple_html

            class Html_Processing

               def initialize(html)
                  @html = html
               end

               def writeHtml(hProcessing)

                  # classes used
                  identifierClass = Html_Identifier.new(@html)
                  citationClass = Html_Citation.new(@html)
                  algorithmClass = Html_Algorithm.new(@html)

                  # processing - procedure description
                  unless hProcessing[:procedureDescription].nil?
                     @html.em(' Procedure Description: ')
                     @html.text!(hProcessing[:procedureDescription])
                     @html.br
                  end

                  # processing - identifier {identifier}
                  unless hProcessing[:identifier].empty?
                     @html.div do
                        @html.h5('Identifier', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           identifierClass.writeHtml(hProcessing[:identifier])
                        end
                     end
                  end

                  # processing - software reference {citation}
                  unless hProcessing[:softwareReference].empty?
                     @html.div do
                        @html.div('Software Reference', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           citationClass.writeHtml(hProcessing[:softwareReference])
                        end
                     end
                  end

                  # processing - runtime parameters
                  unless hProcessing[:runtimeParameters].nil?
                     @html.em(' Runtime Parameters: ')
                     @html.text!(hProcessing[:runtimeParameters])
                     @html.br
                  end

                  # processing - documentation [] {citation}
                  hProcessing[:documentation].each do |hCitation|
                     @html.div do
                        @html.h5('Documentation', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           citationClass.writeHtml(hCitation)
                        end
                     end
                  end

                  # processing - algorithm [] {algorithm}
                  hProcessing[:algorithms].each do |hAlgorithm|
                     @html.div do
                        @html.h5('Algorithm', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           algorithmClass.writeHtml(hAlgorithm)
                        end
                     end
                  end

               end # writeHtml
            end # Html_Processing

         end
      end
   end
end
