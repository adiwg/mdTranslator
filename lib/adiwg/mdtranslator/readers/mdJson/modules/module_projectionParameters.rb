# unpack spatial projection projection parameters
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2017-10-23 original script

require_relative 'module_identifier'
require_relative 'module_obliqueLinePoint'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module ProjectionParameters

               def self.unpack(hProjection, responseObj)

                  # return nil object if input is empty
                  if hProjection.empty?
                     responseObj[:readerExecutionMessages] << 'Reference System Projection Parameters object is empty'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intProjection = intMetadataClass.newProjection

                  # projection parameters - projection identifier {identifier}
                  if hProjection.has_key?('projectionIdentifier')
                     unless hProjection['projectionIdentifier'].empty?
                        hReturn = Identifier.unpack(hProjection['projectionIdentifier'], responseObj)
                        unless hReturn.nil?
                           intProjection[:projectionIdentifier] = hReturn
                        end
                     end
                  end

                  # projection parameters - grid system
                  if hProjection.has_key?('gridSystem')
                     if hProjection['gridSystem'] != ''
                        intProjection[:gridSystem] = hProjection['gridSystem']
                     end
                  end

                  # projection parameters - grid system name
                  if hProjection.has_key?('gridSystemName')
                     if hProjection['gridSystemName'] != ''
                        intProjection[:gridSystemName] = hProjection['gridSystemName']
                     end
                  end

                  # projection parameters - projection (required)
                  if hProjection.has_key?('projection')
                     intProjection[:projection] = hProjection['projection']
                  end
                  if intProjection[:projection].nil? || intProjection[:projection] == ''
                     responseObj[:readerExecutionMessages] << 'Spatial Reference Projection is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # projection parameters - projection name
                  if hProjection.has_key?('projectionName')
                     if hProjection['projectionName'] != ''
                        intProjection[:projectionName] = hProjection['projectionName']
                     end
                  end

                  # projection parameters - zone
                  if hProjection.has_key?('gridZone')
                     if hProjection['gridZone'] != ''
                        intProjection[:gridZone] = hProjection['gridZone']
                     end
                  end

                  # projection parameters - standard parallel 1
                  if hProjection.has_key?('standardParallel1')
                     if hProjection['standardParallel1'] != ''
                        intProjection[:standardParallel1] = hProjection['standardParallel1']
                     end
                  end

                  # projection parameters - standard parallel 2
                  if hProjection.has_key?('standardParallel2')
                     if hProjection['standardParallel2'] != ''
                        intProjection[:standardParallel2] = hProjection['standardParallel2']
                     end
                  end

                  # projection parameters - longitude of central meridian
                  if hProjection.has_key?('longitudeOfCentralMeridian')
                     if hProjection['longitudeOfCentralMeridian'] != ''
                        intProjection[:longitudeOfCentralMeridian] = hProjection['longitudeOfCentralMeridian']
                     end
                  end

                  # projection parameters - latitude of projection origin
                  if hProjection.has_key?('latitudeOfProjectionOrigin')
                     if hProjection['latitudeOfProjectionOrigin'] != ''
                        intProjection[:latitudeOfProjectionOrigin] = hProjection['latitudeOfProjectionOrigin']
                     end
                  end

                  # projection parameters - false easting
                  if hProjection.has_key?('falseEasting')
                     if hProjection['falseEasting'] != ''
                        intProjection[:falseEasting] = hProjection['falseEasting']
                     end
                  end

                  # projection parameters - false northing
                  if hProjection.has_key?('falseNorthing')
                     if hProjection['falseNorthing'] != ''
                        intProjection[:falseNorthing] = hProjection['falseNorthing']
                     end
                  end

                  # projection parameters - false easting northing units
                  if hProjection.has_key?('falseEastingNorthingUnits')
                     if hProjection['falseEastingNorthingUnits'] != ''
                        intProjection[:falseEastingNorthingUnits] = hProjection['falseEastingNorthingUnits']
                     end
                  end

                  # projection parameters - scale factor at equator
                  if hProjection.has_key?('scaleFactorAtEquator')
                     if hProjection['scaleFactorAtEquator'] != ''
                        intProjection[:scaleFactorAtEquator] = hProjection['scaleFactorAtEquator']
                     end
                  end

                  # projection parameters - height of prospective point above surface
                  if hProjection.has_key?('heightOfProspectivePointAboveSurface')
                     if hProjection['heightOfProspectivePointAboveSurface'] != ''
                        intProjection[:heightOfProspectivePointAboveSurface] = hProjection['heightOfProspectivePointAboveSurface'].to_f
                     end
                  end

                  # projection parameters - longitude of projection center
                  if hProjection.has_key?('longitudeOfProjectionCenter')
                     if hProjection['longitudeOfProjectionCenter'] != ''
                        intProjection[:longitudeOfProjectionCenter] = hProjection['longitudeOfProjectionCenter']
                     end
                  end

                  # projection parameters - latitude of projection center
                  if hProjection.has_key?('latitudeOfProjectionCenter')
                     if hProjection['latitudeOfProjectionCenter'] != ''
                        intProjection[:latitudeOfProjectionCenter] = hProjection['latitudeOfProjectionCenter']
                     end
                  end

                  # projection parameters - scale factor at center line
                  if hProjection.has_key?('scaleFactorAtCenterLine')
                     if hProjection['scaleFactorAtCenterLine'] != ''
                        intProjection[:scaleFactorAtCenterLine] = hProjection['scaleFactorAtCenterLine']
                     end
                  end

                  # projection parameters - scale factor at meridian
                  if hProjection.has_key?('scaleFactorAtCentralMeridian')
                     if hProjection['scaleFactorAtCentralMeridian'] != ''
                        intProjection[:scaleFactorAtCentralMeridian] = hProjection['scaleFactorAtCentralMeridian']
                     end
                  end

                  # projection parameters - straight vertical longitude from pole
                  if hProjection.has_key?('straightVerticalLongitudeFromPole')
                     if hProjection['straightVerticalLongitudeFromPole'] != ''
                        intProjection[:straightVerticalLongitudeFromPole] = hProjection['straightVerticalLongitudeFromPole']
                     end
                  end

                  # projection parameters - scale factor at projection origin
                  if hProjection.has_key?('scaleFactorAtProjectionOrigin')
                     if hProjection['scaleFactorAtProjectionOrigin'] != ''
                        intProjection[:scaleFactorAtProjectionOrigin] = hProjection['scaleFactorAtProjectionOrigin']
                     end
                  end

                  # projection parameters - azimuth angle
                  if hProjection.has_key?('azimuthAngle')
                     if hProjection['azimuthAngle'] != ''
                        intProjection[:azimuthAngle] = hProjection['azimuthAngle']
                     end
                  end

                  # projection parameters - azimuth measure point longitude
                  if hProjection.has_key?('azimuthMeasurePointLongitude')
                     if hProjection['azimuthMeasurePointLongitude'] != ''
                        intProjection[:azimuthMeasurePointLongitude] = hProjection['azimuthMeasurePointLongitude']
                     end
                  end

                  # projection parameters - oblique line points [] {obliqueLinePoint}
                  if hProjection.has_key?('obliqueLinePoint')
                     aItems = hProjection['obliqueLinePoint']
                     aItems.each do |item|
                        hReturn = ObliqueLinePoint.unpack(item, responseObj)
                        unless hReturn.nil?
                           intProjection[:obliqueLinePoints] << hReturn
                        end
                     end
                  end

                  # projection parameters - landsat number
                  if hProjection.has_key?('landsatNumber')
                     if hProjection['landsatNumber'] != ''
                        intProjection[:landsatNumber] = hProjection['landsatNumber']
                     end
                  end

                  # projection parameters - landsat path
                  if hProjection.has_key?('landsatPath')
                     if hProjection['landsatPath'] != ''
                        intProjection[:landsatPath] = hProjection['landsatPath']
                     end
                  end

                  # projection parameters - local planar description
                  if hProjection.has_key?('localPlanarDescription')
                     if hProjection['localPlanarDescription'] != ''
                        intProjection[:localPlanarDescription] = hProjection['localPlanarDescription']
                     end
                  end

                  # projection parameters - local planar georeference
                  if hProjection.has_key?('localPlanarGeoreference')
                     if hProjection['localPlanarGeoreference'] != ''
                        intProjection[:localPlanarGeoreference] = hProjection['localPlanarGeoreference']
                     end
                  end

                  # projection parameters - other projection description
                  if hProjection.has_key?('otherProjectionDescription')
                     if hProjection['otherProjectionDescription'] != ''
                        intProjection[:otherProjectionDescription] = hProjection['otherProjectionDescription']
                     end
                  end

                  # projection parameters - other grid description
                  if hProjection.has_key?('otherGridDescription')
                     if hProjection['otherGridDescription'] != ''
                        intProjection[:otherGridDescription] = hProjection['otherGridDescription']
                     end
                  end

                  return intProjection
               end

            end

         end
      end
   end
end
