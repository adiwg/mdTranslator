# HTML writer
# entity attribute

# History:
# 	Stan Smith 2015-03-26 original script

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlEntityAttribute
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hAttribute)

                        # entity attribute - common name
                        s = hAttribute[:attributeName]
                        if !s.nil?
                            @html.em('Common name: ')
                            @html.text!(s)
                            @html.br
                        end

                        # entity attribute - code name
                        s = hAttribute[:attributeCode]
                        if !s.nil?
                            @html.em('Code name: ')
                            @html.text!(s)
                            @html.br
                        end

                        # entity attribute - aliases
                        aAliases = hAttribute[:attributeAlias]
                        if !aAliases.empty?
                            @html.em('Aliases: ')
                            @html.text!(aAliases.to_s)
                            @html.br
                        end

                        # entity attribute - definition
                        s = hAttribute[:attributeDefinition]
                        if !s.nil?
                            @html.em('Definition: ')
                            @html.blockquote do
                                @html.text!(s)
                            end
                        end

                        # entity attribute - datatype
                        s = hAttribute[:dataType]
                        if !s.nil?
                            @html.em('Datatype: ')
                            @html.text!(s)
                            @html.br
                        end

                        # entity attribute - allow nulls
                        b = hAttribute[:allowNull]
                        if !b.nil?
                            @html.em('Allow null values: ')
                            @html.text!(b.to_s)
                            @html.br
                        end

                        # entity attribute - unit of measure
                        s = hAttribute[:unitOfMeasure]
                        if !s.nil?
                            @html.em('Unit of measure: ')
                            @html.text!(s)
                            @html.br
                        end

                        # entity attribute - domain ID
                        s = hAttribute[:domainId]
                        if !s.nil?
                            @html.em('Domain ID: ')
                            @html.text!(s)
                            @html.br
                        end

                        # entity attribute - minimum value
                        s = hAttribute[:minValue]
                        if !s.nil?
                            @html.em('Minimum value: ')
                            @html.text!(s.to_s)
                            @html.br
                        end

                        # entity attribute - code name
                        s = hAttribute[:maxValue]
                        if !s.nil?
                            @html.em('Maximum value: ')
                            @html.text!(s.to_s)
                            @html.br
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
