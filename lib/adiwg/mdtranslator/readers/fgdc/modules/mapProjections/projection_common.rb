# Reader - fgdc to internal data structure
# unpack fgdc map projection - map projection parent

# History:
#  Stan Smith 2017-10-16 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module ProjectionCommon

               # instance classes needed in script
               @intMetadataClass = InternalMetadata.new

               # standard parallels
               def self.unpackStandParallel(xParams, hProjection, hResponseObj)
                  paramCount = 0
                  aStandP = xParams.xpath('./stdparll')
                  unless aStandP.empty?
                     aStandP.each_with_index do |xStandP, index|
                        standP = xStandP.text
                        unless standP.empty?
                           if index == 0
                              hProjection[:standardParallel1] = standP.to_f
                              paramCount += 1
                           else
                              hProjection[:standardParallel2] = standP.to_f
                              paramCount += 1
                           end
                        end
                     end
                  end
                  return paramCount
               end

               # longitude of central meridian
               def self.unpackLongCM(xParams, hProjection, hResponseObj)
                  longCM = xParams.xpath('./longcm').text
                  unless longCM.empty?
                     hProjection[:longitudeOfCentralMeridian] = longCM.to_f
                     return 1
                  end
                  return 0
               end

               # latitude of projection origin
               def self.unpackLatPO(xParams, hProjection, hResponseObj)
                  latPO = xParams.xpath('./latprjo').text
                  unless latPO.empty?
                     hProjection[:latitudeOfProjectionOrigin] = latPO.to_f
                     return 1
                  end
                  return 0
               end

               # false northing and easting(xParams, hProjection, hResponseObj)
               def self.unpackFalseNE(xParams, hProjection, hResponseObj)
                  paramCount = 0
                  falseE = xParams.xpath('./feast').text
                  unless falseE.empty?
                     hProjection[:falseEasting] = falseE.to_f
                     paramCount += 1
                  end
                  falseN = xParams.xpath('./fnorth').text
                  unless falseN.empty?
                     hProjection[:falseNorthing] = falseN.to_f
                     paramCount += 1
                  end
                  return paramCount
               end

               # height of perspective point above surface
               def self.unpackHeightAS(xParams, hProjection, hResponseObj)
                  heightAS = xParams.xpath('./heightpt').text
                  unless heightAS.empty?
                     hProjection[:heightOfProspectivePointAboveSurface] = heightAS.to_f
                     return 1
                  end
                  return 0
               end

               # longitude of projection center
               def self.unpackLongPC(xParams, hProjection, hResponseObj)
                  longPC = xParams.xpath('./longpc').text
                  unless longPC.empty?
                     hProjection[:longitudeOfProjectionCenter] = longPC.to_f
                     return 1
                  end
                  return 0
               end

               # latitude of projection center
               def self.unpackLatPC(xParams, hProjection, hResponseObj)
                  latPC = xParams.xpath('./latprjc').text
                  unless latPC.empty?
                     hProjection[:latitudeOfProjectionCenter] = latPC.to_f
                     return 1
                  end
                  return 0
               end

               # scale factor at equator
               def self.unpackSFEquator(xParams, hProjection, hResponseObj)
                  sFEquator = xParams.xpath('./sfequat').text
                  unless sFEquator.empty?
                     hProjection[:scaleFactorAtEquator] = sFEquator.to_f
                     return 1
                  end
                  return 0
               end

               # scale factor at center line
               def self.unpackSFCenter(xParams, hProjection, hResponseObj)
                  sFCenter = xParams.xpath('./sfctrlin').text
                  unless sFCenter.empty?
                     hProjection[:scaleFactorAtCenterLine] = sFCenter.to_f
                     return 1
                  end
                  return 0
               end

               # scale factor at central meridian
               def self.unpackSFCM(xParams, hProjection, hResponseObj)
                  sFCM = xParams.xpath('./sfctrmer').text
                  unless sFCM.empty?
                     hProjection[:scaleFactorAtCentralMeridian] = sFCM.to_f
                     return 1
                  end
                  return 0
               end

               # scale factor at projection origin
               def self.unpackSFPO(xParams, hProjection, hResponseObj)
                  sFProjectO = xParams.xpath('./sfprjorg').text
                  unless sFProjectO.empty?
                     hProjection[:scaleFactorAtProjectionOrigin] = sFProjectO.to_f
                     return 1
                  end
                  return 0
               end

               # oblique line azimuth
               def self.unpackObliqueLA(xParams, hProjection, hResponseObj)
                  xObliqueLA = xParams.xpath('./obqlazim')
                  unless xObliqueLA.empty?
                     paramCount = 0
                     lineAzimuth = xObliqueLA.xpath('./azimangl').text
                     unless lineAzimuth.empty?
                        hProjection[:azimuthAngle] = lineAzimuth.to_f
                        paramCount += 1
                     end
                     lineLong = xObliqueLA.xpath('./azimptl').text
                     unless lineLong.empty?
                        hProjection[:azimuthMeasurePointLongitude] = lineLong.to_f
                        paramCount += 1
                     end
                     return paramCount
                  end
                  return 0
               end

               # oblique line point
               def self.unpackObliqueLP(xParams, hProjection, hResponseObj)
                  xObliqueLP = xParams.xpath('./obqlpt')
                  unless xObliqueLP.empty?
                     paramCount = 0
                     hPoint1 = @intMetadataClass.newObliqueLinePoint
                     hPoint2 = @intMetadataClass.newObliqueLinePoint

                     lat1 = xObliqueLP.xpath('./obqllat[1]').text
                     unless lat1.empty?
                        hPoint1[:azimuthLineLatitude] = lat1.to_f
                        paramCount += 1
                     end
                     long1 = xObliqueLP.xpath('./obqllong[1]').text
                     unless long1.empty?
                        hPoint1[:azimuthLineLongitude] = long1.to_f
                        paramCount += 1
                     end

                     lat2 = xObliqueLP.xpath('./obqllat[2]').text
                     unless lat2.empty?
                        hPoint2[:azimuthLineLatitude] = lat2.to_f
                        paramCount += 1
                     end
                     long2 = xObliqueLP.xpath('./obqllong[2]').text
                     unless long2.empty?
                        hPoint2[:azimuthLineLongitude] = long2.to_f
                        paramCount += 1
                     end

                     if paramCount == 4
                        hProjection[:obliqueLinePoints] << hPoint1
                        hProjection[:obliqueLinePoints] << hPoint2
                        return hProjection[:obliqueLinePoints].length
                     end

                  end
                  return 0
               end

               # straight vertical longitude from pole
               def self.unpackVSLong(xParams, hProjection, hResponseObj)
                  sVLongP = xParams.xpath('./svlong').text
                  unless sVLongP.empty?
                     hProjection[:straightVerticalLongitudeFromPole] = sVLongP.to_f
                     return 1
                  end
                  return 0
               end

               # landsat number
               def self.unpackLandSat(xParams, hProjection, hResponseObj)
                  landsatN = xParams.xpath('./landsat').text
                  unless landsatN.empty?
                     hProjection[:landsatNumber] = landsatN.to_i
                     return 1
                  end
                  return 0
               end

               # landsat path number
               def self.unpackLandSatPath(xParams, hProjection, hResponseObj)
                  landsatP = xParams.xpath('./pathnum').text
                  unless landsatP.empty?
                     hProjection[:landsatPath] = landsatP.to_i
                     return 1
                  end
                  return 0
               end

               # other projection
               def self.unpackOtherProjection(xParams, hProjection, hResponseObj)
                  other = xParams.xpath('./otherprj').text
                  unless other.empty?
                     hProjection[:otherProjectionDescription] = other
                     return 1
                  end
                  return 0
               end

            end

         end
      end
   end
end
