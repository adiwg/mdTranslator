# HTML writer
# source

# History:
#  Stan Smith 2017-04-03 refactored for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
# 	Stan Smith 2015-03-27 original script

require_relative 'html_citation'
require_relative 'html_processStep'

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
                  stepClass = Html_ProcessStep.new(@html)

                  @html.em('Nothing yet')

                  # # data source - description
                  # s = hSource[:sourceDescription]
                  # if !s.nil?
                  #    @html.em('Description: ')
                  #    @html.section(:class => 'block') do
                  #       @html.text!(s)
                  #    end
                  # end
                  #
                  # # data source - citation
                  # hCitation = hSource[:sourceCitation]
                  # if !hCitation.empty?
                  #    @html.em('Citation: ')
                  #    @html.section(:class => 'block') do
                  #       citationClass.writeHtml(hCitation)
                  #    end
                  # end
                  #
                  # # data source - source steps
                  # aSteps = hSource[:sourceSteps]
                  # if !aSteps.empty?
                  #    @html.em('Process steps: ')
                  #    @html.section(:class => 'block') do
                  #       @html.ol do
                  #          aSteps.each do |hStep|
                  #             @html.li do
                  #                stepClass.writeHtml(hStep)
                  #             end
                  #          end
                  #       end
                  #    end
                  # end

               end # writeHtml
            end # Html_Source

         end
      end
   end
end
