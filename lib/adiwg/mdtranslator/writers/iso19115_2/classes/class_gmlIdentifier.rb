# GML Identifier
# 19115-2 writer output in XML

# History:
#   Stan Smith 2016-12-01 original script.

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

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
