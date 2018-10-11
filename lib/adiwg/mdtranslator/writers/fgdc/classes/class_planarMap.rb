# FGDC <<Class>> PlanarReference
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-10-10 refactor mdJson projection object
#  Stan Smith 2018-03-21 original script

require_relative 'class_mapProjectionTags'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class PlanarMap

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hProjection, inContext = nil)

                  # classes used
                  classTags = MapProjectionTags.new(@xml, @hResponseObj)

                  outContext = 'map projection'
                  outContext = inContext + ' ' + outContext unless inContext.nil?

                  # planar 4.1.2.1 (mapproj) - map projection
                  # <- hProjection.projectionName = oneOf ...
                  projection = hProjection[:projectionIdentifier][:identifier]
                  projectionName = nil
                  if hProjection.key?(:name)
                     projectionName = hProjection[:name]
                  end
                  case projection
                     when 'alaska'
                        @xml.tag!('mapproj') do
                           projectionName = 'Alaska Modified Stereographic' if projectionName.nil?
                           classTags.write_name(projectionName)
                           @xml.tag!('modsak') do
                              classTags.write_falseNE(hProjection, outContext)
                           end
                        end
                     when 'albers'
                        @xml.tag!('mapproj') do
                           projectionName = 'Albers Conical Equal Area'
                           classTags.write_name(projectionName)
                           @xml.tag!('albers') do
                              classTags.write_standParallel(hProjection, outContext)
                              classTags.write_longCM(hProjection, outContext)
                              classTags.write_latPO(hProjection, outContext)
                              classTags.write_falseNE(hProjection, outContext)
                           end
                        end
                     when 'azimuthalEquidistant'
                        @xml.tag!('mapproj') do
                           projectionName = 'Azimuthal Equidistant'
                           hProjection[:projectionName] = projectionName if hProjection[:projectionName].nil?
                           classTags.write_name(projectionName)
                           @xml.tag!('azimequi') do
                              classTags.write_longCM(hProjection)
                              classTags.write_latPO(hProjection)
                              classTags.write_falseNE(hProjection)
                           end
                        end
                     when 'equidistantConic'
                        @xml.tag!('mapproj') do
                           projectionName = 'Equidistant Conic'
                           hProjection[:projectionName] = projectionName if hProjection[:projectionName].nil?
                           classTags.write_name(projectionName)
                           @xml.tag!('equicon') do
                              classTags.write_standParallel(hProjection)
                              classTags.write_longCM(hProjection)
                              classTags.write_latPO(hProjection)
                              classTags.write_falseNE(hProjection)
                           end
                        end
                     when 'equirectangular'
                        @xml.tag!('mapproj') do
                           projectionName = 'Equirectangular'
                           hProjection[:projectionName] = projectionName if hProjection[:projectionName].nil?
                           classTags.write_name(projectionName)
                           @xml.tag!('equirect') do
                              classTags.write_standParallel(hProjection)
                              classTags.write_longCM(hProjection)
                              classTags.write_falseNE(hProjection)
                           end
                        end
                     when 'generalVertical'
                        @xml.tag!('mapproj') do
                           projectionName = 'General Vertical Near-sided Perspective'
                           hProjection[:projectionName] = projectionName if hProjection[:projectionName].nil?
                           classTags.write_name(projectionName)
                           @xml.tag!('gvnsp') do
                              classTags.write_heightPP(hProjection)
                              classTags.write_longPC(hProjection)
                              classTags.write_latPC(hProjection)
                              classTags.write_falseNE(hProjection)
                           end
                        end
                     when 'gnomonic'
                        @xml.tag!('mapproj') do
                           projectionName = 'Gnomonic'
                           hProjection[:projectionName] = projectionName if hProjection[:projectionName].nil?
                           classTags.write_name(projectionName)
                           @xml.tag!('gnomonic') do
                              classTags.write_longPC(hProjection)
                              classTags.write_latPC(hProjection)
                              classTags.write_falseNE(hProjection)
                           end
                        end
                     when 'lambertEqualArea'
                        @xml.tag!('mapproj') do
                           projectionName = 'Lambert Azimuthal Equal Area'
                           hProjection[:projectionName] = projectionName if hProjection[:projectionName].nil?
                           classTags.write_name(projectionName)
                           @xml.tag!('lamberta') do
                              classTags.write_longPC(hProjection)
                              classTags.write_latPC(hProjection)
                              classTags.write_falseNE(hProjection)
                           end
                        end
                     when 'lambertConic'
                        @xml.tag!('mapproj') do
                           projectionName = 'Lambert Conformal Conic'
                           hProjection[:projectionName] = projectionName if hProjection[:projectionName].nil?
                           classTags.write_name(projectionName)
                           @xml.tag!('lambertc') do
                              classTags.write_standParallel(hProjection)
                              classTags.write_longCM(hProjection)
                              classTags.write_latPO(hProjection)
                              classTags.write_falseNE(hProjection)
                           end
                        end
                     when 'mercator'
                        @xml.tag!('mapproj') do
                           projectionName = 'Mercator'
                           hProjection[:projectionName] = projectionName if hProjection[:projectionName].nil?
                           classTags.write_name(projectionName)
                           @xml.tag!('mercator') do
                              if hProjection[:standardParallel1] || hProjection[:standardParallel2]
                                 classTags.write_standParallel(hProjection)
                              elsif hProjection[:scaleFactorAtEquator]
                                 classTags.write_scaleFactorE(hProjection)
                              end
                              classTags.write_longCM(hProjection)
                              classTags.write_falseNE(hProjection)
                           end
                        end
                     when 'miller'
                        @xml.tag!('mapproj') do
                           projectionName = 'Miller Cylindrical'
                           hProjection[:projectionName] = projectionName if hProjection[:projectionName].nil?
                           classTags.write_name(projectionName)
                           @xml.tag!('miller') do
                              classTags.write_longCM(hProjection)
                              classTags.write_falseNE(hProjection)
                           end
                        end
                     when 'obliqueMercator'
                        @xml.tag!('mapproj') do
                           projectionName = 'Oblique Mercator'
                           hProjection[:projectionName] = projectionName if hProjection[:projectionName].nil?
                           classTags.write_name(projectionName)
                           @xml.tag!('obqmerc') do
                              classTags.write_scaleFactorCL(hProjection)
                              if hProjection[:obliqueLinePoints].empty?
                                 classTags.write_obliqueLineAzimuth(hProjection)
                              else
                                 @xml.tag!('obqlpt') do
                                    hProjection[:obliqueLinePoints].each do |hLinePt|
                                       classTags.write_obliqueLinePoint(hLinePt)
                                    end
                                 end
                              end
                              classTags.write_latPO(hProjection)
                              classTags.write_falseNE(hProjection)
                           end
                        end
                     when 'orthographic'
                        @xml.tag!('mapproj') do
                           projectionName = 'Orthographic'
                           hProjection[:projectionName] = projectionName if hProjection[:projectionName].nil?
                           classTags.write_name(projectionName)
                           @xml.tag!('orthogr') do
                              classTags.write_longPC(hProjection)
                              classTags.write_latPC(hProjection)
                              classTags.write_falseNE(hProjection)
                           end
                        end
                     when 'polarStereo'
                        @xml.tag!('mapproj') do
                           projectionName = 'Polar Stereographic'
                           hProjection[:projectionName] = projectionName if hProjection[:projectionName].nil?
                           classTags.write_name(projectionName)
                           @xml.tag!('polarst') do
                              classTags.write_straightFromPole(hProjection)
                              if hProjection[:standardParallel1] || hProjection[:standardParallel2]
                                 classTags.write_standParallel(hProjection)
                              elsif hProjection[:scaleFactorAtProjectionOrigin]
                                 classTags.write_scaleFactorPO(hProjection)
                              end
                              classTags.write_falseNE(hProjection)
                           end
                        end
                     when 'polyconic'
                        @xml.tag!('mapproj') do
                           projectionName = 'Polyconic'
                           hProjection[:projectionName] = projectionName if hProjection[:projectionName].nil?
                           classTags.write_name(projectionName)
                           @xml.tag!('polycon') do
                              classTags.write_longCM(hProjection)
                              classTags.write_latPO(hProjection)
                              classTags.write_falseNE(hProjection)
                           end
                        end
                     when 'robinson'
                        @xml.tag!('mapproj') do
                           projectionName = 'Robinson'
                           hProjection[:projectionName] = projectionName if hProjection[:projectionName].nil?
                           classTags.write_name(projectionName)
                           @xml.tag!('robinson') do
                              classTags.write_longPC(hProjection)
                              classTags.write_falseNE(hProjection)
                           end
                        end
                     when 'sinusoidal'
                        @xml.tag!('mapproj') do
                           projectionName = 'Sinusoidal'
                           hProjection[:projectionName] = projectionName if hProjection[:projectionName].nil?
                           classTags.write_name(projectionName)
                           @xml.tag!('sinusoid') do
                              classTags.write_longCM(hProjection)
                              classTags.write_falseNE(hProjection)
                           end
                        end
                     when 'spaceOblique'
                        @xml.tag!('mapproj') do
                           projectionName = 'Space Oblique Mercator'
                           hProjection[:projectionName] = projectionName if hProjection[:projectionName].nil?
                           classTags.write_name(projectionName)
                           @xml.tag!('spaceobq') do
                              classTags.write_landsat(hProjection)
                              classTags.write_landsatPath(hProjection)
                              classTags.write_falseNE(hProjection)
                           end
                        end
                     when 'stereographic'
                        @xml.tag!('mapproj') do
                           projectionName = 'Stereographic'
                           hProjection[:projectionName] = projectionName if hProjection[:projectionName].nil?
                           classTags.write_name(projectionName)
                           @xml.tag!('stereo') do
                              classTags.write_longPC(hProjection)
                              classTags.write_latPC(hProjection)
                              classTags.write_falseNE(hProjection)
                           end
                        end
                     when 'transverseMercator'
                        @xml.tag!('mapproj') do
                           projectionName = 'Transverse Mercator'
                           hProjection[:projectionName] = projectionName if hProjection[:projectionName].nil?
                           classTags.write_name(projectionName)
                           @xml.tag!('transmer') do
                              classTags.write_scaleFactorCM(hProjection)
                              classTags.write_longCM(hProjection)
                              classTags.write_latPO(hProjection)
                              classTags.write_falseNE(hProjection)
                           end
                        end
                     when 'grinten'
                        @xml.tag!('mapproj') do
                           projectionName = 'Van der Grinten'
                           hProjection[:projectionName] = projectionName if hProjection[:projectionName].nil?
                           classTags.write_name(projectionName)
                           @xml.tag!('vdgrin') do
                              classTags.write_longCM(hProjection)
                              classTags.write_falseNE(hProjection)
                           end
                        end
                     when 'parameters'
                        @xml.tag!('mapproj') do
                           projectionName = 'Map Projection Parameters'
                           hProjection[:projectionName] = projectionName if hProjection[:projectionName].nil?
                           classTags.write_name(projectionName)
                           @xml.tag!('mapprojp') do
                              classTags.write_allParams(hProjection)
                           end
                        end
                  end

               end # writeXML
            end # PlanarMap

         end
      end
   end
end
