# FGDC <<Class>> EntityDetail
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-01-22 original script

require_relative 'class_attribute'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class EntityDetail

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hEntity)

                  # classes used
                  attrClass = Attribute.new(@xml, @hResponseObj)

                  # entity detail 5.1.1 (enttype) - entity type
                  @xml.tag!('enttype') do

                     # entity type 5.1.1.1 (enttypl) - entity type label (required)
                     # <- entity.entityCode
                  unless hEntity[:entityCode].nil?
                        @xml.tag!('enttypl', hEntity[:entityCode])
                     end
                     if hEntity[:entityCode].nil?
                        @hResponseObj[:writerPass] = false
                        @hResponseObj[:writerMessages] << 'Entity Attribute Detail missing entity type label'
                     end

                     # entity type 5.1.1.2 (enttypd) - entity type definition (required)
                     # <- entity.entityDefinition
                  unless hEntity[:entityDefinition].nil?
                        @xml.tag!('enttypd', hEntity[:entityDefinition])
                     end
                     if hEntity[:entityDefinition].nil?
                        @hResponseObj[:writerPass] = false
                        @hResponseObj[:writerMessages] << 'Entity Attribute Detail missing entity definition'
                     end

                     # entity type 5.1.1.3 (enttypds) - entity definition source (required)
                     # <- take title from first entityReference {citation}
                     unless hEntity[:entityReferences].empty?
                        unless hEntity[:entityReferences][0].empty?
                           @xml.tag!('enttypds', hEntity[:entityReferences][0][:title])
                        end
                     end
                     if hEntity[:entityReferences].empty?
                        @hResponseObj[:writerPass] = false
                        @hResponseObj[:writerMessages] << 'Entity Attribute Detail missing entity definition citation'
                     end

                  end

                  # attribute 5.1.2 (attr) - attribute
                  hEntity[:attributes].each do |hAttribute|
                     unless hAttribute.empty?
                        @xml.tag!('attr') do
                           attrClass.writeXML(hAttribute)
                        end
                     end
                  end

               end # writeXML
            end # EntityOverview

         end
      end
   end
end
