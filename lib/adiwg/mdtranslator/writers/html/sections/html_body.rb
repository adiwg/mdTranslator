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
# require_relative 'html_dataDictionary'
# require_relative 'html_distributor'
# require_relative 'html_associatedResource'
# require_relative 'html_additionalDocumentation'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_Body

               def initialize(html)
                  @html = html
               end

               def writeHtml(intObj)
                  @html.body do

                     # classes used
                     metaInfoClass = Html_MetadataInfo.new(@html)
                     contactClass = Html_Contact.new(@html)
                     resourceInfo = Html_ResourceInfo.new(@html)
                     # htmlDataD = MdHtmlDataDictionary.new(@html)
                     # htmlDist = MdHtmlDistributor.new(@html)
                     # htmlAssRes = MdHtmlAssociatedResource.new(@html)
                     # htmlAddDoc = MdHtmlAdditionalDocumentation.new(@html)

                     # make sections of the internal data store more accessible
                     hSchema = intObj[:schema]
                     aContacts = intObj[:contacts]
                     hMetaInfo = intObj[:metadata][:metadataInfo]
                     hResourceInfo = intObj[:metadata][:resourceInfo]
                     # hMetadata = intObj[:metadata]
                     # aDataDict = intObj[:dataDictionary]
                     # aDistributor = intObj[:metadata][:distributorInfo]
                     # aAssRes = intObj[:metadata][:associatedResources]
                     # aAddDocs = intObj[:metadata][:additionalDocuments]

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
                     @html.h1('mdTranslator HTML Metadata Record', 'id' => 'mdtranslator-metadata-report')

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
                     @html.h2('Contacts', 'id' => 'contactsArray')
                     aContacts.each do |hContact|
                        @html.section(:class => 'block') do
                           contactClass.writeHtml(hContact)
                        end
                     end
                     @html.hr

                     # metadata information section
                     @html.h2('Metadata Information', 'id' => 'metadataInfo')
                     unless hMetaInfo.empty?
                        @html.section(:class => 'block') do
                           metaInfoClass.writeHtml(hMetaInfo)
                        end
                     end
                     @html.hr

                     # resource information section
                     @html.h2('Resource Information', 'id' => 'resourceInfo')
                     unless hResourceInfo.empty?
                        @html.section(:class => 'block') do
                           # resourceInfo.writeHtml(hResourceInfo)
                        end
                     end
                     @html.hr

                     # TODO add lineage
                     # TODO add distribution
                     # TODO add associated resource
                     # TODO add additional documentation
                     # TODO add funding
                     # TODO add data dictionary
                     # TODO add metadata repository

                  end # body
               end # writeHtml
            end # Html_Body

         end
      end
   end
end
