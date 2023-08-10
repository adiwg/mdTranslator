# HTML writer
# metadata information section

# History:
#  Stan Smith 2018-01-27 add metadata constraints
#  Stan Smith 2017-03-23 refactored for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
#  Stan Smith 2016-06-12 added metadata character set
# 	Stan Smith 2015-03-24 original script

require_relative 'html_identifier'
require_relative 'html_citation'
require_relative 'html_locale'
require_relative 'html_responsibility'
require_relative 'html_date'
require_relative 'html_onlineResource'
require_relative 'html_constraint'
require_relative 'html_maintenance'

module ADIWG
   module Mdtranslator
      module Writers
         module Simple_html

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
                  dateClass = Html_Date.new(@html)
                  onlineClass = Html_OnlineResource.new(@html)
                  constraintClass = Html_Constraint.new(@html)
                  maintClass = Html_Maintenance.new(@html)

                  # metadataInfo - metadata status
                  unless hMetaInfo[:metadataStatus].nil?
                     @html.em('Metadata Status: ')
                     @html.text!(hMetaInfo[:metadataStatus])
                     @html.br
                  end

                  # metadataInfo - metadata identifier {identifier}
                  unless hMetaInfo[:metadataIdentifier].empty?
                     @html.div do
                        @html.div('Metadata Identifier', {'id' => 'metadataInfo-identifier', 'class' => 'h3'})
                        @html.div(:class => 'block') do
                           identifierClass.writeHtml(hMetaInfo[:metadataIdentifier])
                        end
                     end
                  end

                  # metadataInfo - parent metadata {citation}
                  unless hMetaInfo[:parentMetadata].empty?
                     @html.div do
                        @html.div('Parent Metadata', {'id' => 'metadataInfo-parent', 'class' => 'h3'})
                        @html.div(:class => 'block') do
                           citationClass.writeHtml(hMetaInfo[:parentMetadata])
                        end
                     end
                  end

                  # metadataInfo - metadata locales
                  unless hMetaInfo[:defaultMetadataLocale].empty? && hMetaInfo[:otherMetadataLocales].empty?
                     @html.div do
                        @html.div('Metadata Locales', {'id' => 'metadataInfo-locale', 'class' => 'h3'})
                        @html.div(:class => 'block') do

                           # default metadata locales {locale}
                           unless hMetaInfo[:defaultMetadataLocale].empty?
                              @html.div do
                                 @html.div('Default Locale', {'class' => 'h5'})
                                 @html.div(:class => 'block') do
                                    localeClass.writeHtml(hMetaInfo[:defaultMetadataLocale])
                                 end
                              end
                           end

                           # other metadata locales [] {locale}
                           hMetaInfo[:otherMetadataLocales].each do |hLocale|
                              @html.div do
                                 @html.div('Other Locale', {'class' => 'h5'})
                                 @html.div(:class => 'block') do
                                    localeClass.writeHtml(hLocale)
                                 end
                              end
                           end

                        end
                     end
                  end

                  # metadataInfo - contacts [] {responsibility}
                  unless hMetaInfo[:metadataContacts].empty?
                     @html.div do
                        @html.div('Metadata Contacts', {'id' => 'metadataInfo-contacts', 'class' => 'h3'})
                        @html.div(:class => 'block') do
                           hMetaInfo[:metadataContacts].each do |hResponsibility|
                              @html.div do
                                 @html.div(hResponsibility[:roleName], 'class' => 'h5')
                                 @html.div(:class => 'block') do
                                    responsibilityClass.writeHtml(hResponsibility)
                                 end
                              end
                           end
                        end
                     end
                  end

                  # metadataInfo - dates [] {date}
                  unless hMetaInfo[:metadataDates].empty?
                     @html.div do
                        @html.div('Metadata Dates', {'id' => 'metadataInfo-dates', 'class' => 'h3'})
                        @html.div(:class => 'block') do
                           hMetaInfo[:metadataDates].each do |hDate|
                              @html.em('Date: ')
                              dateClass.writeHtml(hDate)
                              @html.br
                           end
                        end
                     end
                  end

                  # metadataInfo - linkages [] {onlineResource}
                  unless hMetaInfo[:metadataLinkages].empty?
                     @html.div do
                        @html.div('Metadata Online Resource', {'id' => 'metadataInfo-links', 'class' => 'h3'})
                        @html.div(:class => 'block') do
                           hMetaInfo[:metadataLinkages].each do |hOnline|
                              @html.div do
                                 @html.div('Online Resource', {'class' => 'h5'})
                                 @html.div(:class => 'block') do
                                    onlineClass.writeHtml(hOnline)
                                 end
                              end
                           end
                        end
                     end
                  end

                  # metadataInfo - constraints [] {constraint}
                  unless hMetaInfo[:metadataConstraints].empty?
                     @html.div do
                        @html.div('Metadata Constraints', {'id' => 'metadataInfo-constraint', 'class' => 'h3'})
                        @html.div(:class => 'block') do
                           hMetaInfo[:metadataConstraints].each do |hConstraint|
                              @html.div do
                                 @html.div(hConstraint[:type].capitalize+' Constraint', {'class' => 'h5'})
                                 @html.div(:class => 'block') do
                                    constraintClass.writeHtml(hConstraint)
                                 end
                              end
                           end
                        end
                     end
                  end

                  # metadataInfo - maintenance {maintenance}
                  unless hMetaInfo[:metadataMaintenance].empty?
                     @html.div do
                        @html.div('Metadata Maintenance', {'id' => 'metadataInfo-maintenance', 'class' => 'h3'})
                        @html.div(:class => 'block') do
                           maintClass.writeHtml(hMetaInfo[:metadataMaintenance])
                        end
                     end
                  end

                  # metadataInfo - alternate metadata references [] {citation}
                  unless hMetaInfo[:alternateMetadataReferences].empty?
                     @html.div do
                        @html.div('Alternate Metadata Citations', {'id' => 'metadataInfo-alternate', 'class' => 'h3'})
                        @html.div(:class => 'block') do
                           hMetaInfo[:alternateMetadataReferences].each do |hCitation|
                              @html.div do
                                 @html.div(hCitation[:title], 'class' => 'h5')
                                 @html.div(:class => 'block') do
                                    citationClass.writeHtml(hCitation)
                                 end
                              end
                           end
                        end
                     end
                  end

               end # writeHtml
            end # Html_MetadataInfo

         end
      end
   end
end
