# ISO <<Class>> BaseUnit
# 19115-2 writer output in XML

# History:
# 	Stan Smith 2015-08-27 copied from 19110 writer

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class BaseUnit

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hBase)

                  # create and identity for the unit
                  @hResponseObj[:writerMissingIdCount] = @hResponseObj[:writerMissingIdCount].succ
                  unitID = 'unit' + @hResponseObj[:writerMissingIdCount]
                  @xml.tag!('gml:BaseUnit', {'gml:id' => unitID}) do
                     @xml.tag!('gml:identifier', {'codeSpace' => hBase[:codeSpace]}, hBase[:identifier])
                     @xml.tag!('gml:name', hBase[:name])
                     @xml.tag!('gml:catalogSymbol', hBase[:catalogSymbol])
                     @xml.tag!('gml:unitsSystem', {'xlink:href' => hBase[:unitsSystem]})
                  end

               end

            end

         end
      end
   end
end
