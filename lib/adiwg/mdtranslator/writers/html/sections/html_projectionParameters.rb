# HTML writer
# spatial reference system projection parameters

# History:
#  Stan Smith 2017-10-24 original script

require_relative 'html_identifier'
require_relative 'html_obliqueLinePoint'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_ProjectionParameters

               def initialize(html)
                  @html = html
               end

               def writeHtml(hProjection)

                  # classes used
                  identifierClass = Html_Identifier.new(@html)
                  linePointClass = Html_ObliqueLinePoint.new()

                  # projection parameters - projection name
                  unless hProjection[:projectionName].nil?
                     @html.em('Projection Name: ')
                     @html.text!(hProjection[:projectionName])
                     @html.br
                  end

                  # projection parameters - zone
                  unless hProjection[:zone].nil?
                     @html.em('Projection Zone: ')
                     @html.text!(hProjection[:zone])
                     @html.br
                  end

                  # projection parameters - Standard Parallel 1
                  unless hProjection[:standardParallel1].nil?
                     @html.em('Standard Parallel: ')
                     @html.text!(hProjection[:standardParallel1].to_s)
                     @html.br
                  end

                  # projection parameters - Standard Parallel 2
                  unless hProjection[:standardParallel2].nil?
                     @html.em('Standard Parallel: ')
                     @html.text!(hProjection[:standardParallel2].to_s)
                     @html.br
                  end

                  # projection parameters - Longitude of Central Meridian
                  unless hProjection[:longitudeOfCentralMeridian].nil?
                     @html.em('Longitude of Central Meridian: ')
                     @html.text!(hProjection[:longitudeOfCentralMeridian].to_s)
                     @html.br
                  end

                  # projection parameters - latitude of projection origin
                  unless hProjection[:latitudeOfProjectionOrigin].nil?
                     @html.em('Latitude of Projection Origin: ')
                     @html.text!(hProjection[:latitudeOfProjectionOrigin].to_s)
                     @html.br
                  end

                  # projection parameters - false easting
                  unless hProjection[:falseEasting].nil?
                     @html.em('False Easting: ')
                     @html.text!(hProjection[:falseEasting].to_s)
                     @html.br
                  end

                  # projection parameters - false northing
                  unless hProjection[:falseNorthing].nil?
                     @html.em('False Northing: ')
                     @html.text!(hProjection[:falseNorthing].to_s)
                     @html.br
                  end

                  # projection parameters - false easting-northing units
                  unless hProjection[:falseEastingNorthingUnits].nil?
                     @html.em('False Easting-Northing Units: ')
                     @html.text!(hProjection[:falseEastingNorthingUnits])
                     @html.br
                  end

                  # projection parameters - scale factor at equator
                  unless hProjection[:scaleFactorAtEquator].nil?
                     @html.em('Scale Factor at Equator: ')
                     @html.text!(hProjection[:scaleFactorAtEquator].to_s)
                     @html.br
                  end

                  # projection parameters - height of prospective point above surface
                  unless hProjection[:heightOfProspectivePointAboveSurface].nil?
                     @html.em('Height of Prospective Point Above Surface: ')
                     @html.text!(hProjection[:heightOfProspectivePointAboveSurface].to_s)
                     @html.br
                  end

                  # projection parameters - longitude of projection center
                  unless hProjection[:longitudeOfProjectionCenter].nil?
                     @html.em('Longitude of Projection Center: ')
                     @html.text!(hProjection[:longitudeOfProjectionCenter].to_s)
                     @html.br
                  end

                  # projection parameters - latitude of projection center
                  unless hProjection[:latitudeOfProjectionCenter].nil?
                     @html.em('Latitude of Projection Center: ')
                     @html.text!(hProjection[:latitudeOfProjectionCenter].to_s)
                     @html.br
                  end

                  # projection parameters - scale factor at center line
                  unless hProjection[:scaleFactorAtCenterLine].nil?
                     @html.em('Scale Factor at Center Line: ')
                     @html.text!(hProjection[:scaleFactorAtCenterLine].to_s)
                     @html.br
                  end

                  # projection parameters - scale factor at central meridian
                  unless hProjection[:scaleFactorAtCentralMeridian].nil?
                     @html.em('Scale Factor at Central Meridian: ')
                     @html.text!(hProjection[:scaleFactorAtCentralMeridian].to_s)
                     @html.br
                  end

                  # projection parameters - straight vertical longitude from pole
                  unless hProjection[:straightVerticalLongitudeFromPole].nil?
                     @html.em('Straight Vertical Longitude From Pole: ')
                     @html.text!(hProjection[:straightVerticalLongitudeFromPole].to_s)
                     @html.br
                  end

                  # projection parameters - scale factor at projection origin
                  unless hProjection[:scaleFactorAtProjectionOrigin].nil?
                     @html.em('Scale Factor at Projection Origin: ')
                     @html.text!(hProjection[:scaleFactorAtProjectionOrigin].to_s)
                     @html.br
                  end

                  # projection parameters - azimuthAngle
                  unless hProjection[:azimuthAngle].nil?
                     @html.em('Azimuth Angle: ')
                     @html.text!(hProjection[:azimuthAngle].to_s)
                     @html.br
                  end

                  # projection parameters - azimuth measure point longitude
                  unless hProjection[:azimuthMeasurePointLongitude].nil?
                     @html.em('Azimuth Measure Point Longitude: ')
                     @html.text!(hProjection[:azimuthMeasurePointLongitude].to_s)
                     @html.br
                  end

                  # projection parameters - oblique line point
                  hProjection[:obliqueLinePoints].each do |hLinePoint|
                     linePoint = linePointClass.writeHtml(hLinePoint)
                     @html.em('Oblique Line Point: ' + linePoint)
                     @html.br
                  end

                  # projection parameters - landsat number
                  unless hProjection[:landsatNumber].nil?
                     @html.em('Landsat Number: ')
                     @html.text!(hProjection[:landsatNumber].to_s)
                     @html.br
                  end

                  # projection parameters - landsat path
                  unless hProjection[:landsatPath].nil?
                     @html.em('Landsat Path: ')
                     @html.text!(hProjection[:landsatPath].to_s)
                     @html.br
                  end

                  # projection parameters - local planar description
                  unless hProjection[:localPlanarDescription].nil?
                     @html.em('Local Planar Description: ')
                     @html.section(:class => 'block') do
                        @html.text!(hProjection[:localPlanarDescription])
                     end
                  end

                  # projection parameters - local planar georeference
                  unless hProjection[:localPlanarGeoreference].nil?
                     @html.em('Local Planar Georeference: ')
                     @html.section(:class => 'block') do
                        @html.text!(hProjection[:localPlanarGeoreference])
                     end
                  end

                  # projection parameters - other projection description
                  unless hProjection[:otherProjectionDescription].nil?
                     @html.em('Other Projection Description: ')
                     @html.section(:class => 'block') do
                        @html.text!(hProjection[:otherProjectionDescription])
                     end
                  end

                  # projection parameters - other grid description
                  unless hProjection[:otherGridDescription].nil?
                     @html.em('Other Grid Description: ')
                     @html.section(:class => 'block') do
                        @html.text!(hProjection[:otherGridDescription])
                     end
                  end

                  # projection parameters - projection identifier
                  unless hProjection[:projectionIdentifier].empty?
                     @html.details do
                        @html.summary('Projection Identifier', {'id' => 'projection-identifier', 'class' => 'h5'})
                        @html.section(:class => 'block') do
                           identifierClass.writeHtml(hProjection[:projectionIdentifier])
                        end
                     end
                  end

               end # writeHtml
            end # Html_ProjectionParameters

         end
      end
   end
end
