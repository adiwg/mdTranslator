# HTML writer
# data dictionary entity

# History:
# 	Stan Smith 2015-03-26 original script

require 'html_entityIndex'
require 'html_entityAttribute'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlDictionaryEntity
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hEntity)

                        # classes used
                        htmlEntIndex = $HtmlNS::MdHtmlEntityIndex.new(@html)
                        htmlEntAttrib = $HtmlNS::MdHtmlEntityAttribute.new(@html)

                        # entity - user assigned entity id
                        s = hEntity[:entityId]
                        if !s.nil?
                            @html.em('Entity ID: ')
                            @html.text!(s)
                            @html.br
                        end

                        # entity - common name
                        s = hEntity[:entityName]
                        if !s.nil?
                            @html.em('Common name: ')
                            @html.text!(s)
                            @html.br
                        end

                        # entity - code
                        s = hEntity[:entityCode]
                        if !s.nil?
                            @html.em('Code name: ')
                            @html.text!(s)
                            @html.br
                        end

                        # entity - alias names
                        aAlias = hEntity[:entityAlias]
                        if !aAlias.empty?
                            @html.em('Entity aliases: ')
                            @html.section(:class=>'block') do
                                @html.text!(aAlias.to_s)
                            end
                        end

                        # entity - definition
                        s = hEntity[:entityDefinition]
                        if !s.nil?
                            @html.em('Definition: ')
                            @html.section(:class=>'block') do
                                @html.text!(s.to_s)
                            end
                        end

                        # entity - primary key
                        aPK = hEntity[:primaryKey]
                        if !aPK.empty?
                            @html.em('Primary key: ')
                            @html.text!(aPK.to_s)
                            @html.br
                        end

                        # entity - other indexes
                        aIndex = hEntity[:indexes]
                        if !aIndex.empty?
                            aIndex.each do |hIndex|
                                @html.em('Index: ')
                                @html.section(:class=>'block') do
                                    htmlEntIndex.writeHtml(hIndex)
                                end
                            end
                        end

                        # entity - attributes
                        aAttributes = hEntity[:attributes]
                        if !aAttributes.empty?
                            @html.em('Attribute List: ')
                            aAttributes.each do |hAttribute|
                                @html.section(:class=>'block') do
                                    @html.details do
                                        @html.summary(hAttribute[:attributeCode], {'class'=>'h5'})
                                        @html.section(:class=>'block') do
                                            htmlEntAttrib.writeHtml(hAttribute)
                                        end
                                    end
                                end
                            end
                        end

                        # entity - foreign keys
                        aFKs = hEntity[:foreignKeys]
                        if !aFKs.empty?
                            aFKs.each do |hFK|
                                @html.em('Foreign Key: ')
                                @html.section(:class=>'block') do

                                    # foreign key - local attribute list
                                    @html.em('Local attribute: ')
                                    @html.text!(hFK[:fkLocalAttributes].to_s)
                                    @html.br

                                    # foreign key - referenced entity
                                    @html.em('Referenced entity: ')
                                    @html.text!(hFK[:fkReferencedEntity])
                                    @html.br

                                    # foreign key - referenced attribute list
                                    @html.em('Referenced attribute: ')
                                    @html.text!(hFK[:fkReferencedAttributes].to_s)
                                    @html.br

                                end

                            end
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
