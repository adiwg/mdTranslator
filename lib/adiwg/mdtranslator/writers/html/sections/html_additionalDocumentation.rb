# HTML writer
# additional documentation

# History:
#  Stan Smith 2017-04-04 refactored for mdTranslator 2.0
# 	Stan Smith 2015-08-21 original script

require_relative 'html_resourceType'
require_relative 'html_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_AdditionalDocumentation

               def initialize(html)
                  @html = html
               end

               def writeHtml(hAddDoc)

                  # classes used
                  typeClass = Html_ResourceType.new(@html)
                  citationClass = Html_Citation.new(@html)

                  # additional documentation - resource type [] {resourceType}
                  hAddDoc[:resourceTypes].each do |hType|
                     typeClass.writeHtml(hType)
                  end

                  # additional documentation - citation [] {citation}
                  hAddDoc[:citation].each do |hCitation|
                     @html.details do
                        @html.summary(hCitation[:title], {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           citationClass.writeHtml(hCitation)
                        end
                     end
                  end

               end # writeHtml
            end # Html_AdditionalDocumentation

         end
      end
   end
end
