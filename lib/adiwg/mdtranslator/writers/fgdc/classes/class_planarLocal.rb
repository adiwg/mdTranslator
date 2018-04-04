# FGDC <<Class>> PlanarReference
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-03-21 original script

require_relative 'class_mapProjectionTags'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class PlanarLocal

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hProjection)

                  # classes used
                  classTags = MapProjectionTags.new(@xml, @hResponseObj)

                  # planar 4.1.2.3 (localp) - local planar
                  projection = hProjection[:projection]
                  if projection == 'localPlanar'
                     hProjection[:projectionName] = 'local right-handed planar coordinate system'
                     @xml.tag!('localp') do
                        classTags.write_localDesc(hProjection)
                        classTags.write_localGeoInfo(hProjection)
                     end
                  end

               end # writeXML
            end # PlanarReference

         end
      end
   end
end
