# FGDC <<Class>> MapProjection
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-10-09 refactor mdJson projection object
#  Stan Smith 2018-03-20 refactored error and warning messaging
#  Stan Smith 2018-01-02 original script

require_relative '../fgdc_writer'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class MapProjectionTags

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

                def outContext(inContext, hIdentifier = {})
                   outContext = hIdentifier.empty? ? nil : hIdentifier[:projectionIdentifier][:identifier]
                   return nil if inContext.nil? && outContext.nil?
                   return inContext if outContext.nil?
                   return outContext if inContext.nil?
                   return inContext + ' ' + outContext
                end

               # map projection 4.1.2.1.1 (mapprojn) - projection name (required)
               def write_name(projectionName, inContext = nil)
                  unless projectionName.nil?
                     @xml.tag!('mapprojn', projectionName)
                  end
                  if projectionName.nil?
                     @NameSpace.issueWarning(280, 'mapprojn', inContext)
                  end
               end

               # map projection 4.1.2.2.1 (gridsysn) - grid system name
               def write_gridName(gridSystem, inContext = nil)
                  unless gridSystem.nil?
                     @xml.tag!('gridsysn', gridSystem, inContext)
                  end
                  if gridSystem.nil? && @hResponseObj[:writerShowTag]
                     @xml.tag!('gridsysn')
                  end
               end

               # map projection (feast) - false easting (required)
               # map projection (fnorth) - false northing (required)
               def write_falseNE(hProjection, inContext = nil)
                  unless hProjection[:falseEasting].nil?
                     @xml.tag!('feast', hProjection[:falseEasting].to_s)
                  end
                  if hProjection[:falseEasting].nil?
                     @NameSpace.issueError(281, outContext(inContext, hProjection))
                  end
                  unless hProjection[:falseNorthing].nil?
                     @xml.tag!('fnorth', hProjection[:falseNorthing].to_s)
                  end
                  if hProjection[:falseNorthing].nil?
                     @NameSpace.issueError(282, outContext(inContext, hProjection))
                  end
               end

               # map projection (stdparll) - standard parallel (at least one required)
               def write_standParallel(hProjection, inContext = nil)
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
                     @NameSpace.issueError(283, outContext(inContext, hProjection))
                  end
               end

               # map projection (longcm) - longitude of central meridian (required)
               def write_longCM(hProjection, inContext = nil)
                  unless hProjection[:longitudeOfCentralMeridian].nil?
                     @xml.tag!('longcm', hProjection[:longitudeOfCentralMeridian].to_s)
                  end
                  if hProjection[:longitudeOfCentralMeridian].nil?
                     @NameSpace.issueError(284, outContext(inContext, hProjection))
                  end
               end

               # map projection (latprjo) - latitude of projection origin (required)
               def write_latPO(hProjection, inContext = nil)
                  unless hProjection[:latitudeOfProjectionOrigin].nil?
                     @xml.tag!('latprjo', hProjection[:latitudeOfProjectionOrigin].to_s)
                  end
                  if hProjection[:latitudeOfProjectionOrigin].nil?
                     @NameSpace.issueError(285, outContext(inContext, hProjection))
                  end
               end

               # map projection (heightpt) - height of perspective point above surface (required)
               def write_heightPP(hProjection, inContext = nil)
                  unless hProjection[:heightOfProspectivePointAboveSurface].nil?
                     @xml.tag!('heightpt', hProjection[:heightOfProspectivePointAboveSurface].to_s)
                  end
                  if hProjection[:heightOfProspectivePointAboveSurface].nil?
                     @NameSpace.issueError(286, outContext(inContext, hProjection))
                  end
               end

               # map projection (longpc) - longitude of projection center (required)
               def write_longPC(hProjection, inContext = nil)
                  unless hProjection[:longitudeOfProjectionCenter].nil?
                     @xml.tag!('longpc', hProjection[:longitudeOfProjectionCenter].to_s)
                  end
                  if hProjection[:longitudeOfProjectionCenter].nil?
                     @NameSpace.issueError(287, outContext(inContext, hProjection))
                  end
               end

               # map projection (latprjc) - latitude of projection center (required)
               def write_latPC(hProjection, inContext = nil)
                  unless hProjection[:latitudeOfProjectionCenter].nil?
                     @xml.tag!('latprjc', hProjection[:latitudeOfProjectionCenter].to_s)
                  end
                  if hProjection[:latitudeOfProjectionCenter].nil?
                     @NameSpace.issueError(288, outContext(inContext, hProjection))
                  end
               end

               # map projection (sfequat) - scale factor at equator (required)
               def write_scaleFactorE(hProjection, inContext = nil)
                  unless hProjection[:scaleFactorAtEquator].nil?
                     @xml.tag!('sfequat', hProjection[:scaleFactorAtEquator].to_s)
                  end
                  if hProjection[:scaleFactorAtEquator].nil?
                     @NameSpace.issueError(289, outContext(inContext, hProjection))
                  end
               end

               # map projection (sfctrlin) - scale factor at center line (required)
               def write_scaleFactorCL(hProjection, inContext = nil)
                  unless hProjection[:scaleFactorAtCenterLine].nil?
                     @xml.tag!('sfctrlin', hProjection[:scaleFactorAtCenterLine].to_s)
                  end
                  if hProjection[:scaleFactorAtCenterLine].nil?
                     @NameSpace.issueError(290, outContext(inContext, hProjection))
                  end
               end

               # map projection (sfprjorg) - scale factor at projection origin (required)
               def write_scaleFactorPO(hProjection, inContext = nil)
                  unless hProjection[:scaleFactorAtProjectionOrigin].nil?
                     @xml.tag!('sfprjorg', hProjection[:scaleFactorAtProjectionOrigin].to_s)
                  end
                  if hProjection[:scaleFactorAtProjectionOrigin].nil?
                     @NameSpace.issueError(291, outContext(inContext, hProjection))
                  end
               end

               # map projection (sfctrmer) - scale factor at central meridian (required)
               def write_scaleFactorCM(hProjection, inContext = nil)
                  unless hProjection[:scaleFactorAtCentralMeridian].nil?
                     @xml.tag!('sfctrmer', hProjection[:scaleFactorAtCentralMeridian].to_s)
                  end
                  if hProjection[:scaleFactorAtCentralMeridian].nil?
                     @NameSpace.issueError(292, outContext(inContext, hProjection))
                  end
               end

               # map projection (obqlazim) - oblique line azimuth (required)
               def write_obliqueLineAzimuth(hProjection, inContext = nil)
                  haveLA = true
                  haveLA = false if hProjection[:azimuthAngle].nil?
                  haveLA = false if hProjection[:azimuthMeasurePointLongitude].nil?
                  if haveLA
                     @xml.tag!('obqlazim') do
                        unless hProjection[:azimuthAngle].nil?
                           @xml.tag!('azimangl', hProjection[:azimuthAngle].to_s)
                        end
                        if hProjection[:azimuthAngle].nil?
                           @NameSpace.issueError(293, outContext(inContext, hProjection))
                        end
                        unless hProjection[:azimuthMeasurePointLongitude].nil?
                           @xml.tag!('azimptl', hProjection[:azimuthMeasurePointLongitude].to_s)
                        end
                        if hProjection[:azimuthMeasurePointLongitude].nil?
                           @NameSpace.issueError(294, outContext(inContext, hProjection))
                        end
                     end
                  end
                  unless haveLA
                     @NameSpace.issueError(295, outContext(inContext, hProjection))
                  end
               end

               # map projection (obqlpt) - oblique line point (required)
               def write_obliqueLinePoint(hLinePt, inContext = nil)
                  unless hLinePt[:obliqueLineLatitude].nil?
                     @xml.tag!('obqllat', hLinePt[:obliqueLineLatitude])
                  end
                  if hLinePt[:obliqueLineLatitude].nil?
                     @NameSpace.issueError(296, outContext(inContext, hProjection))
                  end
                  unless hLinePt[:obliqueLineLongitude].nil?
                     @xml.tag!('obqllong', hLinePt[:obliqueLineLongitude])
                  end
                  if hLinePt[:obliqueLineLongitude].nil?
                     @NameSpace.issueError(297, outContext(inContext, hProjection))
                  end
               end

               # map projection (svlong) - straight vertical longitude from pole (required)
               def write_straightFromPole(hProjection, inContext = nil)
                  unless hProjection[:straightVerticalLongitudeFromPole].nil?
                     @xml.tag!('svlong', hProjection[:straightVerticalLongitudeFromPole].to_s)
                  end
                  if hProjection[:straightVerticalLongitudeFromPole].nil?
                     @NameSpace.issueError(298, outContext(inContext, hProjection))
                  end
               end

               # map projection (landsat) - landsat number (required)
               def write_landsat(hProjection, inContext = nil)
                  unless hProjection[:landsatNumber].nil?
                     @xml.tag!('landsat', hProjection[:landsatNumber].to_s)
                  end
                  if hProjection[:landsatNumber].nil?
                     @NameSpace.issueError(299, outContext(inContext, hProjection))
                  end
               end

               # map projection (pathnum) - landsat path (required)
               def write_landsatPath(hProjection, inContext = nil)
                  unless hProjection[:landsatPath].nil?
                     @xml.tag!('pathnum', hProjection[:landsatPath].to_s)
                  end
                  if hProjection[:landsatPath].nil?
                     @NameSpace.issueError(300, outContext(inContext, hProjection))
                  end
               end

               # map projection (otherprj) - other projection description (required)
               def write_otherProjection(hProjection, inContext = nil)
                  unless hProjection[:otherProjectionDescription].nil?
                     @xml.tag!('otherprj', hProjection[:otherProjectionDescription])
                  end
                  if hProjection[:otherProjectionDescription].nil?
                     @NameSpace.issueError(301, outContext(inContext, hProjection))
                  end
               end

               # map projection (mapprojp) - other projection description (required)
               def write_allParams(hProjection, inContext)
                  # save current writer error state
                  writerPass = @hResponseObj[:writerPass]
                  writerMessages = @hResponseObj[:writerMessages]

                  # write all parameters
                  unless hProjection[:falseNorthing].nil?
                     write_falseNE(hProjection, inContext)
                  end
                  unless hProjection[:standardParallel1].nil?
                     write_standParallel(hProjection, inContext)
                  end
                  unless hProjection[:longitudeOfCentralMeridian].nil?
                     write_longCM(hProjection, inContext)
                  end
                  unless hProjection[:latitudeOfProjectionOrigin].nil?
                     write_latPO(hProjection, inContext)
                  end
                  unless hProjection[:heightOfProspectivePointAboveSurface].nil?
                     write_heightPP(hProjection, inContext)
                  end
                  unless hProjection[:longitudeOfProjectionCenter].nil?
                     write_longPC(hProjection, inContext)
                  end
                  unless hProjection[:latitudeOfProjectionCenter].nil?
                     write_latPC(hProjection, inContext)
                  end
                  unless hProjection[:scaleFactorAtEquator].nil?
                     write_scaleFactorE(hProjection, inContext)
                  end
                  unless hProjection[:scaleFactorAtCenterLine].nil?
                     write_scaleFactorCL(hProjection, inContext)
                  end
                  unless hProjection[:scaleFactorAtProjectionOrigin].nil?
                     write_scaleFactorPO(hProjection, inContext)
                  end
                  unless hProjection[:scaleFactorAtCentralMeridian].nil?
                     write_scaleFactorCM(hProjection, inContext)
                  end
                  unless hProjection[:azimuthAngle].nil?
                     write_obliqueLineAzimuth(hProjection, inContext)
                  end
                  unless hProjection[:obliqueLinePoints].empty?
                     @xml.tag!('obqlpt') do
                        hProjection[:obliqueLinePoints].each do |hLinePt|
                           write_obliqueLinePoint(hLinePt, inContext)
                        end
                     end
                  end
                  unless hProjection[:straightVerticalLongitudeFromPole].nil?
                     write_straightFromPole(hProjection, inContext)
                  end
                  unless hProjection[:landsatNumber].nil?
                     write_landsat(hProjection, inContext)
                  end
                  unless hProjection[:landsatPath].nil?
                     write_landsatPath(hProjection, inContext)
                  end
                  write_otherProjection(hProjection, inContext)

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
                     @NameSpace.issueError(310, 'grid system')
                  end
               end

               # grid coordinate system (upszone) - universal polar stereographic zone (required)
               def write_upsZone(hProjection)
                  unless hProjection[:gridZone].nil?
                     @xml.tag!('upszone', hProjection[:gridZone])
                  end
                  if hProjection[:gridZone].nil?
                     @NameSpace.issueError(311, 'grid system')
                  end
               end

               # grid coordinate system (spcszone) - state plane coordinate system zone (required)
               def write_spcsZone(hProjection)
                  unless hProjection[:gridZone].nil?
                     @xml.tag!('spcszone', hProjection[:gridZone])
                  end
                  if hProjection[:gridZone].nil?
                     @NameSpace.issueError(312, 'grid system')
                  end
               end

               # grid coordinate system (arczone) - equal arc-second coordinate system zone (required)
               def write_arcZone(hProjection)
                  unless hProjection[:gridZone].nil?
                     @xml.tag!('arczone', hProjection[:gridZone])
                  end
                  if hProjection[:gridZone].nil?
                     @NameSpace.issueError(313, 'grid system')
                  end
               end

               # grid coordinate system (localpd) - local planar description (required)
               def write_localDesc(hLocal, inContext)
                  unless hLocal.empty?
                     @xml.tag!('localpd', hLocal[:description])
                  end
                  if hLocal[:description].nil?
                     @NameSpace.issueError(471, outContext(inContext, hProjection))
                  end
               end

               # grid coordinate system (localpgi) - local planar georeference information (required)
               def write_localGeoInfo(hLocal, inContext)
                  unless hLocal.empty?
                     @xml.tag!('localpgi', hLocal[:georeference])
                  end
                  if hLocal[:georeference].nil?
                     @NameSpace.issueError(472, outContext(inContext, hProjection))
                  end
               end

            end # MapProjection

         end
      end
   end
end
