# FGDC <<Class>> MapProjection
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-01-02 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class MapProjection

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               # map projection 4.1.2.1.1 (mapprojn) - projection name (required)
               def write_name(projectionName)
                  unless projectionName.nil?
                     @xml.tag!('mapprojn', projectionName)
                  end
                  if projectionName.nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Map Projection is missing projection name'
                  end
               end

               # map projection 4.1.2.2.1 (gridsysn) - grid system name
               def write_gridName(gridSystem)
                  unless gridSystem.nil?
                     @xml.tag!('gridsysn', gridSystem)
                  end
                  if gridSystem.nil? && @hResponseObj[:writerShowTag]
                     @xml.tag!('gridsysn')
                  end
               end

               # map projection (feast) - false easting (required)
               # map projection (fnorth) - false northing (required)
               def write_falseNE(hProjection)
                  unless hProjection[:falseEasting].nil?
                     @xml.tag!('feast', hProjection[:falseEasting].to_s)
                  end
                  if hProjection[:falseEasting].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Map Projection is missing false easting'
                  end
                  unless hProjection[:falseNorthing].nil?
                     @xml.tag!('fnorth', hProjection[:falseNorthing].to_s)
                  end
                  if hProjection[:falseNorthing].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Map Projection is missing false northing'
                  end
               end

               # map projection (stdparll) - standard parallel (at least one required)
               def write_standParallel(hProjection)
                  haveParallel = false
                  unless hProjection[:standardParallel1].nil?
                     @xml.tag!('stdparll', hProjection[:standardParallel1].to_s)
                     haveParallel = true
                  end
                  unless hProjection[:standardParallel2].nil?
                     @xml.tag!('stdparll', hProjection[:standardParallel2].to_s)
                     haveParallel = true
                  end
                  unless haveParallel
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Map Projection is missing standard parallel'
                  end
               end

               # map projection (longcm) - longitude of central meridian (required)
               def write_longCM(hProjection)
                  unless hProjection[:longitudeOfCentralMeridian].nil?
                     @xml.tag!('longcm', hProjection[:longitudeOfCentralMeridian].to_s)
                  end
                  if hProjection[:longitudeOfCentralMeridian].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Map Projection is missing longitude of central meridian'
                  end
               end

               # map projection (latprjo) - latitude of projection origin (required)
               def write_latPO(hProjection)
                  unless hProjection[:latitudeOfProjectionOrigin].nil?
                     @xml.tag!('latprjo', hProjection[:latitudeOfProjectionOrigin].to_s)
                  end
                  if hProjection[:latitudeOfProjectionOrigin].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Map Projection is missing latitude of projection origin'
                  end
               end

               # map projection (heightpt) - height of perspective point above surface (required)
               def write_heightPP(hProjection)
                  unless hProjection[:heightOfProspectivePointAboveSurface].nil?
                     @xml.tag!('heightpt', hProjection[:heightOfProspectivePointAboveSurface].to_s)
                  end
                  if hProjection[:heightOfProspectivePointAboveSurface].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Map Projection is missing height of perspective point above surface'
                  end
               end

               # map projection (longpc) - longitude of projection center (required)
               def write_longPC(hProjection)
                  unless hProjection[:longitudeOfProjectionCenter].nil?
                     @xml.tag!('longpc', hProjection[:longitudeOfProjectionCenter].to_s)
                  end
                  if hProjection[:longitudeOfProjectionCenter].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Map Projection is missing longitude of projection center'
                  end
               end

               # map projection (latprjc) - latitude of projection center (required)
               def write_latPC(hProjection)
                  unless hProjection[:latitudeOfProjectionCenter].nil?
                     @xml.tag!('latprjc', hProjection[:latitudeOfProjectionCenter].to_s)
                  end
                  if hProjection[:latitudeOfProjectionCenter].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Map Projection is missing latitude of projection center'
                  end
               end

               # map projection (sfequat) - scale factor at equator (required)
               def write_scaleFactorE(hProjection)
                  unless hProjection[:scaleFactorAtEquator].nil?
                     @xml.tag!('sfequat', hProjection[:scaleFactorAtEquator].to_s)
                  end
                  if hProjection[:scaleFactorAtEquator].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Map Projection is missing scale factor at equator'
                  end
               end

               # map projection (sfctrlin) - scale factor at center line (required)
               def write_scaleFactorCL(hProjection)
                  unless hProjection[:scaleFactorAtCenterLine].nil?
                     @xml.tag!('sfctrlin', hProjection[:scaleFactorAtCenterLine].to_s)
                  end
                  if hProjection[:scaleFactorAtCenterLine].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Map Projection is missing scale factor at center line'
                  end
               end

               # map projection (sfprjorg) - scale factor at projection origin (required)
               def write_scaleFactorPO(hProjection)
                  unless hProjection[:scaleFactorAtProjectionOrigin].nil?
                     @xml.tag!('sfprjorg', hProjection[:scaleFactorAtProjectionOrigin].to_s)
                  end
                  if hProjection[:scaleFactorAtProjectionOrigin].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Map Projection is missing scale factor at projection origin'
                  end
               end

               # map projection (sfctrmer) - scale factor at central meridian (required)
               def write_scaleFactorCM(hProjection)
                  unless hProjection[:scaleFactorAtCentralMeridian].nil?
                     @xml.tag!('sfctrmer', hProjection[:scaleFactorAtCentralMeridian].to_s)
                  end
                  if hProjection[:scaleFactorAtCentralMeridian].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Map Projection is missing scale factor at central meridian'
                  end
               end

               # map projection (obqlazim) - oblique line azimuth (required)
               def write_obliqueLineAzimuth(hProjection)
                  haveLA = true
                  haveLA = false if hProjection[:azimuthAngle].nil?
                  haveLA = false if hProjection[:azimuthMeasurePointLongitude].nil?
                  if haveLA
                     @xml.tag!('obqlazim') do
                        unless hProjection[:azimuthAngle].nil?
                           @xml.tag!('azimangl', hProjection[:azimuthAngle].to_s)
                        end
                        if hProjection[:azimuthAngle].nil?
                           @hResponseObj[:writerPass] = false
                           @hResponseObj[:writerMessages] << 'Map Projection is missing oblique line azimuth angle'
                        end
                        unless hProjection[:azimuthMeasurePointLongitude].nil?
                           @xml.tag!('azimptl', hProjection[:azimuthMeasurePointLongitude].to_s)
                        end
                        if hProjection[:azimuthMeasurePointLongitude].nil?
                           @hResponseObj[:writerPass] = false
                           @hResponseObj[:writerMessages] << 'Map Projection is missing oblique line measure point longitude'
                        end
                     end
                  end
                  unless haveLA
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Map Projection is missing oblique line azimuth information'
                  end
               end

               # map projection (obqlpt) - oblique line point (required)
               def write_obliqueLinePoint(hLinePt)
                  unless hLinePt[:azimuthLineLatitude].nil?
                     @xml.tag!('obqllat', hLinePt[:azimuthLineLatitude])
                  end
                  if hLinePt[:azimuthLineLatitude].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Map Projection is missing oblique line point latitude'
                  end
                  unless hLinePt[:azimuthLineLongitude].nil?
                     @xml.tag!('obqllong', hLinePt[:azimuthLineLongitude])
                  end
                  if hLinePt[:azimuthLineLongitude].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Map Projection is missing oblique line point longitude'
                  end
               end

               # map projection (svlong) - straight vertical longitude from pole (required)
               def write_straightFromPole(hProjection)
                  unless hProjection[:straightVerticalLongitudeFromPole].nil?
                     @xml.tag!('svlong', hProjection[:straightVerticalLongitudeFromPole].to_s)
                  end
                  if hProjection[:straightVerticalLongitudeFromPole].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Map Projection is missing straight vertical longitude from pole'
                  end
               end

               # map projection (landsat) - landsat number (required)
               def write_landsat(hProjection)
                  unless hProjection[:landsatNumber].nil?
                     @xml.tag!('landsat', hProjection[:landsatNumber].to_s)
                  end
                  if hProjection[:landsatNumber].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Map Projection is missing Landsat number'
                  end
               end

               # map projection (pathnum) - landsat path (required)
               def write_landsatPath(hProjection)
                  unless hProjection[:landsatPath].nil?
                     @xml.tag!('pathnum', hProjection[:landsatPath].to_s)
                  end
                  if hProjection[:landsatPath].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Map Projection is missing Landsat path number'
                  end
               end

               # map projection (otherprj) - other projection description (required)
               def write_otherProjection(hProjection)
                  unless hProjection[:otherProjectionDescription].nil?
                     @xml.tag!('otherprj', hProjection[:otherProjectionDescription])
                  end
                  if hProjection[:otherProjectionDescription].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Map Projection is missing other projection description'
                  end
               end

               # map projection (mapprojp) - other projection description (required)
               def write_allParams(hProjection)
                  # save current writer error state
                  writerPass = @hResponseObj[:writerPass]
                  writerMessages = @hResponseObj[:writerMessages]

                  # write all parameters
                  write_falseNE(hProjection)
                  write_standParallel(hProjection)
                  write_longCM(hProjection)
                  write_latPO(hProjection)
                  write_heightPP(hProjection)
                  write_longPC(hProjection)
                  write_latPC(hProjection)
                  write_scaleFactorE(hProjection)
                  write_scaleFactorCL(hProjection)
                  write_scaleFactorPO(hProjection)
                  write_scaleFactorCM(hProjection)
                  write_obliqueLineAzimuth(hProjection)
                  unless hProjection[:obliqueLinePoints].empty?
                     @xml.tag!('obqlpt') do
                        hProjection[:obliqueLinePoints].each do |hLinePt|
                           write_obliqueLinePoint(hLinePt)
                        end
                     end
                  end
                  write_straightFromPole(hProjection)
                  write_landsat(hProjection)
                  write_landsatPath(hProjection)
                  write_otherProjection(hProjection)

                  # restore writer error state
                  @hResponseObj[:writerPass] = writerPass
                  @hResponseObj[:writerMessages] = writerMessages

               end

               # grid coordinate system (utmzone) - universal transverse mercator zone (required)
               def write_utmZone(hProjection)
                  unless hProjection[:gridZone].nil?
                     @xml.tag!('utmzone', hProjection[:gridZone])
                  end
                  if hProjection[:gridZone].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'UTM Projection is missing zone number'
                  end
               end

               # grid coordinate system (upszone) - universal polar stereographic zone (required)
               def write_upsZone(hProjection)
                  unless hProjection[:gridZone].nil?
                     @xml.tag!('upszone', hProjection[:gridZone])
                  end
                  if hProjection[:gridZone].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'UPS Projection is missing zone number'
                  end
               end

               # grid coordinate system (spcszone) - state plane coordinate system zone (required)
               def write_spcsZone(hProjection)
                  unless hProjection[:gridZone].nil?
                     @xml.tag!('spcszone', hProjection[:gridZone])
                  end
                  if hProjection[:gridZone].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'State Plane Coordinate System is missing zone number'
                  end
               end

               # grid coordinate system (arczone) - equal arc-second coordinate system zone (required)
               def write_arcZone(hProjection)
                  unless hProjection[:gridZone].nil?
                     @xml.tag!('arczone', hProjection[:gridZone])
                  end
                  if hProjection[:gridZone].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Equal arc-second Coordinate System is missing zone number'
                  end
               end

               # grid coordinate system (localpd) - local planar description (required)
               def write_localDesc(hProjection)
                  unless hProjection[:localPlanarDescription].nil?
                     @xml.tag!('localpd', hProjection[:localPlanarDescription])
                  end
                  if hProjection[:localPlanarDescription].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Local Planar Coordinate System is missing description'
                  end
               end

               # grid coordinate system (localpgi) - local planar georeference information (required)
               def write_localGeoInfo(hProjection)
                  unless hProjection[:localPlanarGeoreference].nil?
                     @xml.tag!('localpgi', hProjection[:localPlanarGeoreference])
                  end
                  if hProjection[:localPlanarGeoreference].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Local Planar Coordinate System is missing georeference information'
                  end
               end

            end # MapProjection

         end
      end
   end
end
