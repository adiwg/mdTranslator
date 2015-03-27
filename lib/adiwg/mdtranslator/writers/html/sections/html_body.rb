# HTML writer
# html body

# History:
# 	Stan Smith 2015-03-23 original script

require 'html_metadataInfo'
require 'html_resourceInfo'
require 'html_dataDictionary'
require 'html_citation'

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

                            # make sections of the internal data store more accessible
                            hMetadata = intObj[:metadata]
                            aDataDict = intObj[:dataDictionary]
                            aDistribut = intObj[:metadata][:distributorInfo]
                            aAssRes = intObj[:metadata][:associatedResources]
                            aAddDocs = intObj[:metadata][:additionalDocuments]

                            # set page title with logo
                            # read logo from file
                            path = File.join(File.dirname(__FILE__), 'logo150.txt')
                            file = File.open(path, 'r')
                            logo = file.read
                            file.close

                            @html.h2('id'=>'mainHeader') do
                                @html.img('width'=>'150', 'height'=>'39', 'title'=>'', 'alt'=>'', 'src'=>logo)
                                @html.span('Metadata Report')
                                @html.span('HTML','class'=>'version')
                            end

                            # report title
                            @html.h1('mdTranslator Metadata Report', 'id'=>'mdtranslator-metadata-report')

                            # section index
                            @html.blockquote do
                                @html.h3('Page Index')
                                @html.a('Metadata Information Section','href'=>'#metadataInfo')
                                @html.blockquote do
                                    @html.a('Metadata Identifier', 'href'=>'#metadata-identifier')
                                    @html.br
                                    @html.a('Metadata Record Information', 'href'=>'#metadata-recordInfo')
                                    @html.br
                                    @html.a('Parent Metadata Citation', 'href'=>'#metadata-parentInfo')
                                end
                                @html.br
                                @html.a('Resource Information Section','href'=>'#resourceInfo')
                                @html.blockquote do
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
                                    @html.a('Spatial, Temporal, and Vertical Extents', 'href'=>'#resourceInfo-extents')
                                    @html.br
                                    @html.a('Data Quality', 'href'=>'#resourceInfo-dataQuality')
                                    @html.br
                                    @html.a('Constraints', 'href'=>'#resourceInfo-constraints')
                                    @html.br
                                    @html.a('Maintenance Information', 'href'=>'#resourceInfo-maintInfo')
                                end
                                @html.br
                                @html.a('Data Dictionary Section','href'=>'#dataDictionary')
                                @html.br
                                @html.a('Data Distribution Section','href'=>'#dataDistribution')
                                @html.br
                                @html.a('Associated Resources Section','href'=>'#associatedResource')
                                @html.br
                                @html.a('Additional Documentation Section','href'=>'#additionalDocuments')
                            end
                            @html.hr

                            # metadata source
                            @html.h2('Metadata Source', 'id'=>'metadata-source')
                            @html.blockquote do
                                @html.em('Metadata schema:')
                                @html.text!(intObj[:schema][:name])
                                @html.br

                                @html.em('Schema version:')
                                @html.text!(intObj[:schema][:version])
                            end
                            @html.hr

                            # metadata information section
                            @html.h2('Metadata Information', 'id'=>'metadataInfo')
                            @html.blockquote do
                                htmlMetaInfo.writeHtml(hMetadata[:metadataInfo])
                            end
                            @html.hr

                            # resource information section
                            @html.h2('Resource Information', 'id'=>'resourceInfo')
                            @html.blockquote do
                                htmlResInfo.writeHtml(hMetadata[:resourceInfo])
                            end
                            @html.hr

                            # data dictionary section
                            @html.h2('Data Dictionary', 'id'=>'dataDictionary')
                            aDataDict.each do |hDictionary|
                                @html.blockquote do

                                    # get dictionary title from the citation
                                    sTitle = hDictionary[:dictionaryInfo][:dictCitation][:citTitle]
                                    @html.details do
                                        @html.summary(sTitle, {'class'=>'h3'})
                                        @html.blockquote do
                                            htmlDataD.writeHtml(hDictionary)
                                        end
                                    end

                                end
                            end
                            @html.hr

                            # data distribution section
                            @html.h2('Data Distribution', 'id'=>'dataDistribution')
                            @html.blockquote do

                            end
                            @html.hr

                            # associated resource section
                            @html.h2('Associated Resources', 'id'=>'associatedResource')
                            @html.blockquote do

                            end
                            @html.hr

                            # additional documentation section
                            @html.h2('Additional Documentation', 'id'=>'additionalDocuments')
                            aAddDocs.each do |hAddDoc|
                                @html.blockquote do

                                    # get document title from the citation
                                    sTitle = hAddDoc[:citation][:citTitle]
                                    @html.details do
                                        @html.summary(sTitle, {'class'=>'h3'})
                                        @html.blockquote do

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
                                                @html.blockquote do
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
