# Reader - fgdc to internal data structure
# unpack fgdc map projection - parameter set

# History:
#  Stan Smith 2018-10-03 refactor mdJson projection object
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

                     # -> ReferenceSystemParameters.projection.standardParallel1
                     # -> ReferenceSystemParameters.projection.standardParallel2
                     ProjectionCommon.unpackStandParallel(xParams, hProjection)

                     # -> ReferenceSystemParameters.projection.longitudeOfCentralMeridian
                     ProjectionCommon.unpackLongCM(xParams, hProjection)

                     # -> ReferenceSystemParameters.projection.latitudeOfProjectionOrigin
                     ProjectionCommon.unpackLatPO(xParams, hProjection)

                     # -> ReferenceSystemParameters.projection.falseEasting
                     # -> ReferenceSystemParameters.projection.falseNorthing
                     ProjectionCommon.unpackFalseNE(xParams, hProjection)

                     # -> ReferenceSystemParameters.projection.heightOfProspectivePointAboveSurface
                     ProjectionCommon.unpackHeightAS(xParams, hProjection)

                     # -> ReferenceSystemParameters.projection.longitudeOfProjectionCenter
                     ProjectionCommon.unpackLongPC(xParams, hProjection)

                     # -> ReferenceSystemParameters.projection.latitudeOfProjectionCenter
                     ProjectionCommon.unpackLatPC(xParams, hProjection)

                     # -> ReferenceSystemParameters.projection.scaleFactorAtEquator
                     ProjectionCommon.unpackSFEquator(xParams, hProjection)

                     # -> ReferenceSystemParameters.projection.scaleFactorAtCenterLine
                     ProjectionCommon.unpackSFCenter(xParams, hProjection)

                     # -> ReferenceSystemParameters.projection.scaleFactorAtCentralMeridian
                     ProjectionCommon.unpackSFCM(xParams, hProjection)

                     # -> ReferenceSystemParameters.projection.scaleFactorAtProjectionOrigin
                     ProjectionCommon.unpackSFPO(xParams, hProjection)

                     # -> oblique line azimuth ( azimuthAngle && azimuthMeasurePointLongitude )
                     # -> ReferenceSystemParameters.projection.azimuthAngle
                     # -> ReferenceSystemParameters.projection.azimuthMeasurePointLongitude
                     ProjectionCommon.unpackObliqueLA(xParams, hProjection)

                     # -> oblique line point 2( obliqueLinePoint{} )
                     ProjectionCommon.unpackObliqueLP(xParams, hProjection)

                     # -> ReferenceSystemParameters.projection.straightVerticalLongitudeFromPole
                     ProjectionCommon.unpackVSLong(xParams, hProjection)

                     # -> ReferenceSystemParameters.projection.landsatNumber
                     ProjectionCommon.unpackLandSat(xParams, hProjection)

                     # -> ReferenceSystemParameters.projection.landsatPath
                     ProjectionCommon.unpackLandSatPath(xParams, hProjection)

                     # -> ReferenceSystemParameters.projection.otherProjectionDescription
                     ProjectionCommon.unpackOtherProjection(xParams, hProjection)

                     return hProjection

                  end

                  return nil

               end

            end

         end
      end
   end
end
