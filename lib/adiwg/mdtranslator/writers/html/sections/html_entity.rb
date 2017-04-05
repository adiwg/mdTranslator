# HTML writer
# entity

# History:
#  Stan Smith 2017-04-05 refactored for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
# 	Stan Smith 2015-03-26 original script

require_relative 'html_entityIndex'
require_relative 'html_entityAttribute'

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

                  @html.text!('Nothing Yet')


                  # # entity - user assigned entity id
                  # s = hEntity[:entityId]
                  # if !s.nil?
                  #    @html.em('Entity ID: ')
                  #    @html.text!(s)
                  #    @html.br
                  # end
                  #
                  # # entity - common name
                  # s = hEntity[:entityName]
                  # if !s.nil?
                  #    @html.em('Common name: ')
                  #    @html.text!(s)
                  #    @html.br
                  # end
                  #
                  # # entity - code
                  # s = hEntity[:entityCode]
                  # if !s.nil?
                  #    @html.em('Code name: ')
                  #    @html.text!(s)
                  #    @html.br
                  # end
                  #
                  # # entity - alias names
                  # aAlias = hEntity[:entityAlias]
                  # if !aAlias.empty?
                  #    @html.em('Entity aliases: ')
                  #    @html.section(:class => 'block') do
                  #       @html.text!(aAlias.to_s)
                  #    end
                  # end
                  #
                  # # entity - definition
                  # s = hEntity[:entityDefinition]
                  # if !s.nil?
                  #    @html.em('Definition: ')
                  #    @html.section(:class => 'block') do
                  #       @html.text!(s.to_s)
                  #    end
                  # end
                  #
                  # # entity - primary key
                  # aPK = hEntity[:primaryKey]
                  # if !aPK.empty?
                  #    @html.em('Primary key: ')
                  #    @html.text!(aPK.to_s)
                  #    @html.br
                  # end
                  #
                  # # entity - other indexes
                  # aIndex = hEntity[:indexes]
                  # if !aIndex.empty?
                  #    aIndex.each do |hIndex|
                  #       @html.em('Index: ')
                  #       @html.section(:class => 'block') do
                  #          indexClass.writeHtml(hIndex)
                  #       end
                  #    end
                  # end
                  #
                  # # entity - attributes
                  # aAttributes = hEntity[:attributes]
                  # if !aAttributes.empty?
                  #    @html.em('Attribute List: ')
                  #    aAttributes.each do |hAttribute|
                  #       @html.section(:class => 'block') do
                  #          @html.details do
                  #             @html.summary(hAttribute[:attributeCode], {'class' => 'h5'})
                  #             @html.section(:class => 'block') do
                  #                attributeClass.writeHtml(hAttribute)
                  #             end
                  #          end
                  #       end
                  #    end
                  # end


               end # writeHtml
            end # Html_Entity

         end
      end
   end
end
