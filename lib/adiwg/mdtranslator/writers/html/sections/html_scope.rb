# HTML writer
# scope

# History:
#  Stan Smith 2017-03-25 original script

require_relative 'html_scopeDescription'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_Scope

               def initialize(html)
                  @html = html
               end

               def writeHtml(hScope)

                  # classes used
                  descriptionClass = Html_ScopeDescription.new(@html)

                  # scope - code
                  unless hScope[:scopeCode].nil?
                     @html.em('Scope Code: ')
                     @html.text!(hScope[:scopeCode])
                     @html.br
                  end

                  # scope - description [] {scopeDescription}
                  hScope[:scopeDescriptions].each do |hDescription|
                     @html.details do
                        @html.summary('Description', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           descriptionClass.writeHtml(hDescription)
                        end
                     end
                  end

                  # scope - extents []
                  hScope[:extents].each do |hExtent|
                     # TODO scope extent
                  end

               end # writeHtml
            end # Html_Scope

         end
      end
   end
end
