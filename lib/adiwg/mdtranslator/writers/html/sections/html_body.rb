# HTML writer
# html body

# History:
#  Stan Smith 2017-03-22 refactor for mdTranslator 2.0
#  Stan Smith 2015-07-20 moved mdTranslator logo to html_inlineCss.css
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
#  Stan Smith 2014-04-10 add open and close buttons
#  Stan Smith 2015-03-23 original script

require_relative 'html_contact'
require_relative 'html_metadataInfo'
require_relative 'html_resourceInfo'
require_relative 'html_lineage'
require_relative 'html_distribution'
require_relative 'html_associatedResource'
require_relative 'html_additionalDocumentation'
require_relative 'html_funding'

# require_relative 'html_dataDictionary'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_Body

               def initialize(html)
                  @html = html
               end

               def writeHtml(version,intObj)
                  @html.body do

                     # classes used
                     metaInfoClass = Html_MetadataInfo.new(@html)
                     contactClass = Html_Contact.new(@html)
                     resourceClass = Html_ResourceInfo.new(@html)
                     lineageClass = Html_Lineage.new(@html)
                     distributionClass = Html_Distribution.new(@html)
                     associatedClass = Html_AssociatedResource.new(@html)
                     additionalClass = Html_AdditionalDocumentation.new(@html)
                     fundingClass = Html_Funding.new(@html)

                     # htmlDataD = MdHtmlDataDictionary.new(@html)

                     # make sections of the internal data store convenient
                     hSchema = intObj[:schema]
                     aContacts = intObj[:contacts]
                     hMetaInfo = intObj[:metadata][:metadataInfo]
                     hResourceInfo = intObj[:metadata][:resourceInfo]
                     aLineage = intObj[:metadata][:lineageInfo]
                     aDistribution = intObj[:metadata][:distributorInfo]
                     aAssociated = intObj[:metadata][:associatedResources]
                     aAdditional = intObj[:metadata][:additionalDocuments]
                     aFunding = intObj[:metadata][:funding]

                     # aDataDict = intObj[:dataDictionary]

                     # set page title and logo
                     # side navigation
                     @html.div('id' => 'sideNav') do
                        # add top anchor and button
                        @html.a(' Top', {'href' => '#', 'class' => 'btn icon-caret-up'})

                        # add open and close buttons
                        @html.span(' Open', {'id' => 'openAllDetails', 'class' => 'btn icon-caret-down', 'onclick' => 'openAllDetails();'})
                        @html.span(' Close', {'class' => 'btn icon-caret-right', 'onclick' => 'closeAllDetails();'})
                     end

                     # main header
                     @html.h2('id' => 'mainHeader') do
                        # added blank to span tag to force builder to create closing tag
                        @html.span('', 'id' => 'logo')
                        @html.span('Metadata Record')
                        @html.span('HTML5', 'class' => 'version')
                     end

                     # report title
                     aShortVersion = version.split('.')
                     shortVersion = aShortVersion[0].to_s + '.' + aShortVersion[1].to_s
                     @html.h1('mdTranslator ' + shortVersion + ' HTML Metadata Record', 'id' => 'mdtranslator-metadata-report')

                     # metadata source
                     @html.h2('Metadata Source', 'id' => 'metadataSource')
                     @html.section(:class => 'block') do
                        @html.em('Metadata schema:')
                        @html.text!(hSchema[:name])
                        @html.br

                        @html.em('Schema version:')
                        @html.text!(hSchema[:version])
                     end
                     @html.hr

                     # contacts [] section
                     unless aContacts.empty?
                        @html.details do
                           @html.summary('Contacts', {'id' => 'body-contacts', 'class' => 'h2'})
                           @html.section(:class => 'block') do
                              aContacts.each do |hContact|
                                 @html.section(:class => 'block') do
                                    contactClass.writeHtml(hContact)
                                 end
                              end
                              @html.hr
                           end
                        end
                     end

                     # metadata information section
                     unless hMetaInfo.empty?
                        @html.details do
                        @html.summary('Metadata Information', {'id' => 'body-metadataInfo', 'class' => 'h2'})
                        @html.section(:class => 'block') do
                              @html.section(:class => 'block') do
                                 metaInfoClass.writeHtml(hMetaInfo)
                              end
                           end
                           @html.hr
                        end
                     end

                     # resource information section
                     unless hResourceInfo.empty?
                        @html.details do
                           @html.summary('Resource Information', {'id' => 'body-resourceInfo', 'class' => 'h2'})
                           @html.section(:class => 'block') do
                              resourceClass.writeHtml(hResourceInfo)
                           end
                           @html.hr
                        end
                     end

                     # lineage section
                     unless aLineage.empty?
                        @html.details do
                           @html.summary('Resource Lineage', {'id' => 'body-lineage', 'class' => 'h2'})
                           @html.section(:class => 'block') do
                              aLineage.each do |hLineage|
                                 @html.details do
                                    @html.summary('Lineage', {'class' => 'h3'})
                                    @html.section(:class => 'block') do
                                       lineageClass.writeHtml(hLineage)
                                    end
                                 end
                              end
                           end
                           @html.hr
                        end
                     end

                     # distribution section
                     unless aDistribution.empty?
                        @html.details do
                           @html.summary('Resource Distribution', {'id' => 'body-distribution', 'class' => 'h2'})
                           @html.section(:class => 'block') do
                              aDistribution.each do |hDistribution|
                                 @html.details do
                                    @html.summary('Distribution', {'class' => 'h3'})
                                    @html.section(:class => 'block') do
                                       distributionClass.writeHtml(hDistribution)
                                    end
                                 end
                              end
                           end
                           @html.hr
                        end
                     end

                     # associated resource section
                     unless aAssociated.empty?
                        @html.details do
                           @html.summary('Associated Resources', {'id' => 'body-associatedResource', 'class' => 'h2'})
                           @html.section(:class => 'block') do
                              aAssociated.each do |hAssociated|
                                 @html.details do
                                    @html.summary('Resource', {'class' => 'h3'})
                                    @html.section(:class => 'block') do
                                       associatedClass.writeHtml(hAssociated)
                                    end
                                 end
                              end
                           end
                           @html.hr
                        end
                     end

                     # additional documentation section
                     unless aAdditional.empty?
                        @html.details do
                           @html.summary('Additional Documentation', {'id' => 'body-additionalDocument', 'class' => 'h2'})
                           @html.section(:class => 'block') do
                              aAdditional.each do |hAdditional|
                                 @html.details do
                                    @html.summary('Document', {'class' => 'h3'})
                                    @html.section(:class => 'block') do
                                       additionalClass.writeHtml(hAdditional)
                                    end
                                 end
                              end
                           end
                           @html.hr
                        end
                     end

                     # funding section
                     unless aFunding.empty?
                        @html.details do
                           @html.summary('Funding', {'id' => 'body-funding', 'class' => 'h2'})
                           @html.section(:class => 'block') do
                              aFunding.each do |hFunding|
                                 @html.details do
                                    @html.summary('Funds', {'class' => 'h3'})
                                    @html.section(:class => 'block') do
                                       fundingClass.writeHtml(hFunding)
                                    end
                                 end
                              end
                           end
                        end
                     end

                     # TODO add data dictionary
                     # TODO add metadata repository

                  end # body
               end # writeHtml
            end # Html_Body

         end
      end
   end
end
