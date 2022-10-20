# Reader - fgdc to internal data structure
# unpack fgdc horizontal planar data reference

# History:
#  Stan Smith 2018-10-04 refactor mdJson projection object
#  Stan Smith 2017-10-03 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_mapProjection'
require_relative 'module_mapGridSystem'
require_relative 'module_localPlanar'
require_relative 'module_planarCoordinateInfo'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module PlanarReference

               def self.unpack(xPlanar, hResourceInfo, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hReferenceSystem = intMetadataClass.newSpatialReferenceSystem
                  hSystemParameters = intMetadataClass.newReferenceSystemParameterSet
                  hProjection = {}

                  # get distance unit of measure for use in map projections and grid systems
                  distanceUnits = nil
                  xPlanCI = xPlanar.xpath('./planci')
                  unless xPlanCI.empty?
                     planDU = xPlanCI.xpath('./plandu').text
                     unless planDU.empty?
                        distanceUnits = planDU
                     end
                  end

                  # planar reference 4.1.2.1 (mapproj) - map projection
                  xMapProjection = xPlanar.xpath('./mapproj')
                  unless xMapProjection.empty?
                     hProjection = MapProjection.unpack(xMapProjection, hResponseObj)
                  end

                  # planar reference 4.1.2.2 (gridsys) - grid coordinate system
                  xMapGrid = xPlanar.xpath('./gridsys')
                  unless xMapGrid.empty?
                     hProjection = MapGridSystem.unpack(xMapGrid, hResponseObj)
                  end

                  # planar reference 4.1.2.3 (localp) - local planar
                  xMapLocal = xPlanar.xpath('./localp')
                  unless xMapLocal.empty?
                     hProjection = MapLocalPlanar.unpack(xMapLocal, hResponseObj)
                  end

                  # packing
                  unless hProjection.nil? || hProjection.empty?
                     unless distanceUnits.nil?
                        hProjection[:falseEastingNorthingUnits] = distanceUnits
                     end
                     hSystemParameters[:projection] = hProjection
                     hReferenceSystem[:systemParameterSet] = hSystemParameters
                     hResourceInfo[:spatialReferenceSystems] << hReferenceSystem
                  end

                  # planar reference 4.1.2.4 (planci) - planar coordinate information
                  xPlanarCI = xPlanar.xpath('./planci')
                  unless xPlanarCI.empty?
                     PlanarCoordinateInformation.unpack(xPlanarCI, hResourceInfo, hResponseObj)
                  end

                  return hResourceInfo

               end

            end

         end
      end
   end
end
