# HTML writer
# maintenance

# History:
#  Stan Smith 2017-03-25 refactored for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
# 	Stan Smith 2015-03-24 original script

require_relative 'html_date'
require_relative 'html_scope'
require_relative 'html_responsibility'

module ADIWG
   module Mdtranslator
      module Writers
         module Simple_html

            class Html_Maintenance

               def initialize(html)
                  @html = html
               end

               def writeHtml(hMaint)

                  # classes used
                  dateClass = Html_Date.new(@html)
                  scopeClass = Html_Scope.new(@html)
                  responsibilityClass = Html_Responsibility.new(@html)

                  @html.div(:class => 'block') do

                     # maintenance - frequency
                     unless hMaint[:frequency].nil?
                        @html.em('Frequency: ')
                        @html.text!(hMaint[:frequency])
                        @html.br
                     end

                     # maintenance - dates []
                     hMaint[:dates].each do |hDate|
                        @html.em('Date: ')
                        dateClass.writeHtml(hDate)
                        @html.br
                     end

                     # maintenance - scopes [] {scope}
                     unless hMaint[:scopes].empty?
                        @html.div do
                           @html.div('Maintenance Scopes', {'class' => 'h5'})
                           @html.div(:class => 'block') do
                              hMaint[:scopes].each do |hScope|
                                 @html.div do
                                    @html.div(hScope[:scopeCode], 'class' => 'h5')
                                    @html.div(:class => 'block') do
                                       scopeClass.writeHtml(hScope)
                                    end
                                 end
                              end
                           end
                        end
                     end

                     # maintenance - contacts [] {responsibility}
                     unless hMaint[:contacts].empty?
                        @html.div do
                           @html.div('Maintenance Contacts', {'class' => 'h5'})
                           @html.div(:class => 'block') do
                              hMaint[:contacts].each do |hContact|
                                 @html.div do
                                    @html.div(hContact[:roleName], 'class' => 'h5')
                                    @html.div(:class => 'block') do
                                       responsibilityClass.writeHtml(hContact)
                                    end
                                 end
                              end
                           end
                        end
                     end

                     # maintenance - notes []
                     hMaint[:notes].each do |note|
                        @html.em('Note: ')
                        @html.text!(note)
                        @html.br
                     end

                  end

               end # writeHtml
            end # Html_Maintenance

         end
      end
   end
end
