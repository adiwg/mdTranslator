# HTML writer
# metadata information section

# History:
# 	Stan Smith 2015-03-24 original script

require 'html_citation'
require 'html_responsibleParty'
require 'html_dateTime'
require 'html_resourceMaint'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlMetadataInfo
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hMetaInfo)

                        # classes used
                        htmlCitation = $HtmlNS::MdHtmlCitation.new(@html)
                        htmlResParty = $HtmlNS::MdHtmlResponsibleParty.new(@html)
                        htmlDateTime = $HtmlNS::MdHtmlDateTime.new(@html)
                        htmlResMaint = $HtmlNS::MdHtmlResourceMaintenance.new(@html)

                        # metadata identifier
                        @html.details do
                            @html.summary('Metadata Identifier', {'id'=>'metadata-identifier', 'class'=>'h3'})
                            @html.blockquote do
                                @html.em('Identifier:')
                                @html.text!(hMetaInfo[:metadataId][:identifier])
                                @html.br

                                @html.em('Identifier type:')
                                @html.text!(hMetaInfo[:metadataId][:identifierType])
                                @html.br
                            end
                        end

                        # metadata information
                        @html.details do
                            @html.summary('Metadata Record Information', {'id'=>'metadata-record-info', 'class'=>'h3'})
                            @html.blockquote do

                                # metadata URI
                                s = hMetaInfo[:metadataURI]
                                if s
                                    @html.em('Metadata URI: ')
                                    @html.a(s, 'href'=>s)
                                    @html.br
                                end

                                # metadata create date
                                hDate = hMetaInfo[:metadataCreateDate]
                                if !hDate.empty?
                                    @html.em('Metadata creation: ')
                                    htmlDateTime.writeHtml(hDate)
                                end

                                # metadata update date
                                hDate = hMetaInfo[:metadataUpdateDate]
                                if !hDate.empty?
                                    @html.em('Metadata update: ')
                                    htmlDateTime.writeHtml(hDate)
                                end

                                # metadata status
                                s = hMetaInfo[:metadataStatus]
                                if s
                                    @html.em('Metadata status: ')
                                    @html.text!(s)
                                    @html.br
                                end

                                # metadata custodians - contacts
                                aCustodians = hMetaInfo[:metadataCustodians]
                                if !aCustodians.empty?
                                    @html.em('Metadata contact: ')
                                    @html.blockquote do
                                        aCustodians.each do |hResParty|
                                            htmlResParty.writeHtml(hResParty)
                                        end
                                    end
                                end

                                # metadata maintenance
                                hMaint = hMetaInfo[:maintInfo]
                                if !hMaint.empty?
                                    @html.em('Metadata maintenance: ')
                                    htmlResMaint.writeHtml(hMaint)
                                end

                            end
                        end

                        # parent metadata - citation
                        hParent = hMetaInfo[:parentMetadata]
                        if !hParent.empty?
                            @html.details do
                                @html.summary('Parent Metadata Citation', {'id'=>'metadata-parent-info', 'class'=>'h3'})
                                @html.blockquote do
                                    htmlCitation.writeHtml(hMetaInfo[:parentMetadata])
                                end
                            end
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
