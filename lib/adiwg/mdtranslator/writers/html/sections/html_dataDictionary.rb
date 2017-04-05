# HTML writer
# data dictionary

# History:
#  Stan Smith 2017-04-05 refactored for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
# 	Stan Smith 2015-03-26 original script

require_relative 'html_citation'
require_relative 'html_locale'
require_relative 'html_responsibility'
require_relative 'html_domain'
require_relative 'html_entity'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_DataDictionary

               def initialize(html)
                  @html = html
               end

               def writeHtml(hDictionary)

                  # classes used
                  citationClass = Html_Citation.new(@html)
                  localeClass = Html_Locale.new(@html)
                  responsibilityClass = Html_Responsibility.new(@html)
                  domainClass = Html_Domain.new(@html)
                  entityClass = Html_Entity.new(@html)

                  # dictionary - subjects []
                  hDictionary[:subjects].each do |subject|
                     @html.em('Subject: ')
                     @html.text!(subject)
                     @html.br
                  end

                  # dictionary - domains [] {domain}
                  hDictionary[:domains].each do |hDomain|
                     @html.details do
                        @html.summary('Domain', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           domainClass.writeHtml(hDomain)
                        end
                     end
                  end

                  # dictionary - entities [] {entity}
                  hDictionary[:entities].each do |hEntity|
                     @html.details do
                        @html.summary('Entity', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           entityClass.writeHtml(hEntity)
                        end
                     end
                  end

                  # dictionary - citation {citation}
                  unless hDictionary[:citation].empty?
                     @html.details do
                        @html.summary('Citation', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           citationClass.writeHtml(hDictionary[:citation])
                        end
                     end
                  end

                  # dictionary - locales {locale}
                  hDictionary[:locales].each do |hLocale|
                     @html.details do
                        @html.summary('Locale', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           localeClass.writeHtml(hLocale)
                        end
                     end
                  end

                  # dictionary - responsible party {responsibility}
                  unless hDictionary[:responsibleParty].empty?
                     @html.details do
                        @html.summary(hDictionary[:responsibleParty][:roleName], {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           responsibilityClass.writeHtml(hDictionary[:responsibleParty])
                        end
                     end
                  end

                  # dictionary - recommended uses []
                  hDictionary[:recommendedUses].each do |use|
                     @html.em('Recommended Use: ')
                     @html.text!(use)
                     @html.br
                  end

                  # dictionary - dictionary format
                  unless hDictionary[:dictionaryFormat].nil?
                     @html.em('Dictionary Format: ')
                     @html.text!(hDictionary[:dictionaryFormat])
                     @html.br
                  end

                  # dictionary - included with dataset {Boolean}
                  @html.em('Dictionary Included with Dataset?: ')
                  @html.text!(hDictionary[:includedWithDataset].to_s)
                  @html.br

               end # writeHtml
            end # Html_DataDictionary

         end
      end
   end
end
