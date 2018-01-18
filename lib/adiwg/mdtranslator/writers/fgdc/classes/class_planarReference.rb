# FGDC <<Class>> PlanarReference
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-01-02 original script

require_relative 'class_mapProjection'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class PlanarReference

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hProjection)

                  # classes used
                  classProjection = MapProjection.new(@xml, @hResponseObj)

                  # planar 4.1.2.1 (mapproj) - map projection
                  # <- hProjection.projectionName = oneOf ...
                  projection = hProjection[:projection]
                  case projection
                     when 'alaska'
                        @xml.tag!('mapproj') do
                           classProjection.write_name('Modified Stereographic for Alaska')
                           @xml.tag!('modsak') do
                              classProjection.write_falseNE(hProjection)
                           end
                        end
                     when 'albers'
                        @xml.tag!('mapproj') do
                           classProjection.write_name('Albers Conical Equal Area')
                           @xml.tag!('albers') do
                              classProjection.write_standParallel(hProjection)
                              classProjection.write_longCM(hProjection)
                              classProjection.write_latPO(hProjection)
                              classProjection.write_falseNE(hProjection)
                           end
                        end
                     when 'azimuthalEquidistant'
                        @xml.tag!('mapproj') do
                           classProjection.write_name('Azimuthal Equidistant')
                           @xml.tag!('azimequi') do
                              classProjection.write_longCM(hProjection)
                              classProjection.write_latPO(hProjection)
                              classProjection.write_falseNE(hProjection)
                           end
                        end
                     when 'equidistantConic'
                        @xml.tag!('mapproj') do
                           classProjection.write_name('Equidistant Conic')
                           @xml.tag!('equicon') do
                              classProjection.write_standParallel(hProjection)
                              classProjection.write_longCM(hProjection)
                              classProjection.write_latPO(hProjection)
                              classProjection.write_falseNE(hProjection)
                           end
                        end
                     when 'equirectangular'
                        @xml.tag!('mapproj') do
                           classProjection.write_name('Equirectangular')
                           @xml.tag!('equirect') do
                              classProjection.write_standParallel(hProjection)
                              classProjection.write_longCM(hProjection)
                              classProjection.write_falseNE(hProjection)
                           end
                        end
                     when 'generalVertical'
                        @xml.tag!('mapproj') do
                           classProjection.write_name('General Vertical Near-sided Perspective')
                           @xml.tag!('gvnsp') do
                              classProjection.write_heightPP(hProjection)
                              classProjection.write_longPC(hProjection)
                              classProjection.write_latPC(hProjection)
                              classProjection.write_falseNE(hProjection)
                           end
                        end
                     when 'gnomonic'
                        @xml.tag!('mapproj') do
                           classProjection.write_name('Gnomonic')
                           @xml.tag!('gnomonic') do
                              classProjection.write_longPC(hProjection)
                              classProjection.write_latPC(hProjection)
                              classProjection.write_falseNE(hProjection)
                           end
                        end
                     when 'lambertEqualArea'
                        @xml.tag!('mapproj') do
                           classProjection.write_name('Lambert Azimuthal Equal Area')
                           @xml.tag!('lamberta') do
                              classProjection.write_longPC(hProjection)
                              classProjection.write_latPC(hProjection)
                              classProjection.write_falseNE(hProjection)
                           end
                        end
                     when 'lambertConic'
                        @xml.tag!('mapproj') do
                           classProjection.write_name('Lambert Conformal Conic')
                           @xml.tag!('lambertc') do
                              classProjection.write_standParallel(hProjection)
                              classProjection.write_longCM(hProjection)
                              classProjection.write_latPO(hProjection)
                              classProjection.write_falseNE(hProjection)
                           end
                        end
                     when 'mercator'
                        @xml.tag!('mapproj') do
                           classProjection.write_name('Mercator')
                           @xml.tag!('mercator') do
                              if hProjection[:standardParallel1] || hProjection[:standardParallel2]
                                 classProjection.write_standParallel(hProjection)
                              elsif hProjection[:scaleFactorAtEquator]
                                 classProjection.write_scaleFactorE(hProjection)
                              end
                              classProjection.write_longCM(hProjection)
                              classProjection.write_falseNE(hProjection)
                           end
                        end
                     when 'miller'
                        @xml.tag!('mapproj') do
                           classProjection.write_name('Miller Cylindrical')
                           @xml.tag!('miller') do
                              classProjection.write_longCM(hProjection)
                              classProjection.write_falseNE(hProjection)
                           end
                        end
                     when 'obliqueMercator'
                        @xml.tag!('mapproj') do
                           classProjection.write_name('Oblique Mercator')
                           @xml.tag!('obqmerc') do
                              classProjection.write_scaleFactorCL(hProjection)
                              if hProjection[:obliqueLinePoints].empty?
                                 classProjection.write_obliqueLineAzimuth(hProjection)
                              else
                                 @xml.tag!('obqlpt') do
                                    hProjection[:obliqueLinePoints].each do |hLinePt|
                                       classProjection.write_obliqueLinePoint(hLinePt)
                                    end
                                 end
                              end
                              classProjection.write_latPO(hProjection)
                              classProjection.write_falseNE(hProjection)
                           end
                        end
                     when 'orthographic'
                        @xml.tag!('mapproj') do
                           classProjection.write_name('Orthographic')
                           @xml.tag!('orthogr') do
                              classProjection.write_longPC(hProjection)
                              classProjection.write_latPC(hProjection)
                              classProjection.write_falseNE(hProjection)
                           end
                        end
                     when 'polarStereo'
                        @xml.tag!('mapproj') do
                           classProjection.write_name('Polar Stereographic')
                           @xml.tag!('polarst') do
                              classProjection.write_straightFromPole(hProjection)
                              if hProjection[:standardParallel1] || hProjection[:standardParallel2]
                                 classProjection.write_standParallel(hProjection)
                              elsif hProjection[:scaleFactorAtProjectionOrigin]
                                 classProjection.write_scaleFactorPO(hProjection)
                              end
                              classProjection.write_falseNE(hProjection)
                           end
                        end
                     when 'polyconic'
                        @xml.tag!('mapproj') do
                           classProjection.write_name('Polyconic')
                           @xml.tag!('polycon') do
                              classProjection.write_longCM(hProjection)
                              classProjection.write_latPO(hProjection)
                              classProjection.write_falseNE(hProjection)
                           end
                        end
                     when 'robinson'
                        @xml.tag!('mapproj') do
                           classProjection.write_name('Robinson')
                           @xml.tag!('robinson') do
                              classProjection.write_longPC(hProjection)
                              classProjection.write_falseNE(hProjection)
                           end
                        end
                     when 'sinusoidal'
                        @xml.tag!('mapproj') do
                           classProjection.write_name('Sinusoidal')
                           @xml.tag!('sinusoid') do
                              classProjection.write_longCM(hProjection)
                              classProjection.write_falseNE(hProjection)
                           end
                        end
                     when 'spaceOblique'
                        @xml.tag!('mapproj') do
                           classProjection.write_name('Space Oblique Mercator')
                           @xml.tag!('spaceobq') do
                              classProjection.write_landsat(hProjection)
                              classProjection.write_landsatPath(hProjection)
                              classProjection.write_falseNE(hProjection)
                           end
                        end
                     when 'stereographic'
                        @xml.tag!('mapproj') do
                           classProjection.write_name('Stereographic')
                           @xml.tag!('stereo') do
                              classProjection.write_longPC(hProjection)
                              classProjection.write_latPC(hProjection)
                              classProjection.write_falseNE(hProjection)
                           end
                        end
                     when 'transverseMercator'
                        @xml.tag!('mapproj') do
                           classProjection.write_name('Transverse Mercator')
                           @xml.tag!('transmer') do
                              classProjection.write_scaleFactorCM(hProjection)
                              classProjection.write_longCM(hProjection)
                              classProjection.write_latPO(hProjection)
                              classProjection.write_falseNE(hProjection)
                           end
                        end
                     when 'grinten'
                        @xml.tag!('mapproj') do
                           classProjection.write_name('van der Grinten')
                           @xml.tag!('vdgrin') do
                              classProjection.write_longCM(hProjection)
                              classProjection.write_falseNE(hProjection)
                           end
                        end
                     when 'parameters'
                        @xml.tag!('mapproj') do
                           classProjection.write_name('Map Projection Parameters')
                           @xml.tag!('mapprojp') do
                              classProjection.write_allParams(hProjection)
                           end
                        end
                  end

                  # planar 4.1.2.2 (gridsys) - grid coordinate system
                  # <- hProjection.projectionName = oneOf ...
                  gridSystem = hProjection[:gridSystem]
                  case gridSystem
                     when 'utm'
                        @xml.tag!('gridsys') do
                           if hProjection[:gridSystemName].nil?
                              classProjection.write_gridName('Universal Transverse Mercator (UTM)')
                           else
                              classProjection.write_gridName(hProjection[:gridSystemName])
                           end
                           @xml.tag!('utm') do
                              classProjection.write_utmZone(hProjection)
                              @xml.tag!('transmer') do
                                 classProjection.write_scaleFactorCM(hProjection)
                                 classProjection.write_longCM(hProjection)
                                 classProjection.write_latPO(hProjection)
                                 classProjection.write_falseNE(hProjection)
                              end
                           end
                        end
                     when 'ups'
                        @xml.tag!('gridsys') do
                           if hProjection[:gridSystemName].nil?
                              classProjection.write_gridName('Universal Polar Stereographic (UPS)')
                           else
                              classProjection.write_gridName(hProjection[:gridSystemName])
                           end
                           @xml.tag!('ups') do
                              classProjection.write_upsZone(hProjection)
                              @xml.tag!('polarst') do
                                 classProjection.write_straightFromPole(hProjection)
                                 if hProjection[:standardParallel1] || hProjection[:standardParallel2]
                                    classProjection.write_standParallel(hProjection)
                                 elsif hProjection[:scaleFactorAtProjectionOrigin]
                                    classProjection.write_scaleFactorPO(hProjection)
                                 end
                                 classProjection.write_falseNE(hProjection)
                              end
                           end
                        end
                     when 'spcs'
                        @xml.tag!('gridsys') do
                           if hProjection[:gridSystemName].nil?
                              classProjection.write_gridName('State Plane Coordinate System')
                           else
                              classProjection.write_gridName(hProjection[:gridSystemName])
                           end
                           @xml.tag!('spcs') do
                              classProjection.write_spcsZone(hProjection)
                              if hProjection[:standardParallel1] || hProjection[:standardParallel2]
                                 @xml.tag!('lambertc') do
                                    classProjection.write_standParallel(hProjection)
                                    classProjection.write_longCM(hProjection)
                                    classProjection.write_latPO(hProjection)
                                    classProjection.write_falseNE(hProjection)
                                 end
                              elsif hProjection[:scaleFactorAtCenterLine]
                                 @xml.tag!('obqmerc') do
                                    classProjection.write_scaleFactorCL(hProjection)
                                    if hProjection[:obliqueLinePoints].empty?
                                       classProjection.write_obliqueLineAzimuth(hProjection)
                                    else
                                       @xml.tag!('obqlpt') do
                                          hProjection[:obliqueLinePoints].each do |hLinePt|
                                             classProjection.write_obliqueLinePoint(hLinePt)
                                          end
                                       end
                                    end
                                    classProjection.write_latPO(hProjection)
                                    classProjection.write_falseNE(hProjection)
                                 end
                              elsif hProjection[:scaleFactorAtCentralMeridian]
                                 @xml.tag!('transmer') do
                                    classProjection.write_scaleFactorCM(hProjection)
                                    classProjection.write_longCM(hProjection)
                                    classProjection.write_latPO(hProjection)
                                    classProjection.write_falseNE(hProjection)
                                 end
                              else
                                 @xml.tag!('polycon') do
                                    classProjection.write_longCM(hProjection)
                                    classProjection.write_latPO(hProjection)
                                    classProjection.write_falseNE(hProjection)
                                 end
                              end
                           end
                        end
                     when 'arcsys'
                        @xml.tag!('gridsys') do
                           if hProjection[:gridSystemName].nil?
                              classProjection.write_gridName('Equal Arc-second Coordinate System')
                           else
                              classProjection.write_gridName(hProjection[:gridSystemName])
                           end
                           @xml.tag!('arcsys') do
                              classProjection.write_arcZone(hProjection)
                              if hProjection[:standardParallel1] || hProjection[:standardParallel2]
                                 @xml.tag!('equirect') do
                                    classProjection.write_standParallel(hProjection)
                                    classProjection.write_longCM(hProjection)
                                    classProjection.write_falseNE(hProjection)
                                 end
                              elsif hProjection[:latitudeOfProjectionOrigin]
                                 @xml.tag!('azimequi') do
                                    classProjection.write_longCM(hProjection)
                                    classProjection.write_latPO(hProjection)
                                    classProjection.write_falseNE(hProjection)
                                 end
                              end
                           end
                        end
                  end

                  # planar 4.1.2.3 (localp) - local planar
                  if projection == 'localPlanar'
                     @xml.tag!('localp') do
                        classProjection.write_localDesc(hProjection)
                        classProjection.write_localGeoInfo(hProjection)
                     end
                  end

               end # writeXML
            end # PlanarReference

         end
      end
   end
end
