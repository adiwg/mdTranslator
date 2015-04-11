# HTML writer
# html body

# History:
# 	Stan Smith 2015-03-23 original script
#   Stan Smith 2014-04-10 add open and close buttons

require 'html_metadataInfo'
require 'html_resourceInfo'
require 'html_dataDictionary'
require 'html_citation'
require 'html_responsibleParty'
require 'html_orderProcess'
require 'html_format'
require 'html_transferOption'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlBody
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(intObj)
                        @html.body do

                            # classes used
                            htmlMetaInfo = $HtmlNS::MdHtmlMetadataInfo.new(@html)
                            htmlResInfo = $HtmlNS::MdHtmlResourceInfo.new(@html)
                            htmlDataD = $HtmlNS::MdHtmlDataDictionary.new(@html)
                            htmlCitation = $HtmlNS::MdHtmlCitation.new(@html)
                            htmlResParty = $HtmlNS::MdHtmlResponsibleParty.new(@html)
                            htmlOrderProc = $HtmlNS::MdHtmlOrderProcess.new(@html)
                            htmlFormat = $HtmlNS::MdHtmlFormat.new(@html)
                            htmlTranOpt = $HtmlNS::MdHtmlTransferOption.new(@html)

                            # make sections of the internal data store more accessible
                            hMetadata = intObj[:metadata]
                            aDataDict = intObj[:dataDictionary]
                            aDistributor = intObj[:metadata][:distributorInfo]
                            aAssRes = intObj[:metadata][:associatedResources]
                            aAddDocs = intObj[:metadata][:additionalDocuments]

                            # set page title with logo
                            # read logo from file
                            path = File.join(File.dirname(__FILE__), 'logo150.txt')
                            file = File.open(path, 'r')
                            logo = file.read
                            file.close

                            # add top anchor and button
                            @html.a(' Top', {'href'=>'#', 'class'=>'btn icon-caret-up', 'style'=>'position:fixed; bottom:6em; right:1em'})

                            # add open and close buttons
                            @html.span(' Open',{'class'=>'btn icon-caret-down', 'style'=>'position:fixed; bottom:1em; right:1em', 'onclick'=>'openAllDetails();'})
                            @html.span(' Close',{'class'=>'btn icon-caret-right', 'style'=>'position:fixed; bottom:3.5em; right:1em', 'onclick'=>'closeAllDetails();'})

                            # main header
                            @html.h2('id'=>'mainHeader') do
                                @html.img('width'=>'150', 'height'=>'39', 'title'=>'', 'alt'=>'', 'src'=>logo)
                                @html.span('Metadata Report')
                                @html.span('HTML','class'=>'version')
                            end

                            # report title
                            @html.h1('mdTranslator Metadata Report', 'id'=>'mdtranslator-metadata-report')

                            # section index
                            @html.section(:class=>'block') do
                                @html.h3('Page Index')
                                @html.a('Metadata Information Section','href'=>'#metadataInfo')
                                @html.section(:class=>'block') do
                                    @html.a('Metadata Identifier', 'href'=>'#metadata-identifier')
                                    @html.br
                                    @html.a('Metadata Record Information', 'href'=>'#metadata-recordInfo')
                                    @html.br
                                    @html.a('Parent Metadata Citation', 'href'=>'#metadata-parentInfo')
                                end
                                @html.br
                                @html.a('Resource Information Section','href'=>'#resourceInfo')
                                @html.section(:class=>'block') do
                                    @html.a('Resource Identification', 'href'=>'#resourceInfo-general')
                                    @html.br
                                    @html.a('Contacts', 'href'=>'#resourceInfo-contacts')
                                    @html.br
                                    @html.a('Keywords', 'href'=>'#resourceInfo-keywords')
                                    @html.br
                                    @html.a('Taxonomy', 'href'=>'#resourceInfo-taxonomy')
                                    @html.br
                                    @html.a('Spatial Reference', 'href'=>'#resourceInfo-spatialRef')
                                    @html.br
                                    @html.a('Extents (Geographic, Temporal, & Vertical Space)', 'href'=>'#resourceInfo-extents')
                                    @html.br
                                    @html.a('Data Quality', 'href'=>'#resourceInfo-dataQuality')
                                    @html.br
                                    @html.a('Constraints', 'href'=>'#resourceInfo-constraints')
                                    @html.br
                                    @html.a('Maintenance Information', 'href'=>'#resourceInfo-maintInfo')
                                    @html.br
                                    @html.a('Other Resource Information', 'href'=>'#resourceInfo-other')
                                end
                                @html.br
                                @html.a('Data Dictionary Section','href'=>'#dataDictionary')
                                @html.br
                                @html.a('Resource Distribution Section','href'=>'#resourceDistribution')
                                @html.br
                                @html.a('Associated Resources Section','href'=>'#associatedResource')
                                @html.br
                                @html.a('Additional Documentation Section','href'=>'#additionalDocuments')
                            end
                            @html.hr

                            # metadata source
                            @html.h2('Metadata Source', 'id'=>'metadata-source')
                            @html.section(:class=>'block') do
                                @html.em('Metadata schema:')
                                @html.text!(intObj[:schema][:name])
                                @html.br

                                @html.em('Schema version:')
                                @html.text!(intObj[:schema][:version])
                            end
                            @html.hr

                            # metadata information section
                            @html.h2('Metadata Information', 'id'=>'metadataInfo')
                            @html.section(:class=>'block') do
                                htmlMetaInfo.writeHtml(hMetadata[:metadataInfo])
                            end
                            @html.hr

                            # resource information section
                            @html.h2('Resource Information', 'id'=>'resourceInfo')
                            @html.section(:class=>'block') do
                                htmlResInfo.writeHtml(hMetadata[:resourceInfo])
                            end
                            @html.hr

                            # data dictionary section
                            @html.h2('Data Dictionary', 'id'=>'dataDictionary')
                            aDataDict.each do |hDictionary|
                                @html.section(:class=>'block') do

                                    # get dictionary title from the citation
                                    sTitle = hDictionary[:dictionaryInfo][:dictCitation][:citTitle]
                                    @html.details do
                                        @html.summary(sTitle, {'class'=>'h3'})
                                        @html.section(:class=>'block') do
                                            htmlDataD.writeHtml(hDictionary)
                                        end
                                    end

                                end
                            end
                            @html.hr

                            # resource distribution section
                            @html.h2('Resource Distribution', 'id'=>'resourceDistribution')
                            aDistributor.each do |hDistributor|
                                @html.section(:class=>'block') do
                                    @html.details do
                                        @html.summary('Distributor', {'class'=>'h4'})
                                        @html.section(:class=>'block') do

                                            # resource distribution - distributor - required
                                            @html.em('Distributor contact: ')
                                            hResParty = hDistributor[:distContact]
                                            @html.section(:class=>'block') do
                                                htmlResParty.writeHtml(hResParty)
                                            end

                                            # resource distribution - order process
                                            hDistributor[:distOrderProc].each do |hOrder|
                                                @html.em('Order Process: ')
                                                @html.section(:class=>'block') do
                                                    htmlOrderProc.writeHtml(hOrder)
                                                end
                                            end

                                            # resource distribution - resource format
                                            hDistributor[:distFormat].each do |hFormat|
                                                htmlFormat.writeHtml(hFormat)
                                            end

                                            # resource distribution - transfer options
                                            hDistributor[:distTransOption].each do |hTransOption|
                                                htmlTranOpt.writeHtml(hTransOption)
                                            end

                                        end
                                    end
                                end
                            end
                            @html.hr

                            # associated resource section
                            @html.h2('Associated Resources', 'id'=>'associatedResource')
                            aAssRes.each do |hAssRes|
                                @html.section(:class=>'block') do

                                    # get document title from the citation
                                    hCitation = hAssRes[:resourceCitation]
                                    if !hCitation.empty?
                                        sTitle = hCitation[:citTitle]
                                    else
                                        sTitle = 'Resource'
                                    end

                                    @html.details do
                                        @html.summary(sTitle, {'class'=>'h4'})
                                        @html.section(:class=>'block') do

                                            # associated resource - resource type
                                            s = hAssRes[:resourceType]
                                            if !s.nil?
                                                @html.em('Resource type: ')
                                                @html.text!(s)
                                                @html.br
                                            end

                                            # associated resource - association type
                                            s = hAssRes[:associationType]
                                            if !s.nil?
                                                @html.em('Association type: ')
                                                @html.text!(s)
                                                @html.br
                                            end

                                            # associated resource - initiative type
                                            s = hAssRes[:initiativeType]
                                            if !s.nil?
                                                @html.em('Initiative type: ')
                                                @html.text!(s)
                                                @html.br
                                            end

                                            # associated resource - citation
                                            if !hCitation.empty?
                                                @html.em('Resource citation: ')
                                                @html.section(:class=>'block') do
                                                    htmlCitation.writeHtml(hCitation)
                                                end
                                            end

                                            # associated resource - metadata citation
                                            hCitation = hAssRes[:metadataCitation]
                                            if !hCitation.empty?
                                                @html.em('Metadata citation: ')
                                                @html.section(:class=>'block') do
                                                    htmlCitation.writeHtml(hCitation)
                                                end
                                            end

                                        end
                                    end

                                end
                            end
                            @html.hr

                            # additional documentation section
                            @html.h2('Additional Documentation', 'id'=>'additionalDocuments')
                            aAddDocs.each do |hAddDoc|
                                @html.section(:class=>'block') do

                                    # get document title from the citation
                                    sTitle = hAddDoc[:citation][:citTitle]
                                    @html.details do
                                        @html.summary(sTitle, {'class'=>'h4'})
                                        @html.section(:class=>'block') do

                                            # additional documentation - resource type
                                            s = hAddDoc[:resourceType]
                                            if !s.nil?
                                                @html.em('Resource type: ')
                                                @html.text!(s)
                                                @html.br
                                            end

                                            # additional documentation - citation
                                            hCitation = hAddDoc[:citation]
                                            if !hCitation.empty?
                                                @html.em('Citation: ')
                                                @html.section(:class=>'block') do
                                                    htmlCitation.writeHtml(hCitation)
                                                end
                                            end

                                        end
                                    end

                                end
                            end
                            @html.hr

                        end # body
                    end # def writeHtml
                end # class

            end
        end
    end
end