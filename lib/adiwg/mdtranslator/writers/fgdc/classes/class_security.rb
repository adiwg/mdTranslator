# FGDC <<Class>> Security
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-03-23 refactored error and warning messaging
#  Stan Smith 2017-12-12 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class Security

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(aConstraints)

                  # <- resourceInfo.constraints. first type = security
                  haveSecurity = false
                  aConstraints.each do |hConstraint|
                     if hConstraint[:type] == 'security'
                        hSecurity = hConstraint[:securityConstraint]
                        @xml.tag!('secinfo') do
                           haveSecurity = true

                           # security 1.12.1 (secsys) - security system name (required)
                           unless hSecurity[:classSystem].nil?
                              @xml.tag!('secsys', hSecurity[:classSystem])
                           end
                           if hSecurity[:classSystem].nil?
                              @NameSpace.issueWarning(340, 'secsys', 'identification information section')
                           end

                           # security 1.12.2 (secclass) - security classification (required)
                           unless hSecurity[:classCode].nil?
                              @xml.tag!('secclass', hSecurity[:classCode])
                           end
                           if hSecurity[:classCode].nil?
                              @NameSpace.issueWarning(341, 'secclass', 'identification information section')
                           end

                           # security 1.12.3 (sechandl) - security classification (required)
                           unless hSecurity[:handling].nil?
                              @xml.tag!('sechandl', hSecurity[:handling])
                           end
                           if hSecurity[:handling].nil?
                              @NameSpace.issueWarning(342, 'sechandl', 'identification information section')
                           end

                        end
                     end
                  end
                  if !haveSecurity && @hResponseObj[:writerShowTags]
                     @xml.tag!('secinfo')
                  end

               end # writeXML
            end # Security

         end
      end
   end
end
