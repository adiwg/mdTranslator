# FGDC <<Class>> Distribution
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-01-28 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class Distribution

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hDistributor)

                  # distribution 6.1 (distrib) - distributor {contact} (required)
                  # <- distribution.distributor[0].contact{}.responsibility.roleName = 'distributor'

                  # distribution 6.2 (resdesc) - resource description
                  # <- distribution.description

                  # distribution 6.3 (distliab) - liability (required)
                  # <- distribution.liabilityStatement

                  # distribution 6.4 (stdorder) - standard order [] {standardOrder}
                  # <- distribution.distributor[0].orderProcess[]

                  # distribution 6.5 (custom) - custom order process
                  # <- distribution.distributor[0].contact{}

                  # distribution 6.6 (techpreq) - technical prerequisites
                  # <- distribution.technicalPrerequisite

                  # distribution 6.7 (availabl) - available timePeriod  {timePeriod}
                  # <- distribution.distributor[0].contact{}


               end # writeXML
            end # Distribution

         end
      end
   end
end
