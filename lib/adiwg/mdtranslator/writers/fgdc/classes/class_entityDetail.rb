# FGDC <<Class>> EntityDetail
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-03-17 refactored error and warning messaging
#  Stan Smith 2018-01-22 original script

require_relative '../fgdc_writer'
require_relative 'class_attribute'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class EntityDetail

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(hEntity, inContext = nil)
                  
                  # classes used
                  attrClass = Attribute.new(@xml, @hResponseObj)

                  # set context
                  outContext = hEntity[:entityCode]
                  outContext = 'entity code ' + outContext unless outContext.nil?

                  # entity detail 5.1.1 (enttype) - entity type
                  @xml.tag!('enttype') do

                     # entity type 5.1.1.1 (enttypl) - entity type label (required)
                     # <- entity.entityCode
                     unless hEntity[:entityCode].nil?
                        @xml.tag!('enttypl', hEntity[:entityCode])
                     end
                     if hEntity[:entityCode].nil?
                        @NameSpace.issueWarning(90, 'enttypl', inContext)
                     end

                     # entity type 5.1.1.2 (enttypd) - entity type definition (required)
                     # <- entity.entityDefinition
                     unless hEntity[:entityDefinition].nil?
                        @xml.tag!('enttypd', hEntity[:entityDefinition])
                     end
                     if hEntity[:entityDefinition].nil?
                        @NameSpace.issueWarning(91, 'enttypd', inContext)
                     end

                     # entity type 5.1.1.3 (enttypds) - entity definition source (required)
                     # <- take title from first entityReference {citation}
                     unless hEntity[:entityReferences].empty?
                        unless hEntity[:entityReferences][0].empty?
                           @xml.tag!('enttypds', hEntity[:entityReferences][0][:title])
                        end
                     end
                     if hEntity[:entityReferences].empty?
                        @NameSpace.issueWarning(92, 'enttypds', inContext)
                     end

                  end

                  # attribute 5.1.2 (attr) - attribute
                  hEntity[:attributes].each do |hAttribute|
                     unless hAttribute.empty?
                        @xml.tag!('attr') do
                           attrClass.writeXML(hAttribute, outContext)
                        end
                     end
                  end

               end # writeXML
            end # EntityOverview

         end
      end
   end
end
