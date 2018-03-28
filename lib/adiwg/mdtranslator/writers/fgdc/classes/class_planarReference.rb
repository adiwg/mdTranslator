# FGDC <<Class>> PlanarReference
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-03-21 original script

require_relative 'class_planarMap'
require_relative 'class_planarGrid'
require_relative 'class_planarLocal'
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

               def writeXML(aSpaceRefs, aRepTypes, aResolutions)

                  # classes used
                  classMap = PlanarMap.new(@xml, @hResponseObj)
                  classGrid = PlanarGrid.new(@xml, @hResponseObj)
                  classLocal = PlanarLocal.new(@xml, @hResponseObj)
                  classInfo = PlanarInformation.new(@xml, @hResponseObj)

                  # <- planar 4.1.2 ...
                  # <- spatialReferences[].systemParameterSet.projection (map) 4.1.2.1
                  # <- spatialReferences[].systemParameterSet.projection (grid) 4.1.2.2
                  # <- spatialReferences[].systemParameterSet.projection (localPlanar) 4.1.2.3
                  # <- planar information 4.1.2.4 ...

                  # planar 4.1.2.1 (mapproj) - map projection
                  aSpaceRefs.each do |hSpaceRef|
                     unless hSpaceRef[:systemParameterSet].empty?
                        if hSpaceRef[:systemParameterSet][:projection]
                           hProjection = hSpaceRef[:systemParameterSet][:projection]
                           unless hProjection.empty?
                              unless hProjection[:projection].nil?
                                 classMap.writeXML(hProjection)
                              end
                           end
                        end
                     end
                  end

                  # planar 4.1.2.2 (gridsys) - grid projection
                  aSpaceRefs.each do |hSpaceRef|
                     unless hSpaceRef[:systemParameterSet].empty?
                        if hSpaceRef[:systemParameterSet][:projection]
                           hProjection = hSpaceRef[:systemParameterSet][:projection]
                           unless hProjection.empty?
                              unless hProjection[:gridSystem].nil?
                                 classGrid.writeXML(hProjection)
                              end
                           end
                        end
                     end
                  end

                  # planar 4.1.2.3 (localp) - local planar projection
                  aSpaceRefs.each do |hSpaceRef|
                     unless hSpaceRef[:systemParameterSet].empty?
                        if hSpaceRef[:systemParameterSet][:projection]
                           hProjection = hSpaceRef[:systemParameterSet][:projection]
                           unless hProjection.empty?
                              unless hProjection[:projection].nil?
                                 if hProjection[:projection] == 'localPlanar'
                                    classLocal.writeXML(hProjection)
                                 end
                              end
                           end
                        end
                     end
                  end

                  # planar 4.1.2.4 (planci) - local planar projection
                  classInfo.writeXML(aRepTypes, aResolutions)

               end # writeXML
            end # PlanarReference

         end
      end
   end
end
