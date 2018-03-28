# FGDC <<Class>> EntityOverview
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-02-26 refactored error and warning messaging
#  Stan Smith 2018-01-22 original script

require_relative '../fgdc_writer'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class EntityOverview

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(hEntity, inContext = nil)
                  
                  # entity overview 5.2.1 (eaover) - entity and attribute overview (required)
                  # <- entity.definition
                  unless hEntity[:entityDefinition].nil?
                     @xml.tag!('eaover', hEntity[:entityDefinition])
                  end
                  if hEntity[:entityDefinition].nil?
                     @NameSpace.issueWarning(100, 'eaover', inContext)
                  end

                  # entity overview 5.2.2 (eadetcit) - entity and attribute detail citation []
                  # <- entity.entityReferences[]
                  hEntity[:entityReferences].each do |hCitation|
                     unless hCitation.empty?
                        @xml.tag!('eadetcit', hCitation[:title])
                     end
                  end
                  if hEntity[:entityReferences].empty? && @hResponseObj[:writerShowTags]
                     @xml.tag!('eadetcit')
                  end

               end # writeXML
            end # EntityOverview

         end
      end
   end
end
