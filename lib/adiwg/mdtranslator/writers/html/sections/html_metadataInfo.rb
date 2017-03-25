# HTML writer
# metadata information section

# History:
#  Stan Smith 2017-03-23 refactored for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
#  Stan Smith 2016-06-12 added metadata character set
# 	Stan Smith 2015-03-24 original script

require_relative 'html_identifier'
require_relative 'html_citation'
require_relative 'html_locale'
require_relative 'html_responsibility'
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
                  citationClass = Html_Citation.new(@html)
                  localeClass = Html_Locale.new(@html)
                  responsibilityClass = Html_Responsibility.new(@html)
                  # dateTimeClass = MdHtmlDateTime.new(@html)
                  # maintClass = MdHtmlResourceMaintenance.new(@html)

                  # metadataInfo - metadata identifier {identifier}
                  unless hMetaInfo[:metadataIdentifier].empty?
                     @html.details do
                        @html.summary('Metadata Identifier', {'id' => 'metadataInfo-identifier', 'class' => 'h3'})
                        @html.section(:class => 'block') do
                           identifierClass.writeHtml(hMetaInfo[:metadataIdentifier])
                        end
                     end
                  end

                  # metadataInfo - parent metadata {citation}
                  unless hMetaInfo[:parentMetadata].empty?
                     @html.details do
                        @html.summary('Parent Metadata', {'id' => 'metadataInfo-parentInfo', 'class' => 'h3'})
                        @html.section(:class => 'block') do
                           citationClass.writeHtml(hMetaInfo[:parentMetadata])
                        end
                     end
                  end

                  # metadataInfo - metadata locales
                  unless hMetaInfo[:defaultMetadataLocale].empty? && hMetaInfo[:otherMetadataLocales].empty?
                     @html.details do
                        @html.summary('Locales', {'id' => 'metadataInfo-localeInfo', 'class' => 'h3'})
                        @html.section(:class => 'block') do

                           # default metadata locales {locale}
                           unless hMetaInfo[:defaultMetadataLocale].empty?
                              @html.em('Default Metadata Locale: ')
                              @html.section(:class => 'block') do
                                 localeClass.writeHtml(hMetaInfo[:defaultMetadataLocale])
                              end
                           end

                           # other metadata locales [] {locale}
                           hMetaInfo[:otherMetadataLocales].each do |hLocale|
                              @html.em('Other Metadata Locale: ')
                              @html.section(:class => 'block') do
                                 localeClass.writeHtml(hLocale)
                              end
                           end

                        end
                     end
                  end

                  # metadataInfo - contacts [] {responsibility}
                  unless hMetaInfo[:metadataContacts].empty?
                     @html.details do
                        @html.summary('Contacts', {'id' => 'metadataInfo-contacts', 'class' => 'h3'})
                        @html.section(:class => 'block') do
                           hMetaInfo[:metadataContacts].each do |hResponsibility|
                              @html.details do
                                 @html.summary(hResponsibility[:roleName], 'class' => 'h5')
                                 @html.section(:class => 'block') do
                                    responsibilityClass.writeHtml(hResponsibility)
                                 end
                              end
                           end
                        end
                     end
                  end

                  # metadataInfo - dates [] {date}

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
                  #       # metadata status
                  #       s = hMetaInfo[:metadataStatus]
                  #       if s
                  #          @html.em('Metadata status: ')
                  #          @html.text!(s)
                  #          @html.br
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

               end # writeHtml

            end # Html_MetadataInfo

         end
      end
   end
end
