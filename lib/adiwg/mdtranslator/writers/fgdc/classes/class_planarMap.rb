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
                           classTags.write_name(projectionName)
                           @xml.tag!('azimequi') do
                              classTags.write_longCM(hProjection, outContext)
                              classTags.write_latPO(hProjection, outContext)
                              classTags.write_falseNE(hProjection, outContext)
                           end
                        end
                     when 'equidistantConic'
                        @xml.tag!('mapproj') do
                           projectionName = 'Equidistant Conic'
                           classTags.write_name(projectionName)
                           @xml.tag!('equicon') do
                              classTags.write_standParallel(hProjection, outContext)
                              classTags.write_longCM(hProjection, outContext)
                              classTags.write_latPO(hProjection, outContext)
                              classTags.write_falseNE(hProjection, outContext)
                           end
                        end
                     when 'equirectangular'
                        @xml.tag!('mapproj') do
                           projectionName = 'Equirectangular'
                           classTags.write_name(projectionName)
                           @xml.tag!('equirect') do
                              classTags.write_standParallel(hProjection, outContext)
                              classTags.write_longCM(hProjection, outContext)
                              classTags.write_falseNE(hProjection, outContext)
                           end
                        end
                     when 'generalVertical'
                        @xml.tag!('mapproj') do
                           projectionName = 'General Vertical Near-sided Perspective'
                           classTags.write_name(projectionName)
                           @xml.tag!('gvnsp') do
                              classTags.write_heightPP(hProjection, outContext)
                              classTags.write_longPC(hProjection, outContext)
                              classTags.write_latPC(hProjection, outContext)
                              classTags.write_falseNE(hProjection, outContext)
                           end
                        end
                     when 'gnomonic'
                        @xml.tag!('mapproj') do
                           projectionName = 'Gnomonic'
                           classTags.write_name(projectionName)
                           @xml.tag!('gnomonic') do
                              classTags.write_longPC(hProjection, outContext)
                              classTags.write_latPC(hProjection, outContext)
                              classTags.write_falseNE(hProjection, outContext)
                           end
                        end
                     when 'lambertEqualArea'
                        @xml.tag!('mapproj') do
                           projectionName = 'Lambert Azimuthal Equal Area'
                           classTags.write_name(projectionName)
                           @xml.tag!('lamberta') do
                              classTags.write_longPC(hProjection, outContext)
                              classTags.write_latPC(hProjection, outContext)
                              classTags.write_falseNE(hProjection, outContext)
                           end
                        end
                     when 'lambertConic'
                        @xml.tag!('mapproj') do
                           projectionName = 'Lambert Conformal Conic'
                           classTags.write_name(projectionName)
                           @xml.tag!('lambertc') do
                              classTags.write_standParallel(hProjection, outContext)
                              classTags.write_longCM(hProjection, outContext)
                              classTags.write_latPO(hProjection, outContext)
                              classTags.write_falseNE(hProjection, outContext)
                           end
                        end
                     when 'mercator'
                        @xml.tag!('mapproj') do
                           projectionName = 'Mercator'
                           classTags.write_name(projectionName)
                           @xml.tag!('mercator') do
                              if hProjection[:scaleFactorAtEquator]
                                 classTags.write_scaleFactorE(hProjection, outContext)
                              else
                                 classTags.write_standParallel(hProjection, outContext)
                              end
                              classTags.write_longCM(hProjection, outContext)
                              classTags.write_falseNE(hProjection, outContext)
                           end
                        end
                     when 'miller'
                        @xml.tag!('mapproj') do
                           projectionName = 'Miller Cylindrical'
                           classTags.write_name(projectionName)
                           @xml.tag!('miller') do
                              classTags.write_longCM(hProjection, outContext)
                              classTags.write_falseNE(hProjection, outContext)
                           end
                        end
                     when 'obliqueMercator'
                        @xml.tag!('mapproj') do
                           projectionName = 'Oblique Mercator'
                           classTags.write_name(projectionName)
                           @xml.tag!('obqmerc') do
                              classTags.write_scaleFactorCL(hProjection, outContext)
                              if hProjection[:obliqueLinePoints].empty?
                                 classTags.write_obliqueLineAzimuth(hProjection, outContext)
                              else
                                 classTags.write_obliqueLinePoint(hProjection, outContext)
                              end
                              classTags.write_latPO(hProjection, outContext)
                              classTags.write_falseNE(hProjection, outContext)
                           end
                        end
                     when 'orthographic'
                        @xml.tag!('mapproj') do
                           projectionName = 'Orthographic'
                           classTags.write_name(projectionName)
                           @xml.tag!('orthogr') do
                              classTags.write_longPC(hProjection, outContext)
                              classTags.write_latPC(hProjection, outContext)
                              classTags.write_falseNE(hProjection, outContext)
                           end
                        end
                     when 'polarStereo'
                        @xml.tag!('mapproj') do
                           projectionName = 'Polar Stereographic'
                           classTags.write_name(projectionName)
                           @xml.tag!('polarst') do
                              classTags.write_straightFromPole(hProjection, outContext)
                              if hProjection[:standardParallel1] || hProjection[:standardParallel2]
                                 classTags.write_standParallel(hProjection, outContext)
                              else hProjection[:scaleFactorAtProjectionOrigin]
                                 classTags.write_scaleFactorPO(hProjection, outContext)
                              end
                              classTags.write_falseNE(hProjection, outContext)
                           end
                        end
                     when 'polyconic'
                        @xml.tag!('mapproj') do
                           projectionName = 'Polyconic'
                           classTags.write_name(projectionName)
                           @xml.tag!('polycon') do
                              classTags.write_longCM(hProjection, outContext)
                              classTags.write_latPO(hProjection, outContext)
                              classTags.write_falseNE(hProjection, outContext)
                           end
                        end
                     when 'robinson'
                        @xml.tag!('mapproj') do
                           projectionName = 'Robinson'
                           classTags.write_name(projectionName)
                           @xml.tag!('robinson') do
                              classTags.write_longPC(hProjection, outContext)
                              classTags.write_falseNE(hProjection, outContext)
                           end
                        end
                     when 'sinusoidal'
                        @xml.tag!('mapproj') do
                           projectionName = 'Sinusoidal'
                           classTags.write_name(projectionName)
                           @xml.tag!('sinusoid') do
                              classTags.write_longCM(hProjection, outContext)
                              classTags.write_falseNE(hProjection, outContext)
                           end
                        end
                     when 'spaceOblique'
                        @xml.tag!('mapproj') do
                           projectionName = 'Space Oblique Mercator'
                           classTags.write_name(projectionName)
                           @xml.tag!('spaceobq') do
                              classTags.write_landsat(hProjection, outContext)
                              classTags.write_landsatPath(hProjection, outContext)
                              classTags.write_falseNE(hProjection, outContext)
                           end
                        end
                     when 'stereographic'
                        @xml.tag!('mapproj') do
                           projectionName = 'Stereographic'
                           classTags.write_name(projectionName)
                           @xml.tag!('stereo') do
                              classTags.write_longPC(hProjection, outContext)
                              classTags.write_latPC(hProjection, outContext)
                              classTags.write_falseNE(hProjection, outContext)
                           end
                        end
                     when 'transverseMercator'
                        @xml.tag!('mapproj') do
                           projectionName = 'Transverse Mercator'
                           classTags.write_name(projectionName)
                           @xml.tag!('transmer') do
                              classTags.write_scaleFactorCM(hProjection, outContext)
                              classTags.write_longCM(hProjection, outContext)
                              classTags.write_latPO(hProjection, outContext)
                              classTags.write_falseNE(hProjection, outContext)
                           end
                        end
                     when 'grinten'
                        @xml.tag!('mapproj') do
                           projectionName = 'Van der Grinten'
                           classTags.write_name(projectionName)
                           @xml.tag!('vdgrin') do
                              classTags.write_longCM(hProjection, outContext)
                              classTags.write_falseNE(hProjection, outContext)
                           end
                        end
                     when 'parameters'
                        @xml.tag!('mapproj') do
                           projectionName = 'Map Projection Parameters'
                           classTags.write_name(projectionName)
                           @xml.tag!('mapprojp') do
                              classTags.write_allParams(hProjection, outContext)
                           end
                        end
                  end

               end # writeXML
            end # PlanarMap

         end
      end
   end
end
