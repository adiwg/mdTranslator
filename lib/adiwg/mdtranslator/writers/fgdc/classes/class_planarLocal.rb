# FGDC <<Class>> PlanarReference
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-10-09 refactor mdJson projection object
#  Stan Smith 2018-03-21 original script

require_relative '../fgdc_writer'
require_relative 'class_mapProjectionTags'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class PlanarLocal

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(hProjection, inContext = nil)

                  # localPLANAR is not the same as localSYSTEM in fgdc
                  # however they use the same 'local' object
                  # local system sets projectionIdentifier.identifier = 'localSystem'
                  # local planar sets projectionIdentifier.identifier = 'localPlanar'

                  # classes used
                  classTags = MapProjectionTags.new(@xml, @hResponseObj)

                  hProjectionId = hProjection[:projectionIdentifier]
                  hLocal = hProjection[:local]

                  if hLocal.empty?
                     @NameSpace.issueError(470, inContext)
                     return
                  end

                  # planar 4.1.2.3 (localp) - local planar
                  if hProjectionId[:identifier] == 'localPlanar'
                     hProjectionId[:name] = nil unless hProjectionId.has_key?(:name)
                     if hProjectionId[:name].nil?
                        hProjectionId[:name] = 'Local Planar Coordinate System Fixed to Earth'
                     end
                     @xml.tag!('localp') do
                        classTags.write_localDesc(hLocal, inContext)
                        classTags.write_localGeoInfo(hLocal, inContext)
                     end
                  end

               end # writeXML
            end # PlanarReference

         end
      end
   end
end
