# ISO <<Class>> MD_Constraints (Use Constraint)
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-03-18 original script

require_relative 'class_constraintCommon'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class MD_Constraints

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hConstraint, inContext = nil)

                  # classes used
                  commonClass = ConstraintCommon.new(@xml, @hResponseObj)

                  outContext = 'use constraint'
                  outContext = inContext + ' use constraint' unless inContext.nil?

                  @xml.tag!('mco:MD_Constraints') do
                     unless hConstraint.empty?
                        commonClass.writeXML(hConstraint, outContext)
                     end
                  end

               end # writeXML
            end # MD_Constraints class

         end
      end
   end
end
