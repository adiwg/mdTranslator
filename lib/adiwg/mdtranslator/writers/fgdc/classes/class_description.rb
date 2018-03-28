# FGDC <<Class>> Description
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-03-16 refactored error and warning messaging
#  Stan Smith 2017-11-22 original script

require_relative '../fgdc_writer'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class Description

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(hResourceInfo)
                  
                  # description 1.2.1 (abstract) - abstract (required)
                  # <- hResourceInfo[:abstract] (required)
                  unless hResourceInfo[:abstract].nil?
                     @xml.tag!('abstract', hResourceInfo[:abstract])
                  end
                  if hResourceInfo[:abstract].nil?
                     @NameSpace.issueWarning(60,'abstract', 'identification section')
                  end

                  # description 1.2.2 (purpose) - purpose (required)
                  # <- hResourceInfo[:purpose] (required)
                  unless hResourceInfo[:purpose].nil?
                     @xml.tag!('purpose', hResourceInfo[:purpose])
                  end
                  if hResourceInfo[:purpose].nil?
                     @NameSpace.issueWarning(61,'purpose', 'identification section')
                  end

                  # description 1.2.3 (supplinf) - supplemental information
                  # <- hResourceInfo[:supplementalInfo]
                  unless hResourceInfo[:supplementalInfo].nil?
                     @xml.tag!('supplinf', hResourceInfo[:supplementalInfo])
                  end

               end # writeXML
            end # Description

         end
      end
   end
end
