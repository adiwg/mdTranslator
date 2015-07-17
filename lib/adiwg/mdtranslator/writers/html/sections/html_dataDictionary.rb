# HTML writer
# data dictionary

# History:
# 	Stan Smith 2015-03-26 original script
#   Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS

require_relative 'html_citation'
require_relative 'html_domain'
require_relative 'html_entity'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlDataDictionary
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hDictionary)

                        # classes used
                        htmlCitation = MdHtmlCitation.new(@html)
                        htmlDomain = MdHtmlDictionaryDomain.new(@html)
                        htmlEntity = MdHtmlDictionaryEntity.new(@html)

                        hDictId = hDictionary[:dictionaryInfo]
                        aDictDom = hDictionary[:domains]
                        aDictEnt = hDictionary[:entities]

                        @html.details do
                            @html.summary('Dictionary Identification', {'class'=>'h4'})
                            @html.section(:class=>'block') do

                                # dictionary identification - resource type
                                s = hDictId[:dictResourceType]
                                if !s.nil?
                                    @html.em('Resource type: ')
                                    @html.text!(s)
                                    @html.br
                                end

                                # dictionary identification - description
                                s = hDictId[:dictDescription]
                                if !s.nil?
                                    @html.em('Description: ')
                                    @html.text!(s)
                                    @html.br
                                end

                                # dictionary identification - language
                                s = hDictId[:dictLanguage]
                                if !s.nil?
                                    @html.em('Language: ')
                                    @html.text!(s)
                                    @html.br
                                end

                                # dictionary identification - citation
                                @html.em('Citation: ')
                                @html.section(:class=>'block') do
                                    htmlCitation.writeHtml(hDictId[:dictCitation])
                                end

                            end
                        end

                        # data dictionary - resource domains
                        unless aDictDom.empty?
                            @html.details do
                                @html.summary('Resource Domains', {'class'=>'h4'})
                                aDictDom.each do |hDomain|
                                    @html.section(:class=>'block') do
                                        @html.details do
                                            @html.summary(hDomain[:domainCode], {'class'=>'h5'})
                                            @html.section(:class=>'block') do
                                                htmlDomain.writeHtml(hDomain)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        # data dictionary - resource schema
                        unless aDictEnt.empty?
                            @html.details do
                                @html.summary('Resource Entities', {'class'=>'h4'})
                                aDictEnt.each do |hEntity|
                                    @html.section(:class=>'block') do
                                        @html.details do
                                            @html.summary(hEntity[:entityCode], {'class'=>'h5'})
                                            @html.section(:class=>'block') do
                                                htmlEntity.writeHtml(hEntity)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
