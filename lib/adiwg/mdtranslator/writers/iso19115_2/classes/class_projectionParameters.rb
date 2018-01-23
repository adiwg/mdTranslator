# ISO <<Class>> MD_ProjectionParameters
# writer
# 19115-2 output for ISO 19115-2 XML

# History:
# 	Stan Smith 2017-10-26 original script

require_relative 'class_obliqueLinePoint'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class MD_ProjectionParameters

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hProjection)

                  # classes used
                  linePointClass = MD_ObliqueLinePoint.new(@xml, @hResponseObj)

                  @xml.tag!('gmd:MD_ProjectionParameters') do

                     # projection parameters - zone {integer}
                     i = hProjection[:gridZone]
                     unless i.nil?
                        @xml.tag!('gmd:zone') do
                           @xml.tag!('gco:integer', i.to_s)
                        end
                     end
                     if i.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:zone')
                     end
                     # projection parameters - standard parallel {real}
                     r = hProjection[:standardParallel1]
                     unless r.nil?
                        @xml.tag!('gmd:standardParallel') do
                           @xml.tag!('gco:real', r.to_s)
                        end
                     end
                     if r.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:standardParallel')
                     end

                     # projection parameters - standard parallel {real}
                     r = hProjection[:standardParallel2]
                     unless r.nil?
                        @xml.tag!('gmd:standardParallel') do
                           @xml.tag!('gco:real', r.to_s)
                        end
                     end
                     if r.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:standardParallel')
                     end

                     # projection parameters - longitude of central meridian {real}
                     r = hProjection[:longitudeOfCentralMeridian]
                     unless r.nil?
                        @xml.tag!('gmd:longitudeOfCentralMeridian') do
                           @xml.tag!('gco:real', r.to_s)
                        end
                     end
                     if r.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:longitudeOfCentralMeridian')
                     end

                     # projection parameters - latitude of projection origin {real}
                     r = hProjection[:latitudeOfProjectionOrigin]
                     unless r.nil?
                        @xml.tag!('gmd:latitudeOfProjectionOrigin') do
                           @xml.tag!('gco:real', r.to_s)
                        end
                     end
                     if r.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:latitudeOfProjectionOrigin')
                     end

                     # projection parameters - false easting {real}
                     r = hProjection[:falseEasting]
                     unless r.nil?
                        @xml.tag!('gmd:falseEasting') do
                           @xml.tag!('gco:real', r.to_s)
                        end
                     end
                     if r.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:falseEasting')
                     end

                     # projection parameters - false northing {real}
                     r = hProjection[:falseNorthing]
                     unless r.nil?
                        @xml.tag!('gmd:falseNorthing') do
                           @xml.tag!('gco:real', r.to_s)
                        end
                     end
                     if r.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:falseNorthing')
                     end

                     # projection parameters - false northing units
                     s = hProjection[:falseEastingNorthingUnits]
                     unless s.nil?
                        @xml.tag!('gmd:falseEastingNorthingUnits') do
                           @xml.tag!('gco:unit', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:falseEastingNorthingUnits')
                     end

                     # projection parameters - scale factor at equator {real}
                     r = hProjection[:scaleFactorAtEquator]
                     unless r.nil?
                        @xml.tag!('gmd:scaleFactorAtEquator') do
                           @xml.tag!('gco:real', r.to_s)
                        end
                     end
                     if r.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:scaleFactorAtEquator')
                     end

                     # projection parameters - height of prospective point above surface {real}
                     r = hProjection[:heightOfProspectivePointAboveSurface]
                     unless r.nil?
                        @xml.tag!('gmd:heightOfProspectivePointAboveSurface') do
                           @xml.tag!('gco:real', r.to_s)
                        end
                     end
                     if r.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:heightOfProspectivePointAboveSurface')
                     end

                     # projection parameters - longitude of projection center {real}
                     r = hProjection[:longitudeOfProjectionCenter]
                     unless r.nil?
                        @xml.tag!('gmd:longitudeOfProjectionCenter') do
                           @xml.tag!('gco:real', r.to_s)
                        end
                     end
                     if r.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:longitudeOfProjectionCenter')
                     end

                     # projection parameters - scale factor at center line {real}
                     r = hProjection[:scaleFactorAtCenterLine]
                     unless r.nil?
                        @xml.tag!('gmd:scaleFactorAtCenterLine') do
                           @xml.tag!('gco:real', r.to_s)
                        end
                     end
                     if r.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:scaleFactorAtCenterLine')
                     end

                     # projection parameters - straight vertical longitude from pole {real}
                     r = hProjection[:straightVerticalLongitudeFromPole]
                     unless r.nil?
                        @xml.tag!('gmd:straightVerticalLongitudeFromPole') do
                           @xml.tag!('gco:real', r.to_s)
                        end
                     end
                     if r.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:straightVerticalLongitudeFromPole')
                     end

                     # projection parameters - scale factor at projection origin {real}
                     r = hProjection[:scaleFactorAtProjectionOrigin]
                     unless r.nil?
                        @xml.tag!('gmd:scaleFactorAtProjectionOrigin') do
                           @xml.tag!('gco:real', r.to_s)
                        end
                     end
                     if r.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:scaleFactorAtProjectionOrigin')
                     end

                     # projection parameters - oblique line azimuth parameter
                     r1 = hProjection[:azimuthAngle]
                     r2 = hProjection[:azimuthMeasurePointLongitude]
                     unless r1.nil? && r2.nil?
                        @xml.tag!('gmd:obliqueLineAzimuthParameter') do
                           @xml.tag!('gmd:MD_ObliqueLineAzimuth') do
                              unless r1.nil?
                                 @xml.tag!('gmd:azimuthAngle') do
                                    @xml.tag!('gco:real', r1.to_s)
                                 end
                              end
                              if r1.nil? && @hResponseObj[:writerShowTags]
                                 @xml.tag!('gmd:azimuthAngle')
                              end
                              unless r2.nil?
                                 @xml.tag!('gmd:azimuthMeasurePointLongitude') do
                                    @xml.tag!('gco:real', r2.to_s)
                                 end
                              end
                              if r2.nil? && @hResponseObj[:writerShowTags]
                                 @xml.tag!('gmd:azimuthMeasurePointLongitude')
                              end
                           end
                        end
                     end
                     if r1.nil? && r2.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:obliqueLineAzimuthParameter')
                     end

                     # projection parameters - oblique line point parameter
                     aLinePoints = hProjection[:obliqueLinePoints]
                     aLinePoints.each do |hLinePoint|
                        @xml.tag!('gmd:obliqueLinePointParameter') do
                           linePointClass.writeXML(hLinePoint)
                        end
                     end
                     if aLinePoints.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:obliqueLinePointParameter')
                     end

                  end # gmd:MD_ProjectionParameters
               end # writeXML
            end # MD_ProjectionParameters class

         end
      end
   end
end
