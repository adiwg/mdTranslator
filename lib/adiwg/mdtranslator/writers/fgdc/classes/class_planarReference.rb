# FGDC <<Class>> PlanarReference
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-10-09 refactor mdJson projection object
#  Stan Smith 2018-03-21 original script

require_relative 'class_planarMap'
require_relative 'class_planarGrid'
require_relative 'class_localPlanar'
require_relative 'class_planarInfo'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class PlanarReference

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(aSpaceRefs, aRepTypes, aResolutions, inContext = nil)

                  # classes used
                  classMap = PlanarMap.new(@xml, @hResponseObj)
                  classGrid = PlanarGrid.new(@xml, @hResponseObj)
                  classLocal = PlanarLocal.new(@xml, @hResponseObj)
                  classInfo = PlanarInformation.new(@xml, @hResponseObj)

                  outContext = 'horizontal planar'
                  outContext = inContext + ' ' + outContext unless inContext.nil?

                  # <- planar 4.1.2 ...
                  # <- spatialReferences[].systemParameterSet.projection (map) 4.1.2.1
                  # <- spatialReferences[].systemParameterSet.projection (grid) 4.1.2.2
                  # <- spatialReferences[].systemParameterSet.projection (localPlanar) 4.1.2.3
                  aSpaceRefs.each do |hSpaceRef|
                     unless hSpaceRef[:systemParameterSet].empty?
                        unless hSpaceRef[:systemParameterSet][:projection].empty?
                           hProjection = hSpaceRef[:systemParameterSet][:projection]
                           unless hProjection[:gridIdentifier].empty?
                              classGrid.writeXML(hProjection, outContext)
                              break
                           end
                           if hProjection[:projectionIdentifier][:identifier] == 'localPlanar'
                              classLocal.writeXML(hProjection, outContext)
                              break
                           end
                           classMap.writeXML(hProjection, outContext)
                        end
                     end
                  end

                  # planar 4.1.2.4 (planci) - planar coordinate information
                  classInfo.writeXML(aRepTypes, aResolutions, outContext)

               end # writeXML
            end # PlanarReference

         end
      end
   end
end
