# HTML writer
# taxonomic classification

# History:
#  Stan Smith 2017-03-30 refactored for mdTranslator
# 	Stan Smith 2015-03-25 original script

require_relative 'html_taxonomyClass'

module ADIWG
   module Mdtranslator
      module Writers
         module Simple_html

            class Html_TaxonomyClass

               def initialize(html)
                  @html = html
               end

               def writeHtml(hTaxon)

                  # classes used
                  subClass = Html_TaxonomyClass.new(@html)

                  # taxonomic classification - id
                  unless hTaxon[:taxonId].nil?
                     @html.em('Taxonomic ID: ')
                     @html.text!(hTaxon[:taxonId])
                     @html.br
                  end

                  # taxonomic classification - level
                  unless hTaxon[:taxonRank].nil?
                     @html.em('Taxonomic Level: ')
                     @html.text!(hTaxon[:taxonRank])
                     @html.br
                  end

                  # taxonomic classification - name
                  unless hTaxon[:taxonValue].nil?
                     @html.em('Taxonomic Name: ')
                     @html.text!(hTaxon[:taxonValue])
                     @html.br
                  end

                  # taxonomic classification - common names []
                  unless hTaxon[:commonNames].empty?
                     @html.em('Common Names:')
                     @html.ul do
                        hTaxon[:commonNames].each do |common|
                           @html.li(common)
                        end
                     end
                  end

                  # taxonomic classification - sub-classification
                  unless hTaxon[:subClasses].empty?
                     hTaxon[:subClasses].each do |hSubClass|
                        @html.div do
                           @html.div('Sub-Classification', {'class' => 'h5'})
                           @html.div(:class => 'block') do
                              subClass.writeHtml(hSubClass)
                           end
                        end
                     end
                  end

               end # writeHtml
            end # Html_TaxonomyClass

         end
      end
   end
end
