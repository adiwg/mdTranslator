# HTML writer
# html body

# History:
#  Stan Smith 2018-01-19 add resource citation title to report header
#  Stan Smith 2017-03-22 refactor for mdTranslator 2.0
#  Stan Smith 2015-07-20 moved mdTranslator logo to html_inlineCss.css
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
#  Stan Smith 2014-04-10 add open and close buttons
#  Stan Smith 2015-03-23 original script

require_relative 'html_contact'
require_relative 'html_metadataInfo'
require_relative 'html_resourceInfo'
require_relative 'html_dataQuality'
require_relative 'html_lineage'
require_relative 'html_distribution'
require_relative 'html_associatedResource'
require_relative 'html_additionalDocumentation'
require_relative 'html_funding'
require_relative 'html_dataDictionary'
require_relative 'html_metadataRepository'

module ADIWG
   module Mdtranslator
      module Writers
         module SimpleHtml

            class Html_Body

               def initialize(html)
                  @html = html
               end

               def writeHtml(version, intObj)
                  @html.body do

                     # classes used
                     metaInfoClass = Html_MetadataInfo.new(@html)
                     contactClass = Html_Contact.new(@html)
                     resourceClass = Html_ResourceInfo.new(@html)
                     dataQualityClass = Html_DataQuality.new(@html)
                     lineageClass = Html_Lineage.new(@html)
                     distributionClass = Html_Distribution.new(@html)
                     associatedClass = Html_AssociatedResource.new(@html)
                     additionalClass = Html_AdditionalDocumentation.new(@html)
                     fundingClass = Html_Funding.new(@html)
                     dictionaryClass = Html_DataDictionary.new(@html)
                     repositoryClass = Html_Repository.new(@html)

                     # make sections of the internal data store convenient
                     hSchema = intObj[:schema]
                     aContacts = intObj[:contacts]
                     hMetaInfo = intObj[:metadata][:metadataInfo]
                     hResourceInfo = intObj[:metadata][:resourceInfo]
                     aDataQuality = intObj[:metadata][:dataQuality]
                     aLineage = intObj[:metadata][:lineageInfo]
                     aDistribution = intObj[:metadata][:distributorInfo]
                     aAssociated = intObj[:metadata][:associatedResources]
                     aAdditional = intObj[:metadata][:additionalDocuments]
                     aFunding = intObj[:metadata][:funding]
                     aDictionaries = intObj[:dataDictionaries]
                     aRepositories = intObj[:metadataRepositories]

                     # set page title and logo
                     # side navigation
                     @html.div('id' => 'sideNav') do

                        # add section buttons
                        @html.a(' Top', {'href' => '#', 'class' => 'btn'})
                        @html.a(' Contacts', {'href' => '#body-contacts', 'class' => 'btn navBtn', 'id' => 'contactButton'})
                        @html.a(' Metadata', {'href' => '#body-metadataInfo', 'class' => 'btn navBtn', 'id' => 'metadataButton'})
                        @html.a(' Resource', {'href' => '#body-resourceInfo', 'class' => 'btn navBtn', 'id' => 'resourceButton'})
                        @html.a(' Lineage', {'href' => '#body-lineage', 'class' => 'btn navBtn', 'id' => 'lineageButton'})
                        @html.a(' Distribution', {'href' => '#body-distribution', 'class' => 'btn navBtn', 'id' => 'distributionButton'})
                        @html.a(' Associated', {'href' => '#body-associatedResource', 'class' => 'btn navBtn', 'id' => 'associatedButton'})
                        @html.a(' Additional', {'href' => '#body-additionalDocument', 'class' => 'btn navBtn', 'id' => 'additionalButton'})
                        @html.a(' Dictionary', {'href' => '#body-dataDictionary', 'class' => 'btn navBtn', 'id' => 'dictionaryButton'})
                        @html.a(' Funding', {'href' => '#body-funding', 'class' => 'btn navBtn', 'id' => 'fundingButton'})
                        @html.a(' Repository', {'href' => '#body-repository', 'class' => 'btn navBtn', 'id' => 'repositoryButton'})

                        # add open and close buttons
                        @html.span(' Open', {'class' => 'btn icon-caret-down', 'id' => 'openAllButton'})
                        @html.span(' Close', {'class' => 'btn icon-caret-right', 'id' => 'closeAllButton'})

                     end

                     # main header
                     @html.h2('id' => 'mainHeader') do
                        # added blank to span tag to force builder to create closing tag
                        @html.span('', 'id' => 'logo')
                        @html.span('Metadata Record')
                        @html.span('HTML5', 'class' => 'version')
                     end

                     # report title
                     # aShortVersion = version.split('.')
                     # shortVersion = aShortVersion[0].to_s + '.' + aShortVersion[1].to_s
                     @html.h1('mdTranslator ' + version + ' HTML Metadata Record', 'id' => 'mdtranslator-metadata-report')

                     # resource citation title
                     unless hResourceInfo.empty?
                        unless hResourceInfo[:citation].empty?
                           unless hResourceInfo[:citation][:title].nil?
                              @html.h2(hResourceInfo[:citation][:title])
                           end
                        end
                     end

                     # report date
                     @html.div(:class => 'block') do
                        @html.em('Report Generated:')
                        @html.text!(Time.new.inspect)
                     end

                     # metadata source
                     @html.h3('Metadata Source', 'id' => 'metadataSource')
                     @html.div(:class => 'block') do
                        @html.em('Metadata schema:')
                        @html.text!(hSchema[:name])
                        @html.br

                        @html.em('Schema version:')
                        @html.text!(hSchema[:version])
                     end
                     @html.hr

                     # contacts [] section
                     unless aContacts.empty?
                        @html.div do
                           @html.div('Contacts', {'id' => 'body-contacts', 'class' => 'h2'})
                           @html.div(:class => 'block') do
                              aContacts.each do |hContact|
                                 @html.div(:class => 'block') do
                                    contactClass.writeHtml(hContact)
                                 end
                              end
                              @html.hr
                           end
                        end
                     end

                     # metadata information section
                     unless hMetaInfo.empty?
                        @html.div do
                        @html.div('Metadata Information', {'id' => 'body-metadataInfo', 'class' => 'h2'})
                        @html.div(:class => 'block') do
                              @html.div(:class => 'block') do
                                 metaInfoClass.writeHtml(hMetaInfo)
                              end
                           end
                           @html.hr
                        end
                     end

                     # resource information section
                     unless hResourceInfo.empty?
                        @html.div do
                           @html.div('Resource Information', {'id' => 'body-resourceInfo', 'class' => 'h2'})
                           @html.div(:class => 'block') do
                              resourceClass.writeHtml(hResourceInfo)
                           end
                           @html.hr
                        end
                     end

                     unless aDataQuality.nil? || aDataQuality.empty?
                        @html.div do
                           @html.div('Data Quality', {'id' => 'body-dataQuality', 'class' => 'h2'})
                           aDataQuality.each do |hDataQuality|
                              @html.div(:class => 'block') do
                                 dataQualityClass.writeHtml(hDataQuality)
                              end
                           end
                        end
                     end

                     # lineage section
                     unless aLineage.empty?
                        @html.div do
                           @html.div('Resource Lineage', {'id' => 'body-lineage', 'class' => 'h2'})
                           @html.div(:class => 'block') do
                              aLineage.each do |hLineage|
                                 @html.div do
                                    @html.div('Lineage', {'class' => 'h3'})
                                    @html.div(:class => 'block') do
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
                        @html.div do
                           @html.div('Resource Distribution', {'id' => 'body-distribution', 'class' => 'h2'})
                           @html.div(:class => 'block') do
                              aDistribution.each do |hDistribution|
                                 @html.div do
                                    @html.div('Distribution', {'class' => 'h3'})
                                    @html.div(:class => 'block') do
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
                        @html.div do
                           @html.div('Associated Resources', {'id' => 'body-associatedResource', 'class' => 'h2'})
                           @html.div(:class => 'block') do
                              aAssociated.each do |hAssociated|
                                 @html.div do
                                    @html.div('Resource', {'class' => 'h3'})
                                    @html.div(:class => 'block') do
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
                        @html.div do
                           @html.div('Additional Documentation', {'id' => 'body-additionalDocument', 'class' => 'h2'})
                           @html.div(:class => 'block') do
                              aAdditional.each do |hAdditional|
                                 @html.div do
                                    @html.div('Document', {'class' => 'h3'})
                                    @html.div(:class => 'block') do
                                       additionalClass.writeHtml(hAdditional)
                                    end
                                 end
                              end
                           end
                           @html.hr
                        end
                     end

                     # data dictionary section
                     unless aDictionaries.empty?
                        @html.div do
                           @html.div('Data Dictionaries', {'id' => 'body-dataDictionary', 'class' => 'h2'})
                           @html.div(:class => 'block') do
                              aDictionaries.each do |hDictionary|
                                 @html.div do
                                    @html.div('Dictionary', {'class' => 'h3'})
                                    @html.div(:class => 'block') do
                                       dictionaryClass.writeHtml(hDictionary)
                                    end
                                 end
                              end
                           end
                        end
                     end

                     # funding section
                     unless aFunding.empty?
                        @html.div do
                           @html.div('Funding', {'id' => 'body-funding', 'class' => 'h2'})
                           @html.div(:class => 'block') do
                              aFunding.each do |hFunding|
                                 @html.div do
                                    @html.div('Funds', {'class' => 'h3'})
                                    @html.div(:class => 'block') do
                                       fundingClass.writeHtml(hFunding)
                                    end
                                 end
                              end
                           end
                        end
                     end

                     # metadata repository section
                     unless aRepositories.empty?
                        @html.div do
                           @html.div('Metadata Repositories', {'id' => 'body-repository', 'class' => 'h2'})
                           @html.div(:class => 'block') do
                              aRepositories.each do |hRepository|
                                 @html.div do
                                    @html.div('Repository', {'class' => 'h3'})
                                    @html.div(:class => 'block') do
                                       repositoryClass.writeHtml(hRepository)
                                    end
                                 end
                              end
                           end
                        end
                     end

                     # load leaflet
                     @html.link( :rel => 'stylesheet', :href => 'https://unpkg.com/leaflet@1.0.3/dist/leaflet.css')
                     @html.script('', :src => 'https://unpkg.com/leaflet@1.0.3/dist/leaflet.js')
                     @html.script('', :src => 'https://stamen-maps.a.ssl.fastly.net/js/tile.stamen.js')

                     # add inline javascript
                     # read javascript from file
                     path = File.join(File.dirname(__FILE__), 'html_bodyScript.js')
                     file = File.open(path, 'r')
                     bodyJS = file.read
                     file.close

                     @html.script('type'=>'text/javascript') do
                        @html << bodyJS
                     end

                  end # body
               end # writeHtml
            end # Html_Body

         end
      end
   end
end
