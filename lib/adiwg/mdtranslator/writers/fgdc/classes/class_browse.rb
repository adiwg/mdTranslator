# FGDC <<Class>> Browse
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-02-26 refactored error and warning messaging
#  Stan Smith 2017-12-12 original script

require_relative '../fgdc_writer'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class Browse

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(hGraphic, inContext = nil)

                  # browse 1.10.1 (browsen) - browse name (required)
                  unless hGraphic[:graphicName].nil?
                     @xml.tag!('browsen', hGraphic[:graphicName])
                  end
                  if hGraphic[:graphicName].nil?
                     @NameSpace.issueWarning(20, 'browsen', inContext)
                  end

                  # browse 1.10.2 (browsed) - browse description (required)
                  unless hGraphic[:graphicDescription].nil?
                     @xml.tag!('browsed', hGraphic[:graphicDescription])
                  end
                  if hGraphic[:graphicDescription].nil?
                     @NameSpace.issueWarning(21, 'browsed', inContext)
                  end

                  # browse 1.10.3 (browset) - browse type (required)
                  unless hGraphic[:graphicType].nil?
                     @xml.tag!('browset', hGraphic[:graphicType])
                  end
                  if hGraphic[:graphicType].nil?
                     @NameSpace.issueWarning(22, 'browset', inContext)
                  end

               end # writeXML
            end # Browse

         end
      end
   end
end
