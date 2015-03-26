# HTML writer
# data dictionary

# History:
# 	Stan Smith 2015-03-26 original script

require 'html_citation'
require 'html_domain'
require 'html_entity'

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
                        htmlCitation = $HtmlNS::MdHtmlCitation.new(@html)
                        htmlDomain = $HtmlNS::MdHtmlDictionaryDomain.new(@html)
                        htmlEntity = $HtmlNS::MdHtmlDictionaryEntity.new(@html)

                        hDictId = hDictionary[:dictionaryInfo]
                        aDictDom = hDictionary[:domains]
                        aDictEnt = hDictionary[:entities]

                        @html.details do
                            @html.summary('Dictionary Identification', {'class'=>'h4'})
                            @html.blockquote do

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
                                @html.blockquote do
                                    htmlCitation.writeHtml(hDictId[:dictCitation])
                                end

                            end
                        end

                        # data dictionary - resource domains
                        @html.details do
                            @html.summary('Resource Domains', {'class'=>'h4'})
                            if !aDictDom.empty?
                                aDictDom.each do |hDomain|
                                    @html.blockquote do
                                        @html.details do
                                            @html.summary(hDomain[:domainCode], {'class'=>'h5'})
                                            htmlDomain.writeHtml(hDomain)
                                        end
                                    end
                                end
                            end
                        end

                        # data dictionary - resource schema
                        @html.details do
                            @html.summary('Resource Entities', {'class'=>'h4'})
                            if !aDictEnt.empty?
                                aDictEnt.each do |hEntity|
                                    @html.blockquote do
                                        @html.details do
                                            @html.summary(hEntity[:entityCode], {'class'=>'h5'})
                                            htmlEntity.writeHtml(hEntity)
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
