# ISO <<Class>> MD_Constraint
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-03-15 original script

require_relative 'class_useConstraints'
require_relative 'class_legalConstraints'
require_relative 'class_securityConstraints'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class Constraint

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hConstraint, inContext = nil)

                  # classes used
                  useConClass = MD_Constraints.new(@xml, @hResponseObj)
                  legalConClass = MD_LegalConstraints.new(@xml, @hResponseObj)
                  securityConClass = MD_SecurityConstraints.new(@xml, @hResponseObj)

                  useConClass.writeXML(hConstraint, inContext) if hConstraint[:type] == 'use'
                  legalConClass.writeXML(hConstraint, inContext) if hConstraint[:type] == 'legal'
                  securityConClass.writeXML(hConstraint, inContext) if hConstraint[:type] == 'security'

               end # writeXML
            end # MD_Constraint class

         end
      end
   end
end
