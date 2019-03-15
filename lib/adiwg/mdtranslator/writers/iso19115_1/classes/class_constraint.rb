# ISO <<Class>> MD_Constraint
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-03-15 original script

require_relative 'class_releasability'
require_relative 'class_legalConstraint'
require_relative 'class_securityConstraint'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class MD_Constraint

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hConstraint, inContext = nil)

                  # classes used
                  releaseClass = MD_Releasability.new(@xml, @hResponseObj)
                  legalClass = MD_Releasability.new(@xml, @hResponseObj)
                  releaseClass = MD_Releasability.new(@xml, @hResponseObj)

                  @xml.tag!('mco:MD_Constraint') do


                  end # gmd:EX_Extent tag
               end # writeXML
            end # EX_Extent class

         end
      end
   end
end
