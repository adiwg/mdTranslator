# Reader - fgdc to internal data structure
# unpack fgdc planar coordinate information

# History:
#  Stan Smith 2017-10-05 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module PlanarCoordinateInformation

               def self.unpack(xPlanarCI, hResourceInfo, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  # map projection 4.1.2.4.1 (plance) - planar coordinate encoding method
                  # -> resourceInfo.spatialRepresentationTypes
                  encoding = xPlanarCI.xpath('./plance').text
                  unless encoding.empty?
                     hResourceInfo[:spatialRepresentationTypes] << encoding
                  end

                  # map projection 4.1.2.4.2 (coordrep) - coordinate representation
                  xCoordRep = xPlanarCI.xpath('./coordrep')
                  unless xCoordRep.empty?

                     hCoordResolution = intMetadataClass.newCoordinateResolution

                     # map projection 4.1.2.4.2.1 (absres) - abscissa resolution
                     # -> resourceInfo.spatialResolutions.spatialResolution.coordinateResolution.abscissaResolutionX
                     abscissa = xCoordRep.xpath('./absres').text
                     unless abscissa.empty?
                        hCoordResolution[:abscissaResolutionX] = abscissa.to_f
                     end

                     # map projection 4.1.2.4.2.2 (ordres) - ordinate resolution
                     # -> resourceInfo.spatialResolutions.spatialResolution.coordinateResolution.ordinateResolutionY
                     ordinate = xCoordRep.xpath('./ordres').text
                     unless ordinate.empty?
                        hCoordResolution[:ordinateResolutionY] = ordinate.to_f
                     end

                     # map projection 4.1.2.4.4 (plandu) - planar distance units
                     # -> resourceInfo.spatialResolutions.spatialResolution.coordinateResolution.unitOfMeasure
                     distUnits = xPlanarCI.xpath('./plandu').text
                     unless distUnits.empty?
                        hCoordResolution[:unitOfMeasure] = distUnits
                     end

                     hResolution = intMetadataClass.newSpatialResolution
                     hResolution[:coordinateResolution] = hCoordResolution
                     hResourceInfo[:spatialResolutions] << hResolution

                  end

                  # map projection 4.1.2.4.3 (distbrep) - distance and bearing representation
                  xBDRep = xPlanarCI.xpath('./distbrep')
                  unless xBDRep.empty?

                     hBDResolution = intMetadataClass.newBearingDistanceResolution

                     # map projection 4.1.2.4.3.1 (distres) - distance resolution
                     # -> resourceInfo.spatialResolutions.spatialResolution.bearingDistanceResolution.distanceResolution
                     distRes = xBDRep.xpath('./distres').text
                     unless distRes.empty?
                        hBDResolution[:distanceResolution] = distRes.to_f
                     end

                     # map projection 4.1.2.4.4 (plandu) - planar distance units
                     # -> resourceInfo.spatialResolutions.spatialResolution.bearingDistanceResolution.distanceUnitOfMeasure
                     distUnits = xPlanarCI.xpath('./plandu').text
                     unless distUnits.empty?
                        hBDResolution[:distanceUnitOfMeasure] = distUnits
                     end
                     # map projection 4.1.2.4.3.2 (bearres) - bearing resolution
                     # -> resourceInfo.spatialResolutions.spatialResolution.bearingDistanceResolution.bearingResolution
                     bearingRes = xBDRep.xpath('./bearres').text
                     unless bearingRes.empty?
                        hBDResolution[:bearingResolution] = bearingRes.to_f
                     end

                     # map projection 4.1.2.4.3.3 (bearunit) - bearing units
                     # -> resourceInfo.spatialResolutions.spatialResolution.bearingDistanceResolution.bearingUnitsOfMeasure
                     bearingUnits = xBDRep.xpath('./bearunit').text
                     unless bearingUnits.empty?
                        hBDResolution[:bearingUnitsOfMeasure] = bearingUnits
                     end

                     # map projection 4.1.2.4.3.4 (bearrefd) - bearing reference direction
                     # -> resourceInfo.spatialResolutions.spatialResolution.bearingDistanceResolution.bearingReferenceDirection
                     bearingDirection = xBDRep.xpath('./bearrefd').text
                     unless bearingDirection.empty?
                        hBDResolution[:bearingReferenceDirection] = bearingDirection
                     end

                     # map projection 4.1.2.4.3.5 (bearrefm) - bearing reference meridian
                     # -> resourceInfo.spatialResolutions.spatialResolution.bearingDistanceResolution.bearingReferenceMeridian
                     bearingMeridian = xBDRep.xpath('./bearrefm').text
                     unless bearingMeridian.empty?
                        hBDResolution[:bearingReferenceMeridian] = bearingMeridian
                     end

                     hResolution = intMetadataClass.newSpatialResolution
                     hResolution[:bearingDistanceResolution] = hBDResolution
                     hResourceInfo[:spatialResolutions] << hResolution

                  end

                  # map projection 4.1.2.4.4 (plandu) - planar distance units
                  # -> resourceInfo.spatialResolutions.spatialResolution.bearingDistanceResolution.distanceUnitOfMeasure
                  # -> resourceInfo.spatialResolutions.spatialResolution.coordinateResolution.unitOfMeasure

                  return nil

               end

            end

         end
      end
   end
end
