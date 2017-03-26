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
         module Html

            class Html_Maintenance

               def initialize(html)
                  @html = html
               end

               def writeHtml(hMaint)

                  # classes used
                  dateClass = Html_Date.new(@html)
                  scopeClass = Html_Scope.new(@html)
                  responsibilityClass = Html_Responsibility.new(@html)

                  @html.section(:class => 'block') do

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
                     hMaint[:scopes].each do |hScope|
                        @html.details do
                           @html.summary(hScope[:scopeCode], 'class' => 'h5')
                           @html.section(:class => 'block') do
                              scopeClass.writeHtml(hScope)
                           end
                        end
                     end

                     # maintenance - notes []
                     hMaint[:notes].each do |note|
                        @html.em('Note: ')
                        @html.text!(note)
                        @html.br
                     end

                     # maintenance - contacts [] {responsibility}
                     hMaint[:contacts].each do |hResponsibility|
                        @html.details do
                           @html.summary(hResponsibility[:roleName], 'class' => 'h5')
                           @html.section(:class => 'block') do
                              responsibilityClass.writeHtml(hResponsibility)
                           end
                        end
                     end

                  end

               end # writeHtml
            end # Html_Maintenance

         end
      end
   end
end
