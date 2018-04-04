# FGDC <<Class>> SpatialReference
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-03-20 refactored error and warning messaging
#  Stan Smith 2018-01-15 original script

require_relative '../fgdc_writer'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class LocalSystem

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(hProjection)

                  # localSYSTEM is not the same as localPLANAR in fgdc
                  # however the same projection parameters are used in mdJson to save info
                  # local system sets projection = 'localSystem'
                  # local planar sets projection = 'localPlanar'

                  if hProjection[:projectionName].nil?
                     hProjection[:projectionName] = 'local coordinate system not aligned with surface of earth'
                  end

                  # local system 4.1.3.1 (localdes) - local coordinate system description (required)
                  unless hProjection[:localPlanarDescription].nil?
                     @xml.tag!('localdes', hProjection[:localPlanarDescription])
                  end
                  if hProjection[:localPlanarDescription].nil?
                     @NameSpace.issueError(250, hProjection[:projectionName])
                  end

                  # local system 4.1.3.2 (localgeo) - local coordinate system georeference information (required)
                  unless hProjection[:localPlanarGeoreference].nil?
                     @xml.tag!('localgeo', hProjection[:localPlanarGeoreference])
                  end
                  if hProjection[:localPlanarGeoreference].nil?
                     @NameSpace.issueError(251, hProjection[:projectionName])
                  end

               end # writeXML
            end # LocalSystem

         end
      end
   end
end
