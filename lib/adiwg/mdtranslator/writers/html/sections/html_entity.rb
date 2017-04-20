# HTML writer
# entity

# History:
#  Stan Smith 2017-04-05 refactored for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
# 	Stan Smith 2015-03-26 original script

require_relative 'html_entityIndex'
require_relative 'html_entityAttribute'
require_relative 'html_entityForeignKey'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_Entity

               def initialize(html)
                  @html = html
               end

               def writeHtml(hEntity)

                  # classes used
                  indexClass = Html_EntityIndex.new(@html)
                  attributeClass = Html_EntityAttribute.new(@html)
                  foreignClass = Html_EntityForeignKey.new(@html)

                  # entity - entity id
                  unless hEntity[:entityId].nil?
                     @html.em('ID: ')
                     @html.text!(hEntity[:entityId])
                     @html.br
                  end

                  # entity - name
                  unless hEntity[:entityName].nil?
                     @html.em('Name: ')
                     @html.text!(hEntity[:entityName])
                     @html.br
                  end

                  # entity - code
                  unless hEntity[:entityCode].nil?
                     @html.em('Code: ')
                     @html.text!(hEntity[:entityCode])
                     @html.br
                  end

                  # entity - alias names
                  hEntity[:entityAlias].each do |otherName|
                     @html.em('Alias: ')
                     @html.section(:class => 'block') do
                        @html.text!(otherName)
                     end
                  end

                  # entity - definition
                  unless hEntity[:entityDefinition].nil?
                     @html.em('Definition: ')
                     @html.section(:class => 'block') do
                        @html.text!(hEntity[:entityDefinition])
                     end
                  end

                  # entity - primary key
                  unless hEntity[:primaryKey].empty?
                     @html.em('Primary Key Attribute(s):')
                     @html.section(:class => 'block') do
                        hEntity[:primaryKey].each do |attribute|
                           @html.text!(attribute)
                           @html.br
                        end
                     end
                  end

                  # entity - indexes [] {entityIndex}
                  hEntity[:indexes].each do |hIndex|
                     @html.details do
                        @html.summary('Index: '+hIndex[:indexCode], {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           indexClass.writeHtml(hIndex)
                        end
                     end
                  end

                  # entity - attributes [] {entityAttribute}
                  hEntity[:attributes].each do |hAttribute|
                     @html.details do
                        @html.summary('Attribute: '+hAttribute[:attributeCode], {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           attributeClass.writeHtml(hAttribute)
                        end
                     end
                  end

                  # entity - foreign keys [] {entityForeignKey}
                  hEntity[:foreignKeys].each do |hForeign|
                     @html.details do
                        @html.summary('ForeignKey', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           foreignClass.writeHtml(hForeign)
                        end
                     end
                  end

               end # writeHtml
            end # Html_Entity

         end
      end
   end
end
