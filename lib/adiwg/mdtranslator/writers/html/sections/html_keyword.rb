# HTML writer
# keywords

# History:
#  Stan Smith 2017-03-29 refactored for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
# 	Stan Smith 2015-03-23 original script

require_relative 'html_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_Keyword

               def initialize(html)
                  @html = html
               end

               def writeHtml(hKeyword)

                  # classes used
                  citationClass = Html_Citation.new(@html)

                  # keywords - type
                  @html.details do
                     type = hKeyword[:keywordType]
                     if type.nil?
                        type = 'Unclassified'
                     end
                     @html.summary(type, {'class' => 'h5'})
                     @html.section(:class => 'block') do

                        # keywords
                        @html.ul do
                           hKeyword[:keywords].each do |hKeyword|
                              @html.li(hKeyword[:keyword])
                           end
                        end

                        # thesaurus
                        unless hKeyword[:thesaurus].empty?
                           @html.details do
                              @html.summary('Thesaurus', {'class' => 'h5'})
                              @html.section(:class => 'block') do
                                 citationClass.writeHtml(hKeyword[:thesaurus])
                              end
                           end
                        end

                     end
                  end

               end # writeHtml
            end # Html_Keyword

         end
      end
   end
end
