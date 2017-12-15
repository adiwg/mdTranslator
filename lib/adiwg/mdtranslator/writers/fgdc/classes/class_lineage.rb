# FGDC <<Class>> Quality
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2017-12-15 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class Lineage

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(aLineage)



               end # writeXML
            end # lineage

         end
      end
   end
end
