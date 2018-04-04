# FGDC <<Class>> SpatialDomain
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-03-26 refactored error and warning messaging
#  Stan Smith 2018-02-05 fixed typo in variable name 'aBPoly'
#  Stan Smith 2017-11-25 original script

require_relative '../fgdc_writer'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class SpatialDomain

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(aExtents)

                  # spatial domain section is not required under biological extension rules

                  # look for geographic description - take first
                  # <- geographicExtent[:description]
                  geoDescription = ''
                  aExtents.each do |hExtent|
                     unless hExtent.empty?
                        hExtent[:geographicExtents].each do |hGeoExtent|
                           unless hGeoExtent.empty?
                              unless hGeoExtent[:description].nil?
                                 geoDescription = hGeoExtent[:description]
                                 break
                              end
                           end
                        end
                     end
                  end

                  # look for bounding box - take first
                  # <- geographicExtent[:boundingBox]
                  hBBox = {}
                  aExtents.each do |hExtent|
                     unless hExtent.empty?
                        hExtent[:geographicExtents].each do |hGeoExtent|
                           unless hGeoExtent.empty?
                              unless hGeoExtent[:boundingBox].empty?
                                 hBBox = hGeoExtent[:boundingBox]
                                 break
                              end
                           end
                        end
                     end
                  end

                  # look for bounding polygon
                  # <- geographicExtent[:geographicElements]
                  # polygon must be in a FeatureCollection with properties description of 'FGDC bounding polygon'
                  aBPoly = []
                  aExtents.each do |hExtent|
                     unless hExtent.empty?
                        hExtent[:geographicExtents].each do |hGeoExtent|
                           unless hGeoExtent.empty?
                              unless hGeoExtent[:geographicElements].empty?
                                 hGeoExtent[:geographicElements].each do |hGeoElement|
                                    if hGeoElement[:type] == 'FeatureCollection'
                                       hGeoElement[:features].each do |hFeature|
                                          if hFeature[:geometryObject][:type] == 'Polygon'
                                             unless hFeature[:properties].empty?
                                                if hFeature[:properties][:description] == 'FGDC bounding polygon'
                                                   aBPoly << hFeature[:geometryObject][:coordinates]
                                                end
                                             end
                                          end
                                       end
                                    end
                                 end
                              end
                           end
                        end
                     end
                  end

                  # spatial domain 1.5 (spdom)
                  unless geoDescription.empty? && hBBox.empty? && aBPoly.empty?
                     @xml.tag!('spdom') do

                        # spatial domain bio (descgeog) - geographic description (required)
                        unless geoDescription.empty?
                           @xml.tag!('descgeog', geoDescription)
                        end
                        if geoDescription.empty?
                           @NameSpace.issueWarning(370, 'descgeog')
                        end

                        # spatial domain 1.5.1 (bounding) - bounding box (required)
                        unless hBBox.empty?
                           @xml.tag!('bounding') do

                              # bounding box 1.5.1.1 (westbc) - west bounding coordinate
                              @xml.tag!('westbc', hBBox[:westLongitude])

                              # bounding box 1.5.1.2 (eastbc) - east bounding coordinate
                              @xml.tag!('eastbc', hBBox[:eastLongitude])

                              # bounding box 1.5.1.3 (northbc) - north bounding coordinate
                              @xml.tag!('northbc', hBBox[:northLatitude])

                              # bounding box 1.5.1.4 (southbc) - south bounding coordinate
                              @xml.tag!('southbc', hBBox[:southLatitude])

                              # altitude bounding bio extension
                              unless hBBox[:minimumAltitude].nil? && hBBox[:maximumAltitude].nil? && hBBox[:unitsOfAltitude].nil?
                                 @xml.tag!('boundalt') do

                                    # altitude bounding (altmin) - minimum altitude (required)
                                    unless hBBox[:minimumAltitude].nil?
                                       @xml.tag!('altmin', hBBox[:minimumAltitude])
                                    end
                                    if hBBox[:minimumAltitude].nil?
                                       @NameSpace.issueWarning(371, 'altmin')
                                    end

                                    # altitude bounding (altmax) - maximum altitude (required)
                                    unless hBBox[:maximumAltitude].nil?
                                       @xml.tag!('altmax', hBBox[:minimumAltitude])
                                    end
                                    if hBBox[:maximumAltitude].nil?
                                       @NameSpace.issueWarning(372, 'altmax')
                                    end

                                    # altitude bounding (altunit) - units of altitude
                                    unless hBBox[:unitsOfAltitude].nil?
                                       @xml.tag!('altunit', hBBox[:unitsOfAltitude])
                                    end
                                    if hBBox[:unitsOfAltitude].nil?  && @hResponseObj[:writerShowTags]
                                       @xml.tag!('altunit')
                                    end

                                 end
                              end
                              if hBBox[:minimumAltitude].nil? && hBBox[:maximumAltitude].nil? &&
                                 hBBox[:unitsOfAltitude].nil? && @hResponseObj[:writerShowTags]
                                 @xml.tag!('boundalt')
                              end
                           end
                        end
                        if hBBox.empty?
                           @NameSpace.issueWarning(373, nil)
                        end

                        # spatial domain 1.5.2 (dsgpoly) - bounding polygon [] (required)
                        unless aBPoly.empty?
                           @xml.tag!('dsgpoly') do
                              aBPoly.each do |aPoly|

                                 # outer polygon 1.5.2.1 (dsgpolyo) - (required)
                                 unless aPoly.empty?
                                    @xml.tag!('dsgpolyo') do
                                       aPoly[0].each do |aCoord|
                                          @xml.tag!('grngpoin') do
                                             @xml.tag!('grnglat', aCoord[0])
                                             @xml.tag!('grnglon', aCoord[1])
                                          end
                                       end
                                    end
                                 end

                                 # outer polygon 1.5.2.2 (dsgpolyx)
                                 aPoly.delete_at(0)
                                 unless aPoly.empty?
                                    aPoly.each do |aExclude|
                                       @xml.tag!('dsgpolyx') do
                                          aExclude.each do |aCoord|
                                             @xml.tag!('grngpoin') do
                                                @xml.tag!('grnglat', aCoord[0])
                                                @xml.tag!('grnglon', aCoord[1])
                                             end
                                          end
                                       end
                                    end
                                 end

                              end
                           end
                        end

                     end
                  end

               end # writeXML
            end # Status

         end
      end
   end
end
