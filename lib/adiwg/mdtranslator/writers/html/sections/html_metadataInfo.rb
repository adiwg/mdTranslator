# HTML writer
# metadata information section

# History:
#  Stan Smith 2017-03-23 refactored for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
#  Stan Smith 2016-06-12 added metadata character set
# 	Stan Smith 2015-03-24 original script

require_relative 'html_identifier'
# require_relative 'html_citation'
# require_relative 'html_responsibleParty'
# require_relative 'html_dateTime'
# require_relative 'html_resourceMaint'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_MetadataInfo

               def initialize(html)
                  @html = html
               end

               def writeHtml(hMetaInfo)

                  # classes used
                  identifierClass = Html_Identifier.new(@html)
                  # citationClass = Html_Citation.new(@html)
                  # rPartyClass = MdHtmlResponsibleParty.new(@html)
                  # dateTimeClass = MdHtmlDateTime.new(@html)
                  # maintClass = MdHtmlResourceMaintenance.new(@html)

                  # metadata identifier {identifier}
                  unless hMetaInfo[:metadataIdentifier].empty?
                     @html.details do
                        @html.summary('Metadata Identifier', {'id' => 'metadata-identifier', 'class' => 'h3'})
                        @html.section(:class => 'block') do
                           identifierClass.writeHtml(hMetaInfo[:metadataIdentifier])
                        end
                     end
                  end

                  # TODO refactored to this point
                  @html.h2('Hi -- You refactored to this point in metadataInfo!!')


                  # # metadata information
                  # @html.details do
                  #    @html.summary('Metadata Record Information', {'id' => 'metadata-recordInfo', 'class' => 'h3'})
                  #    @html.section(:class => 'block') do
                  #
                  #       # metadata URI
                  #       s = hMetaInfo[:metadataURI]
                  #       if s
                  #          @html.em('Metadata URI: ')
                  #          @html.section(:class => 'block') do
                  #             @html.a(s, 'href' => s)
                  #          end
                  #       end
                  #
                  #       # metadata create date
                  #       hDate = hMetaInfo[:metadataCreateDate]
                  #       if !hDate.empty?
                  #          @html.em('Metadata creation: ')
                  #          dateTimeClass.writeHtml(hDate)
                  #       end
                  #
                  #       # metadata update date
                  #       hDate = hMetaInfo[:metadataUpdateDate]
                  #       if !hDate.empty?
                  #          @html.em('Metadata update: ')
                  #          dateTimeClass.writeHtml(hDate)
                  #       end
                  #
                  #       # metadata characterSet
                  #       s = hMetaInfo[:metadataCharacterSet]
                  #       if s
                  #          @html.em('Metadata character set: ')
                  #          @html.text!(s)
                  #          @html.br
                  #       end
                  #
                  #       # metadata locale
                  #       aLocale = hMetaInfo[:metadataLocales]
                  #       aLocale.each do |hLocale|
                  #          @html.em('Metadata language: ')
                  #          @html.text!(hLocale[:languageCode])
                  #          @html.em(' country: ')
                  #          @html.text!(hLocale[:countryCode])
                  #          @html.em(' characterSet encoding: ')
                  #          @html.text!(hLocale[:characterEncoding])
                  #          @html.br
                  #       end
                  #
                  #       # metadata status
                  #       s = hMetaInfo[:metadataStatus]
                  #       if s
                  #          @html.em('Metadata status: ')
                  #          @html.text!(s)
                  #          @html.br
                  #       end
                  #
                  #       # metadata custodians - contacts
                  #       aCustodians = hMetaInfo[:metadataCustodians]
                  #       if !aCustodians.empty?
                  #          @html.em('Metadata contact: ')
                  #          @html.section(:class => 'block') do
                  #             aCustodians.each do |hResParty|
                  #                rPartyClass.writeHtml(hResParty)
                  #             end
                  #          end
                  #       end
                  #
                  #       # metadata maintenance
                  #       hMaint = hMetaInfo[:maintInfo]
                  #       if !hMaint.empty?
                  #          @html.em('Metadata maintenance: ')
                  #          maintClass.writeHtml(hMaint)
                  #       end
                  #
                  #    end
                  # end
                  #
                  # # parent metadata - citation
                  # hParent = hMetaInfo[:parentMetadata]
                  # unless hParent.empty?
                  #    @html.details do
                  #       @html.summary('Parent Metadata Citation', {'id' => 'metadata-parentInfo', 'class' => 'h3'})
                  #       @html.section(:class => 'block') do
                  #          citationClass.writeHtml(hMetaInfo[:parentMetadata])
                  #       end
                  #    end
                  # end

               end # writeHtml

            end # Html_MetadataInfo

         end
      end
   end
end
