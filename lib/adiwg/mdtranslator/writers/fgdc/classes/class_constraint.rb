# FGDC <<Class>> Constraint
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-02-26 refactored error and warning messaging
#  Stan Smith 2017-12-12 original script

require_relative '../fgdc_writer'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class Constraint

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(aConstraints)

                  # <- resourceInfo.constraints. first type = legal
                  aConstraints.each do |hConstraint|
                     if hConstraint[:type] == 'legal'
                        hLegal = hConstraint[:legalConstraint]

                        # identification information 1.7 (accconst) - access constraint (required)
                        unless hLegal[:accessCodes].empty?
                           @xml.tag!('accconst', hLegal[:accessCodes][0])
                        end
                        if hLegal[:accessCodes].empty?
                           @NameSpace.issueWarning(40, 'accconst', 'identification section')
                        end

                        # identification information 1.8 (useconst) - use constraint (required)
                        unless hLegal[:useCodes].empty?
                           @xml.tag!('useconst', hLegal[:useCodes][0])
                        end
                        if hLegal[:useCodes].empty?
                           @NameSpace.issueWarning(41,'useconst', 'identification section')
                        end

                     end
                  end

               end # writeXML
            end # Constraint

         end
      end
   end
end
