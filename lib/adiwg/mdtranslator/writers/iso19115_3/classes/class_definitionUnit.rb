# ISO <<Class>> UnitDefinition
# 19115-3 writer output in XML

# History:
# 	Stan Smith 2019-04-08 copied from 19115_2 writer

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class UnitDefinition

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(unit)

                  # create an identity for the unit
                  @hResponseObj[:writerMissingIdCount] = @hResponseObj[:writerMissingIdCount].succ
                  unitID = 'unit' + @hResponseObj[:writerMissingIdCount]
                  @xml.tag!('gml:UnitDefinition', {'gml:id' => unitID}) do
                     @xml.tag!('gml:identifier', {'codeSpace' => ''}, unit)
                  end

               end

            end

         end
      end
   end
end
