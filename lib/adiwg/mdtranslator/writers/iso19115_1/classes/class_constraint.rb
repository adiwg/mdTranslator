# ISO <<Class>> MD_Constraint
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-03-15 original script

require_relative '../iso19115_1_writer'
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
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_1
               end

               def writeXML(hConstraint, inContext = nil)

                  outContext = 'constraint'
                  outContext = inContext + ' constraint' unless inContext.nil?

                  # classes used
                  useConClass = MD_Constraints.new(@xml, @hResponseObj)
                  legalConClass = MD_LegalConstraints.new(@xml, @hResponseObj)
                  securityConClass = MD_SecurityConstraints.new(@xml, @hResponseObj)

                  if hConstraint[:type] == 'use'
                     useConClass.writeXML(hConstraint, outContext)
                  elsif hConstraint[:type] == 'legal'
                     legalConClass.writeXML(hConstraint, outContext)
                  elsif hConstraint[:type] == 'security'
                     securityConClass.writeXML(hConstraint, outContext)
                  else
                     @NameSpace.issueWarning(293, nil, outContext + " type = #{hConstraint[:type]}")
                  end

               end # writeXML
            end # MD_Constraint class

         end
      end
   end
end
