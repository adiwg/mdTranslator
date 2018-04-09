# ISO <<Class>> BaseUnit
# writer output in XML

# History:
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
# 	Stan Smith 2014-12-03 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19110

            class BaseUnit

               def initialize(xml, responseObj)
                  @xml = xml
                  @hResponseObj = responseObj
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
