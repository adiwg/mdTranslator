# unpack spatial projection projection parameters
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-02-19 refactored error and warning messaging
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
                     responseObj[:readerExecutionMessages] <<
                        'WARNING: mdJson reader: reference system projection parameters object is empty'
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
                     unless hProjection['gridSystem'] == ''
                        intProjection[:gridSystem] = hProjection['gridSystem']
                     end
                  end

                  # projection parameters - grid system name
                  if hProjection.has_key?('gridSystemName')
                     unless hProjection['gridSystemName'] == ''
                        intProjection[:gridSystemName] = hProjection['gridSystemName']
                     end
                  end

                  # projection parameters - projection (required)
                  if hProjection.has_key?('projection')
                     intProjection[:projection] = hProjection['projection']
                  end
                  if intProjection[:projection].nil? || intProjection[:projection] == ''
                     responseObj[:readerExecutionMessages] << 'spatial reference projection is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # projection parameters - projection name
                  if hProjection.has_key?('projectionName')
                     unless hProjection['projectionName'] == ''
                        intProjection[:projectionName] = hProjection['projectionName']
                     end
                  end

                  # projection parameters - zone
                  if hProjection.has_key?('gridZone')
                     unless hProjection['gridZone'] == ''
                        intProjection[:gridZone] = hProjection['gridZone']
                     end
                  end

                  # projection parameters - standard parallel 1
                  if hProjection.has_key?('standardParallel1')
                     unless hProjection['standardParallel1'] == ''
                        intProjection[:standardParallel1] = hProjection['standardParallel1']
                     end
                  end

                  # projection parameters - standard parallel 2
                  if hProjection.has_key?('standardParallel2')
                     unless hProjection['standardParallel2'] == ''
                        intProjection[:standardParallel2] = hProjection['standardParallel2']
                     end
                  end

                  # projection parameters - longitude of central meridian
                  if hProjection.has_key?('longitudeOfCentralMeridian')
                     unless hProjection['longitudeOfCentralMeridian'] == ''
                        intProjection[:longitudeOfCentralMeridian] = hProjection['longitudeOfCentralMeridian']
                     end
                  end

                  # projection parameters - latitude of projection origin
                  if hProjection.has_key?('latitudeOfProjectionOrigin')
                     unless hProjection['latitudeOfProjectionOrigin'] == ''
                        intProjection[:latitudeOfProjectionOrigin] = hProjection['latitudeOfProjectionOrigin']
                     end
                  end

                  # projection parameters - false easting
                  if hProjection.has_key?('falseEasting')
                     unless hProjection['falseEasting'] == ''
                        intProjection[:falseEasting] = hProjection['falseEasting']
                     end
                  end

                  # projection parameters - false northing
                  if hProjection.has_key?('falseNorthing')
                     unless hProjection['falseNorthing'] == ''
                        intProjection[:falseNorthing] = hProjection['falseNorthing']
                     end
                  end

                  # projection parameters - false easting northing units
                  if hProjection.has_key?('falseEastingNorthingUnits')
                     unless hProjection['falseEastingNorthingUnits'] == ''
                        intProjection[:falseEastingNorthingUnits] = hProjection['falseEastingNorthingUnits']
                     end
                  end

                  # projection parameters - scale factor at equator
                  if hProjection.has_key?('scaleFactorAtEquator')
                     unless hProjection['scaleFactorAtEquator'] == ''
                        intProjection[:scaleFactorAtEquator] = hProjection['scaleFactorAtEquator']
                     end
                  end

                  # projection parameters - height of prospective point above surface
                  if hProjection.has_key?('heightOfProspectivePointAboveSurface')
                     unless hProjection['heightOfProspectivePointAboveSurface'] == ''
                        intProjection[:heightOfProspectivePointAboveSurface] = hProjection['heightOfProspectivePointAboveSurface'].to_f
                     end
                  end

                  # projection parameters - longitude of projection center
                  if hProjection.has_key?('longitudeOfProjectionCenter')
                     unless hProjection['longitudeOfProjectionCenter'] == ''
                        intProjection[:longitudeOfProjectionCenter] = hProjection['longitudeOfProjectionCenter']
                     end
                  end

                  # projection parameters - latitude of projection center
                  if hProjection.has_key?('latitudeOfProjectionCenter')
                     unless hProjection['latitudeOfProjectionCenter'] == ''
                        intProjection[:latitudeOfProjectionCenter] = hProjection['latitudeOfProjectionCenter']
                     end
                  end

                  # projection parameters - scale factor at center line
                  if hProjection.has_key?('scaleFactorAtCenterLine')
                     unless hProjection['scaleFactorAtCenterLine'] == ''
                        intProjection[:scaleFactorAtCenterLine] = hProjection['scaleFactorAtCenterLine']
                     end
                  end

                  # projection parameters - scale factor at meridian
                  if hProjection.has_key?('scaleFactorAtCentralMeridian')
                     unless hProjection['scaleFactorAtCentralMeridian'] == ''
                        intProjection[:scaleFactorAtCentralMeridian] = hProjection['scaleFactorAtCentralMeridian']
                     end
                  end

                  # projection parameters - straight vertical longitude from pole
                  if hProjection.has_key?('straightVerticalLongitudeFromPole')
                     unless hProjection['straightVerticalLongitudeFromPole'] == ''
                        intProjection[:straightVerticalLongitudeFromPole] = hProjection['straightVerticalLongitudeFromPole']
                     end
                  end

                  # projection parameters - scale factor at projection origin
                  if hProjection.has_key?('scaleFactorAtProjectionOrigin')
                     unless hProjection['scaleFactorAtProjectionOrigin'] == ''
                        intProjection[:scaleFactorAtProjectionOrigin] = hProjection['scaleFactorAtProjectionOrigin']
                     end
                  end

                  # projection parameters - azimuth angle
                  if hProjection.has_key?('azimuthAngle')
                     unless hProjection['azimuthAngle'] == ''
                        intProjection[:azimuthAngle] = hProjection['azimuthAngle']
                     end
                  end

                  # projection parameters - azimuth measure point longitude
                  if hProjection.has_key?('azimuthMeasurePointLongitude')
                     unless hProjection['azimuthMeasurePointLongitude'] == ''
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
                     unless hProjection['landsatNumber'] == ''
                        intProjection[:landsatNumber] = hProjection['landsatNumber']
                     end
                  end

                  # projection parameters - landsat path
                  if hProjection.has_key?('landsatPath')
                     unless hProjection['landsatPath'] == ''
                        intProjection[:landsatPath] = hProjection['landsatPath']
                     end
                  end

                  # projection parameters - local planar description
                  if hProjection.has_key?('localPlanarDescription')
                     unless hProjection['localPlanarDescription'] == ''
                        intProjection[:localPlanarDescription] = hProjection['localPlanarDescription']
                     end
                  end

                  # projection parameters - local planar georeference
                  if hProjection.has_key?('localPlanarGeoreference')
                     unless hProjection['localPlanarGeoreference'] == ''
                        intProjection[:localPlanarGeoreference] = hProjection['localPlanarGeoreference']
                     end
                  end

                  # projection parameters - other projection description
                  if hProjection.has_key?('otherProjectionDescription')
                     unless hProjection['otherProjectionDescription'] == ''
                        intProjection[:otherProjectionDescription] = hProjection['otherProjectionDescription']
                     end
                  end

                  # projection parameters - other grid description
                  if hProjection.has_key?('otherGridDescription')
                     unless hProjection['otherGridDescription'] == ''
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
