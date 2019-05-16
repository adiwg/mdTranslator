# GML Identifier
# 19115-1 writer output in XML

# History:
#  Stan Smith 2019-03-19 original script.

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class GMLIdentifier

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hGMLid)

                  namespace = hGMLid[:namespace]
                  identifier = hGMLid[:identifier]

                  @xml.tag!('gml:identifier', {'codeSpace' => namespace}, identifier)

               end # writeXML
            end # GMLIdentifier class

         end
      end
   end
end
