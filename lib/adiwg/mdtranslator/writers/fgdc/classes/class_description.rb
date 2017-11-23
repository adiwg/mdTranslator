# FGDC <<Class>> Description
# FGDC CSDGM writer output in XML

# History:
#   Stan Smith 2017-11-22 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class Description

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hResourceInfo)

                  # description 1.2.1 (abstract) - abstract (required)
                  # <- hResourceInfo[:abstract] (required)
                  unless hResourceInfo[:abstract].nil?
                     @xml.tag!('abstract', hResourceInfo[:abstract])
                  end

                  # description 1.2.2 (purpose) - purpose (required)
                  # <- hResourceInfo[:purpose] (required)
                  unless hResourceInfo[:purpose].nil?
                     @xml.tag!('purpose', hResourceInfo[:purpose])
                  end
                  if hResourceInfo[:purpose].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Description is missing purpose'
                  end

                  # description 1.2.2 (supplinf) - supplemental information (required)
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
