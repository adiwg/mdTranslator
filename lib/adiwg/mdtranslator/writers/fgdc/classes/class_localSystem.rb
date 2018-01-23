# FGDC <<Class>> SpatialReference
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-01-15 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class LocalSystem

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hProjection)

                  # local system (local) - local coordinate system description (required)
                  unless hProjection[:localPlanarDescription].nil?
                     @xml.tag!('localdes', hProjection[:localPlanarDescription])
                  end
                  if hProjection[:localPlanarDescription].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Local Coordinate System is missing description'
                  end

                  # local system (local) - local coordinate system georeference information (required)
                  unless hProjection[:localPlanarGeoreference].nil?
                     @xml.tag!('localgeo', hProjection[:localPlanarGeoreference])
                  end
                  if hProjection[:localPlanarGeoreference].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Local Coordinate System is missing georeference information'
                  end

               end # writeXML
            end # LocalSystem

         end
      end
   end
end
