# HTML writer
# metadata information section

# History:
# 	Stan Smith 2015-03-24 original script
#   Stan Smith 2016-06-12 added metadata character set
#   Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS

require_relative 'html_citation'
require_relative 'html_responsibleParty'
require_relative 'html_dateTime'
require_relative 'html_resourceMaint'

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
                        htmlCitation = MdHtmlCitation.new(@html)
                        htmlResParty = MdHtmlResponsibleParty.new(@html)
                        htmlDateTime = MdHtmlDateTime.new(@html)
                        htmlResMaint = MdHtmlResourceMaintenance.new(@html)

                        # metadata identifier
                        id = hMetaInfo[:metadataId][:identifier]
                        if id
                            @html.details do
                                @html.summary('Metadata Identifier', {'id'=>'metadata-identifier', 'class'=>'h3'})
                                @html.section(:class=>'block') do
                                    @html.em('Identifier:')
                                    @html.text!(id)
                                    @html.br

                                    type = hMetaInfo[:metadataId][:identifierType]
                                    if type
                                        @html.em('Identifier type:')
                                        @html.text!(type)
                                        @html.br
                                    end
                                end
                            end
                        end

                        # metadata information
                        @html.details do
                            @html.summary('Metadata Record Information', {'id'=>'metadata-recordInfo', 'class'=>'h3'})
                            @html.section(:class=>'block') do

                                # metadata URI
                                s = hMetaInfo[:metadataURI]
                                if s
                                    @html.em('Metadata URI: ')
                                    @html.section(:class=>'block') do
                                        @html.a(s, 'href'=>s)
                                    end
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

                                # metadata characterSet
                                s = hMetaInfo[:metadataCharacterSet]
                                if s
                                    @html.em('Metadata character set: ')
                                    @html.text!(s)
                                    @html.br
                                end

                                # metadata locale
                                aLocale = hMetaInfo[:metadataLocales]
                                aLocale.each do |hLocale|
                                    @html.em('Metadata language: ')
                                    @html.text!(hLocale[:languageCode])
                                    @html.em(' country: ')
                                    @html.text!(hLocale[:countryCode])
                                    @html.em(' characterSet encoding: ')
                                    @html.text!(hLocale[:characterEncoding])
                                    @html.br
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
                                    @html.section(:class=>'block') do
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
                        unless hParent.empty?
                            @html.details do
                                @html.summary('Parent Metadata Citation', {'id'=>'metadata-parentInfo', 'class'=>'h3'})
                                @html.section(:class=>'block') do
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
