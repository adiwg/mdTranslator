# HTML writer
# data attribute

# History:
#  Stan Smith 2017-04-05 refactored for mdTranslator 2.0
# 	Stan Smith 2015-03-26 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_EntityAttribute

               def initialize(html)
                  @html = html
               end

               def writeHtml(hAttribute)

                  # entity attribute - common name
                  unless hAttribute[:attributeName].nil?
                     @html.em('Name: ')
                     @html.text!(hAttribute[:attributeName])
                     @html.br
                  end

                  # entity attribute - code name
                  unless hAttribute[:attributeCode].nil?
                     @html.em('Code: ')
                     @html.text!(hAttribute[:attributeCode])
                     @html.br
                  end

                  # entity attribute - aliases
                  hAttribute[:attributeAlias].each do |otherName|
                     @html.em('Alias: ')
                     @html.text!(otherName)
                     @html.br
                  end

                  # entity attribute - definition
                  unless hAttribute[:attributeDefinition].nil?
                     @html.em('Definition: ')
                     @html.section(:class => 'block') do
                        @html.text!(hAttribute[:attributeDefinition])
                     end
                  end

                  # entity attribute - datatype
                  unless hAttribute[:dataType].nil?
                     @html.em('Datatype: ')
                     @html.text!(hAttribute[:dataType])
                     @html.br
                  end

                  # entity attribute - allow nulls {Boolean}
                  @html.em('Allow NULL Values: ')
                  @html.text!(hAttribute[:allowNull].to_s)
                  @html.br

                  # entity attribute - allow many {Boolean}
                  @html.em('Allow Many Values: ')
                  @html.text!(hAttribute[:allowMany].to_s)
                  @html.br

                  # entity attribute - unit of measure
                  unless hAttribute[:unitOfMeasure].nil?
                     @html.em('Unit of Measure: ')
                     @html.text!(hAttribute[:unitOfMeasure])
                     @html.br
                  end

                  # entity attribute - domain ID
                  unless hAttribute[:domainId].nil?
                     @html.em('Domain ID: ')
                     @html.text!(hAttribute[:domainId])
                     @html.br
                  end

                  # entity attribute - minimum value
                  unless hAttribute[:minValue].nil?
                     @html.em('Minimum Value: ')
                     @html.text!(hAttribute[:minValue].to_s)
                     @html.br
                  end

                  # entity attribute - code name
                  unless hAttribute[:maxValue].nil?
                     @html.em('Maximum Value: ')
                     @html.text!(hAttribute[:maxValue].to_s)
                     @html.br
                  end

               end # writeHtml
            end # Html_EntityAttribute

         end
      end
   end
end
