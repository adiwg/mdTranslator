# HTML writer
# entity

# History:
#  Stan Smith 2017-11-03 added new elements to support fgdc
#  Stan Smith 2017-04-05 refactored for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
# 	Stan Smith 2015-03-26 original script

require_relative 'html_entityIndex'
require_relative 'html_entityAttribute'
require_relative 'html_entityForeignKey'
require_relative 'html_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module SimpleHtml

            class Html_Entity

               def initialize(html)
                  @html = html
               end

               def writeHtml(aEntities)

                  # classes used
                  indexClass = Html_EntityIndex.new(@html)
                  attributeClass = Html_EntityAttribute.new(@html)
                  foreignClass = Html_EntityForeignKey.new(@html)
                  citationClass = Html_Citation.new(@html)

                  aEntities.each do |hEntity|

                     eName = 'entity'
                     eName = hEntity[:entityCode] unless hEntity[:entityCode].nil?
                     eName = hEntity[:entityName] unless hEntity[:entityName].nil?

                     @html.div do
                        @html.div(eName, {'class' => 'h5'})
                        @html.div(:class => 'block') do

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
                              @html.div(:class => 'block') do
                                 @html.text!(otherName)
                              end
                           end

                           # entity - definition
                           unless hEntity[:entityDefinition].nil?
                              @html.em('Definition: ')
                              @html.div(:class => 'block') do
                                 @html.text!(hEntity[:entityDefinition])
                              end
                           end

                           # entity - primary key
                           unless hEntity[:primaryKey].empty?
                              @html.em('Primary Key Attribute(s):')
                              @html.div(:class => 'block') do
                                 hEntity[:primaryKey].each do |attribute|
                                    @html.text!(attribute)
                                    @html.br
                                 end
                              end
                           end

                           # entity - field separator character
                           unless hEntity[:fieldSeparatorCharacter].nil?
                              @html.em('Field Separator Character: ')
                              @html.text!(hEntity[:fieldSeparatorCharacter])
                              @html.br
                           end

                           # entity - number of header lines
                           unless hEntity[:numberOfHeaderLines].nil?
                              @html.em('Number of Header Lines: ')
                              @html.text!(hEntity[:numberOfHeaderLines].to_s)
                              @html.br
                           end

                           # entity - quote character
                           unless hEntity[:quoteCharacter].nil?
                              @html.em('Quote Character: ')
                              @html.text!(hEntity[:quoteCharacter])
                              @html.br
                           end

                           # entity - indexes [] {entityIndex}
                           hEntity[:indexes].each do |hIndex|
                              iName = 'index'
                              iName = hIndex[:indexCode] unless hIndex[:indexCode].nil?
                              iName = hIndex[:indexName] unless hIndex[:indexName].nil?
                              @html.div do
                                 @html.div('Index: '+iName, {'class' => 'h5'})
                                 @html.div(:class => 'block') do
                                    indexClass.writeHtml(hIndex)
                                 end
                              end
                           end

                           # entity - foreign keys [] {entityForeignKey}
                           hEntity[:foreignKeys].each do |hForeign|
                              @html.div do
                                 @html.div('ForeignKey', {'class' => 'h5'})
                                 @html.div(:class => 'block') do
                                    foreignClass.writeHtml(hForeign)
                                 end
                              end
                           end

                           # entity - entity reference [] {citation}
                           hEntity[:entityReferences].each do |hReference|
                              @html.div do
                                 @html.div('Reference', {'class' => 'h5'})
                                 @html.div(:class => 'block') do
                                    citationClass.writeHtml(hReference)
                                 end
                              end
                           end

                           # entity - attributes [] {entityAttribute}
                           hEntity[:attributes].each do |hAttribute|
                              aName = 'attribute'
                              aName = hAttribute[:attributeCode] unless hAttribute[:attributeCode].nil?
                              aName = hAttribute[:attributeName] unless hAttribute[:attributeName].nil?
                              @html.div do
                                 @html.div('Attribute: '+aName, {'class' => 'h5'})
                                 @html.div(:class => 'block') do
                                    attributeClass.writeHtml(hAttribute)
                                 end
                              end
                           end

                        end
                     end

                  end # aEntity
               end # writeHtml
            end # Html_Entity

         end
      end
   end
end
