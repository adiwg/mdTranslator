# HTML writer
# taxonomy

# History:
#  Stan Smith 2018-10-19 refactored for mdJson schema 2.6.0
#  Stan Smith 2017-03-30 refactored for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
# 	Stan Smith 2015-03-25 original script

require_relative 'html_citation'
require_relative 'html_responsibility'
require_relative 'html_taxonomyClass'

module ADIWG
   module Mdtranslator
      module Writers
         module Simple_html

            class Html_Taxonomy

               def initialize(html)
                  @html = html
               end

               def writeHtml(hTaxonomy)

                  # classes used
                  citationClass = Html_Citation.new(@html)
                  responsibilityClass = Html_Responsibility.new(@html)
                  taxonomicClass = Html_TaxonomyClass.new(@html)

                  # taxonomy - taxonomic general scope
                  unless hTaxonomy[:generalScope].nil?
                     @html.em('General scope: ')
                     @html.div(:class => 'block') do
                        @html.text!(hTaxonomy[:generalScope])
                     end
                  end

                  # taxonomy - identification procedures
                  unless hTaxonomy[:idProcedure].nil?
                     @html.em('Identification Procedures: ')
                     @html.div(:class => 'block') do
                        @html.text!(hTaxonomy[:idProcedure])
                     end
                  end

                  # taxonomy - completeness
                  unless hTaxonomy[:idCompleteness].nil?
                     @html.em('Identification Completeness Statement: ')
                     @html.div(:class => 'block') do
                        @html.text!(hTaxonomy[:idCompleteness])
                     end
                  end

                  # taxonomy - taxonomic classification []
                  hTaxonomy[:taxonClasses].each do |hClassification|
                     @html.div do
                        @html.div('Taxonomic Classification', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           taxonomicClass.writeHtml(hClassification)
                        end
                     end
                  end

                  # taxonomy - taxonomic classification system [] {citation}
                  hTaxonomy[:taxonSystem].each do |hSystem|
                     @html.div do
                        @html.div('Classification System', {'class' => 'h5'})
                        @html.div(:class => 'block') do

                           # classification system citation
                           @html.div do
                              @html.div(hSystem[:citation][:title], {'class' => 'h5'})
                              @html.div(:class => 'block') do
                                 citationClass.writeHtml(hSystem[:citation])
                              end
                           end

                           # modifications
                           unless hSystem[:modifications].nil?
                              @html.em('Modifications to Classification System:')
                              @html.div(:class => 'block') do
                                 @html.text!(hSystem[:modifications])
                              end
                           end

                        end
                     end
                  end

                  # taxonomy - identification references
                  hTaxonomy[:idReferences].each do |hReference|
                     @html.div do
                        @html.div('Non-Authoritative Identification Reference', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           citationClass.writeHtml(hReference)
                        end
                     end
                  end

                  # taxonomy - observers {responsibility}
                  unless hTaxonomy[:observers].empty?
                     @html.div do
                        @html.div('Observers', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           hTaxonomy[:observers].each do |hObserver|
                              @html.div do
                                 @html.div(hObserver[:roleName], 'class' => 'h5')
                                 @html.div(:class => 'block') do
                                    responsibilityClass.writeHtml(hObserver)
                                 end
                              end
                           end
                        end
                     end
                  end

                  # taxonomy - voucher []
                  unless hTaxonomy[:observers].empty?
                     @html.div do
                        @html.div('Specimen Repositories', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           hTaxonomy[:vouchers].each do |hVoucher|

                              # voucher - specimen
                              unless hVoucher[:specimen].nil?
                                 @html.em('Specimen: ')
                                 @html.text!(hVoucher[:specimen])
                                 @html.br
                              end

                              # voucher - repository {responsibility}
                              unless hVoucher[:repository].empty?
                                 @html.div(:class => 'block') do
                                    @html.div do
                                       @html.div(hVoucher[:repository][:roleName], {'class' => 'h5'})
                                       @html.div(:class => 'block') do
                                          responsibilityClass.writeHtml(hVoucher[:repository])
                                       end
                                    end
                                 end
                              end

                           end
                        end
                     end
                  end

               end # writeHtml
            end # Html_Taxonomy

         end
      end
   end
end
