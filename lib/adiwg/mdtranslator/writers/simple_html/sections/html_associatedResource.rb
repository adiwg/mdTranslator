# HTML writer
# associated resource

# History:
#  Stan Smith 2017-04-04 refactored for mdTranslator 2.0
# 	Stan Smith 2015-08-21 original script

require_relative 'html_resourceType'
require_relative 'html_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_AssociatedResource

               def initialize(html)
                  @html = html
               end

               def writeHtml(hResource)

                  # classes used
                  typeClass = Html_ResourceType.new(@html)
                  citationClass = Html_Citation.new(@html)

                  # associated resource - resource type
                  hResource[:resourceTypes].each do |hType|
                     typeClass.writeHtml(hType)
                  end

                  # associated resource - association type {associationTypeCode}
                  unless hResource[:associationType].nil?
                     @html.em('Association type: ')
                     @html.text!(hResource[:associationType])
                     @html.br
                  end

                  # associated resource - initiative type {initiativeTypeCode}
                  unless hResource[:initiativeType].nil?
                     @html.em('Initiative type: ')
                     @html.text!(hResource[:initiativeType])
                     @html.br
                  end

                  # associated resource - resource citation {citation}
                  unless hResource[:resourceCitation].empty?
                     @html.details do
                        @html.summary('Resource citation', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           citationClass.writeHtml(hResource[:resourceCitation])
                        end
                     end
                  end

                  # associated resource - metadata citation
                  unless hResource[:metadataCitation].empty?
                     @html.details do
                        @html.summary('Metadata citation', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           citationClass.writeHtml(hResource[:metadataCitation])
                        end
                     end
                  end

               end # writeHtml
            end # Html_AssociatedResource

         end
      end
   end
end
