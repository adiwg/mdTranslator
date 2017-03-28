# HTML writer
# usage

# History:
#  Stan Smith 2017-03-25 refactored for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
# 	Stan Smith 2015-03-25 original script

require_relative 'html_temporalExtent'
require_relative 'html_citation'
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
                  temporalClass = Html_TemporalExtent.new(@html)
                  citationClass = Html_Citation.new(@html)
                  responsibilityClass = Html_Responsibility.new(@html)

                  # resource usage - use
                  @html.em('Usage: ')
                  @html.br
                  @html.text!(hUsage[:specificUsage])
                  @html.br

                  # resource usage - temporal extent
                  unless hUsage[:temporalExtents].empty?
                     @html.details do
                        @html.summary('Times and Periods of Usage', 'class' => 'h5')
                        @html.section(:class => 'block') do
                           hUsage[:temporalExtents].each do |hTemporal|
                              temporalClass.writeHtml(hTemporal)
                           end
                        end
                     end
                  end

                  # resource usage - limitation
                  unless hUsage[:userLimitation].nil? && hUsage[:limitationResponses].empty?
                     @html.details do
                        @html.summary('User Defined Limitations', 'class' => 'h5')
                        @html.section(:class => 'block') do

                           # user limitation
                           unless hUsage[:userLimitation].nil?
                              @html.em('Description')
                              @html.section(:class => 'block') do
                                 @html.text!(hUsage[:userLimitation])
                              end
                           end

                           # limitation responses []
                           hUsage[:limitationResponses].each do |response|
                              @html.em('Response')
                              @html.section(:class => 'block') do
                                 @html.text!(response)
                              end
                           end

                        end
                     end
                  end

                  # resource usage - documented issue
                  unless hUsage[:identifiedIssue].empty?
                     @html.details do
                        @html.summary('Cited Issue', 'class' => 'h5')
                        @html.section(:class => 'block') do
                           citationClass.writeHtml(hUsage[:identifiedIssue])
                        end
                     end
                  end

                  # resource usage - additional documentation
                  hUsage[:additionalDocumentation].each do |hCitation|
                     @html.details do
                        @html.summary('Additional Documentation', 'class' => 'h5')
                        @html.section(:class => 'block') do
                           citationClass.writeHtml(hCitation)
                        end
                     end
                  end

                  # resource usage - user contacts
                  unless hUsage[:userContacts].empty?
                     @html.details do
                        @html.summary('Usage and Limitation Contacts', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           hUsage[:userContacts].each do |hContact|
                              @html.details do
                                 @html.summary(hContact[:roleName], 'class' => 'h5')
                                 @html.section(:class => 'block') do
                                    responsibilityClass.writeHtml(hContact)
                                 end
                              end
                           end
                        end
                     end
                  end

               end # writeHtml
            end # Html_Usage

         end
      end
   end
end
