# HTML writer
# scope description

# History:
#  Stan Smith 2017-04-05 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Simple_html

            class Html_ScopeDescription

               def initialize(html)
                  @html = html
               end

               def writeHtml(hDescription)

                  # scope description - dataset
                  unless hDescription[:dataset].nil?
                     @html.em('Dataset(s) to which Scope applies: ')
                     @html.text!(hDescription[:dataset])
                     @html.br
                  end

                  # scope description - attributes
                  unless hDescription[:attributes].nil?
                     @html.em('Attributes(s) to which Scope applies: ')
                     @html.text!(hDescription[:attributes])
                     @html.br
                  end

                  # scope description - features
                  unless hDescription[:features].nil?
                     @html.em('Features(s) to which Scope applies: ')
                     @html.text!(hDescription[:features])
                     @html.br
                  end

                  # scope description - other
                  unless hDescription[:other].nil?
                     @html.em('Other item(s) to which Scope applies: ')
                     @html.text!(hDescription[:other])
                     @html.br
                  end

               end # writeHtml
            end # Html_ScopeDescription

         end
      end
   end
end
