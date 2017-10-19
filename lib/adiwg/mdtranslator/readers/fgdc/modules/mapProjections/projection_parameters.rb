# Reader - fgdc to internal data structure
# unpack fgdc map projection - parameter set

# History:
#  Stan Smith 2017-10-18 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module ProjectionParameters

               def self.unpack(xParams, hProjection, hResponseObj)

                  # map projection 4.1.2.1.23 (mapprojp) - projection parameter set
                  unless xParams.empty?
                     hProjection[:projectionName] = 'projection parameters'

                     # -> ReferenceSystemParameters.projection.standardParallel1
                     # -> ReferenceSystemParameters.projection.standardParallel2
                     ProjectionCommon.unpackStandParallel(xParams, hProjection, hResponseObj)

                     # -> ReferenceSystemParameters.projection.longitudeOfCentralMeridian
                     ProjectionCommon.unpackLongCM(xParams, hProjection, hResponseObj)

                     # -> ReferenceSystemParameters.projection.latitudeOfProjectionOrigin
                     ProjectionCommon.unpackLatPO(xParams, hProjection, hResponseObj)

                     # -> ReferenceSystemParameters.projection.falseEasting
                     # -> ReferenceSystemParameters.projection.falseNorthing
                     ProjectionCommon.unpackFalseNE(xParams, hProjection, hResponseObj)

                     # -> ReferenceSystemParameters.projection.heightOfProspectivePointAboveSurface
                     ProjectionCommon.unpackHeightAS(xParams, hProjection, hResponseObj)

                     # -> ReferenceSystemParameters.projection.longitudeOfProjectionCenter
                     ProjectionCommon.unpackLongPC(xParams, hProjection, hResponseObj)

                     # -> ReferenceSystemParameters.projection.latitudeOfProjectionCenter
                     ProjectionCommon.unpackLatPC(xParams, hProjection, hResponseObj)

                     # -> ReferenceSystemParameters.projection.scaleFactorAtEquator
                     ProjectionCommon.unpackSFEquator(xParams, hProjection, hResponseObj)

                     # -> ReferenceSystemParameters.projection.scaleFactorAtCenterLine
                     ProjectionCommon.unpackSFCenter(xParams, hProjection, hResponseObj)

                     # -> ReferenceSystemParameters.projection.scaleFactorAtCentralMeridian
                     ProjectionCommon.unpackSFCM(xParams, hProjection, hResponseObj)

                     # -> ReferenceSystemParameters.projection.scaleFactorAtProjectionOrigin
                     ProjectionCommon.unpackSFPO(xParams, hProjection, hResponseObj)

                     # -> oblique line azimuth ( azimuthAngle && azimuthMeasurePointLongitude )
                     # -> ReferenceSystemParameters.projection.azimuthAngle
                     # -> ReferenceSystemParameters.projection.azimuthMeasurePointLongitude
                     ProjectionCommon.unpackObliqueLA(xParams, hProjection, hResponseObj)

                     # -> oblique line point 2( obliqueLinePoint{} )
                     ProjectionCommon.unpackObliqueLP(xParams, hProjection, hResponseObj)

                     # -> ReferenceSystemParameters.projection.straightVerticalLongitudeFromPole
                     ProjectionCommon.unpackVSLong(xParams, hProjection, hResponseObj)

                     # -> ReferenceSystemParameters.projection.landsatNumber
                     ProjectionCommon.unpackLandSat(xParams, hProjection, hResponseObj)

                     # -> ReferenceSystemParameters.projection.landsatPath
                     ProjectionCommon.unpackLandSatPath(xParams, hProjection, hResponseObj)

                     # -> ReferenceSystemParameters.projection.otherProjection
                     ProjectionCommon.unpackOtherProjection(xParams, hProjection, hResponseObj)

                     return hProjection

                  end

                  return nil

               end

            end

         end
      end
   end
end
