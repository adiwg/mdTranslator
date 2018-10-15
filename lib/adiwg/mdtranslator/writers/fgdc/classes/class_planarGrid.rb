# FGDC <<Class>> PlanarReference
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-10-09 refactor mdJson projection object
#  Stan Smith 2018-03-21 original script

require_relative 'class_mapProjectionTags'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class PlanarGrid

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hProjection, inContext = nil)

                  # classes used
                  classTags = MapProjectionTags.new(@xml, @hResponseObj)

                  outContext = 'grid system'
                  outContext = inContext + ' ' + outContext unless inContext.nil?

                  # planar 4.1.2.2 (gridsys) - grid coordinate system
                  # <- hProjection.gridSystemIdentifier.identifier = oneOf ...
                  hGridId = hProjection[:gridSystemIdentifier]
                  gridSystem = hGridId[:identifier]
                  gridName = nil
                  if hGridId.key?(:name)
                     gridName = hGridId[:name]
                  end
                  case gridSystem
                     when 'utm'
                        @xml.tag!('gridsys') do
                           gridName = 'Universal Transverse Mercator' if gridName.nil?
                           classTags.write_gridName(gridName)
                           @xml.tag!('utm') do
                              classTags.write_utmZone(hProjection, outContext)
                              @xml.tag!('transmer') do
                                 classTags.write_scaleFactorCM(hProjection, outContext)
                                 classTags.write_longCM(hProjection, outContext)
                                 classTags.write_latPO(hProjection, outContext)
                                 classTags.write_falseNE(hProjection, outContext)
                              end
                           end
                        end
                     when 'ups'
                        @xml.tag!('gridsys') do
                           gridName = 'Universal Polar Stereographic' if gridName.nil?
                           classTags.write_gridName(gridName)
                           @xml.tag!('ups') do
                              classTags.write_upsZone(hProjection, outContext)
                              @xml.tag!('polarst') do
                                 classTags.write_straightFromPole(hProjection, outContext)
                                 if hProjection[:standardParallel1] || hProjection[:standardParallel2]
                                    classTags.write_standParallel(hProjection, outContext)
                                 elsif hProjection[:scaleFactorAtProjectionOrigin]
                                    classTags.write_scaleFactorPO(hProjection, outContext)
                                 end
                                 classTags.write_falseNE(hProjection, outContext)
                              end
                           end
                        end
                     when 'spcs'
                        @xml.tag!('gridsys') do
                           gridName = 'State Plane Coordinate System' if gridName.nil?
                           classTags.write_gridName(gridName)
                           @xml.tag!('spcs') do
                              classTags.write_spcsZone(hProjection, outContext)
                              if hProjection[:standardParallel1] || hProjection[:standardParallel2]
                                 @xml.tag!('lambertc') do
                                    classTags.write_standParallel(hProjection, outContext)
                                    classTags.write_longCM(hProjection, outContext)
                                    classTags.write_latPO(hProjection, outContext)
                                    classTags.write_falseNE(hProjection, outContext)
                                 end
                              elsif hProjection[:scaleFactorAtCenterLine]
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
                              elsif hProjection[:scaleFactorAtCentralMeridian]
                                 @xml.tag!('transmer') do
                                    classTags.write_scaleFactorCM(hProjection, outContext)
                                    classTags.write_longCM(hProjection, outContext)
                                    classTags.write_latPO(hProjection, outContext)
                                    classTags.write_falseNE(hProjection, outContext)
                                 end
                              else
                                 @xml.tag!('polycon') do
                                    classTags.write_longCM(hProjection, outContext)
                                    classTags.write_latPO(hProjection, outContext)
                                    classTags.write_falseNE(hProjection, outContext)
                                 end
                              end
                           end
                        end
                     when 'arcsys'
                        @xml.tag!('gridsys') do
                           gridName = 'Equal Arc-second Coordinate System' if gridName.nil?
                           classTags.write_gridName(gridName)
                           @xml.tag!('arcsys') do
                              classTags.write_arcZone(hProjection, outContext)
                              if hProjection[:standardParallel1] || hProjection[:standardParallel2]
                                 @xml.tag!('equirect') do
                                    classTags.write_standParallel(hProjection, outContext)
                                    classTags.write_longCM(hProjection, outContext)
                                    classTags.write_falseNE(hProjection, outContext)
                                 end
                              elsif hProjection[:latitudeOfProjectionOrigin]
                                 @xml.tag!('azimequi') do
                                    classTags.write_longCM(hProjection, outContext)
                                    classTags.write_latPO(hProjection, outContext)
                                    classTags.write_falseNE(hProjection, outContext)
                                 end
                              end
                           end
                        end
                  end

               end # writeXML
            end # PlanarGrid

         end
      end
   end
end
