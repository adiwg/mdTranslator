# FGDC <<Class>> Browse
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2017-12-12 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class Browse

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hGraphic)

                  # browse 1.10.1 (browsen) - browse name (required)
                  unless hGraphic[:graphicName].nil?
                     @xml.tag!('browsen', hGraphic[:graphicName])
                  end
                  if hGraphic[:graphicName].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Browse Graphic is missing name'
                  end

                  # browse 1.10.2 (browsed) - browse description (required)
                  unless hGraphic[:graphicDescription].nil?
                     @xml.tag!('browsed', hGraphic[:graphicDescription])
                  end
                  if hGraphic[:graphicDescription].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Browse Graphic is missing description'
                  end

                  # browse 1.10.3 (browset) - browse type (required)
                  unless hGraphic[:graphicType].nil?
                     @xml.tag!('browset', hGraphic[:graphicType])
                  end
                  if hGraphic[:graphicType].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Browse Graphic is missing file type'
                  end

               end # writeXML
            end # Browse

         end
      end
   end
end
