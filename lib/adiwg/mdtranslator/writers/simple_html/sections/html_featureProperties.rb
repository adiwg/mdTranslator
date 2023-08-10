# HTML writer
# feature properties

# History:
#  Stan Smith 2017-04-08 original script

require_relative 'html_identifier'

module ADIWG
   module Mdtranslator
      module Writers
         module Simple_html

            class Html_FeatureProperty

               def initialize(html)
                  @html = html
               end

               def writeHtml(hProperty)

                  # classes used
                  identifierClass = Html_Identifier.new(@html)

                  # feature properties - name []
                  hProperty[:featureNames].each do |feature|
                     @html.em('Feature Name: ')
                     @html.text!(feature)
                     @html.br
                  end

                  # feature properties - description
                  unless hProperty[:description].nil?
                     @html.em('Description: ')
                     @html.div(:class => 'block') do
                        @html.text!(hProperty[:description])
                     end
                  end

                  # feature properties - identifier [] {identifier}
                  hProperty[:identifiers].each do |hIdentifier|
                     @html.div do
                        @html.div('Identifier', 'class' => 'h5')
                        @html.div(:class => 'block') do
                           identifierClass.writeHtml(hIdentifier)
                        end
                     end
                  end

                  # feature properties - feature scope {scopeCode}
                  unless hProperty[:featureScope].nil?
                     @html.em('Feature Scope Code: ')
                     @html.text!(hProperty[:featureScope])
                     @html.br
                  end

                  # feature properties - acquisition method
                  unless hProperty[:featureScope].nil?
                     @html.em('Acquisition Method: ')
                     @html.div(:class => 'block') do
                        @html.text!(hProperty[:acquisitionMethod])
                     end
                  end

               end # writeHtml
            end # Html_FeatureProperty

         end
      end
   end
end
