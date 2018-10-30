# unpack spatial projection projection parameters
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-10-08 refactor mdJson projection object
#  Stan Smith 2018-06-22 refactored error and warning messaging
# 	Stan Smith 2017-10-23 original script

require_relative 'module_identifier'
require_relative 'module_obliqueLinePoint'
require_relative 'module_localProjection'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module ProjectionParameters

               def self.unpack(hProjection, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hProjection.empty?
                     @MessagePath.issueWarning(650, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intProjection = intMetadataClass.newProjection

                  outContext = 'projection parameters'
                  outContext = inContext + ' ' + outContext unless inContext.nil?

                  # projection parameters - projection identifier {identifier} (required)
                  # add name to identifier object
                  if hProjection.has_key?('projectionIdentifier')
                     unless hProjection['projectionIdentifier'].empty?
                        hProjectionId = hProjection['projectionIdentifier']
                        hReturn = Identifier.unpack(hProjectionId, responseObj, outContext)
                        unless hReturn.nil?
                           if hProjectionId.has_key?('name')
                              unless hProjectionId['name'] == ''
                                 hReturn[:name] = hProjectionId['name']
                              end
                           end
                           intProjection[:projectionIdentifier] = hReturn
                        end
                     end
                  end
                  if intProjection[:projectionIdentifier].empty?
                     @MessagePath.issueError(651, responseObj, inContext)
                  end

                  # projection parameters - grid system identifier {identifier}
                  # add name to identifier object
                  if hProjection.has_key?('gridIdentifier')
                     unless hProjection['gridIdentifier'].empty?
                        hGridSystemId = hProjection['gridIdentifier']
                        hReturn = Identifier.unpack(hProjection['gridIdentifier'], responseObj, outContext)
                        unless hReturn.nil?
                           if hGridSystemId.has_key?('name')
                              unless hGridSystemId['name'] == ''
                                 hReturn[:name] = hGridSystemId['name']
                              end
                           end
                           intProjection[:gridIdentifier] = hReturn
                        end
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
                        intProjection[:heightOfProspectivePointAboveSurface] =
                           hProjection['heightOfProspectivePointAboveSurface']
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
                        hReturn = ObliqueLinePoint.unpack(item, responseObj, outContext)
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

                  # projection parameters - local projection [] {local}
                  if hProjection.has_key?('local')
                     unless hProjection['local'].empty?
                        hReturn = LocalProjection.unpack(hProjection['local'], responseObj, outContext)
                        unless hReturn.nil?
                           intProjection[:local] = hReturn
                        end
                     end
                  end

                  return intProjection
               end

            end

         end
      end
   end
end
