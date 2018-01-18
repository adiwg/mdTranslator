# mdJson 2.0 writer - spatial reference system projection parameters

# History:
#   Stan Smith 2017-10-24 original script

require 'jbuilder'
require_relative 'mdJson_identifier'
require_relative 'mdJson_obliqueLinePoint'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module ProjectionParameters

               @Namespace = ADIWG::Mdtranslator::Writers::MdJson

               def self.build(hProjection)

                  Jbuilder.new do |json|
                     json.projectionIdentifier Identifier.build(hProjection[:projectionIdentifier]) unless hProjection[:projectionIdentifier].empty?
                     json.gridSystem hProjection[:gridSystem]
                     json.gridSystemName hProjection[:gridSystemName]
                     json.gridZone hProjection[:gridZone]
                     json.projection hProjection[:projection]
                     json.projectionName hProjection[:projectionName]
                     json.standardParallel1 hProjection[:standardParallel1]
                     json.standardParallel2 hProjection[:standardParallel2]
                     json.longitudeOfCentralMeridian hProjection[:longitudeOfCentralMeridian]
                     json.latitudeOfProjectionOrigin hProjection[:latitudeOfProjectionOrigin]
                     json.falseEasting hProjection[:falseEasting]
                     json.falseNorthing hProjection[:falseNorthing]
                     json.falseEastingNorthingUnits hProjection[:falseEastingNorthingUnits]
                     json.scaleFactorAtEquator hProjection[:scaleFactorAtEquator]
                     json.heightOfProspectivePointAboveSurface hProjection[:heightOfProspectivePointAboveSurface]
                     json.longitudeOfProjectionCenter hProjection[:longitudeOfProjectionCenter]
                     json.latitudeOfProjectionCenter hProjection[:latitudeOfProjectionCenter]
                     json.scaleFactorAtCenterLine hProjection[:scaleFactorAtCenterLine]
                     json.scaleFactorAtCentralMeridian hProjection[:scaleFactorAtCentralMeridian]
                     json.straightVerticalLongitudeFromPole hProjection[:straightVerticalLongitudeFromPole]
                     json.scaleFactorAtProjectionOrigin hProjection[:scaleFactorAtProjectionOrigin]
                     json.azimuthAngle hProjection[:azimuthAngle]
                     json.azimuthMeasurePointLongitude hProjection[:azimuthMeasurePointLongitude]
                     json.obliqueLinePoint @Namespace.json_map(hProjection[:obliqueLinePoints], ObliqueLinePoint)
                     json.landsatNumber hProjection[:landsatNumber]
                     json.landsatPath hProjection[:landsatPath]
                     json.localPlanarDescription hProjection[:localPlanarDescription]
                     json.localPlanarGeoreference hProjection[:localPlanarGeoreference]
                     json.otherGridDescription hProjection[:otherGridDescription]
                     json.otherProjectionDescription hProjection[:otherProjectionDescription]
                  end

               end # build
            end # ProjectionParameters

         end
      end
   end
end
