# HTML writer
# usage

# History:
#  Stan Smith 2017-03-25 refactored for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
# 	Stan Smith 2015-03-25 original script

require_relative 'html_citation'
require_relative 'html_temporalExtent'
require_relative 'html_responsibility'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_Usage

               def initialize(html)
                  @html = html
               end

               def writeHtml(hUsage)

                  # classes used
                  responsibilityClass = Html_Responsibility.new(@html)
                  temporalClass = Html_TemporalExtent.new(@html)

                  # resource usage - use
                  @html.em('Usage: ')
                  @html.br
                  @html.text!(hUsage[:specificUsage])
                  @html.br

                  # resource usage - temporal extent
                  unless hUsage[:temporalExtents].empty?
                     @html.details do
                        @html.summary('Times and Periods of Usage: ', 'class' => 'h5')
                        @html.section(:class => 'block') do
                           hUsage[:temporalExtents].each do |hTemporal|
                              temporalClass.writeHtml(hTemporal)
                           end
                        end
                     end
                  end

                  # TODO add user determined limitation
                  # TODO add limitation response []

                  # TODO add documented issue

                  # TODO add additional documentation

                  # TODO add user contact info

               end # writeHtml
            end # Html_Usage

         end
      end
   end
end
