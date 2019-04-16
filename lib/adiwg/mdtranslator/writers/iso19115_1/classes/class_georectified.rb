# ISO <<Class>> MD_Georectified
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-04-16 original script.

require_relative '../iso19115_1_writer'
require_relative 'class_grid'
require_relative 'class_point'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class MD_Georectified

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_1
               end

               def writeXML(hGeoRec, inContext = nil)

                  # classes used
                  gridClass = Grid.new(@xml, @hResponseObj)
                  pointClass = Point.new(@xml, @hResponseObj)

                  outContext = 'georectified representation'
                  outContext = inContext + ' georectified representation' unless inContext.nil?

                  @xml.tag!('msr:MD_Georectified') do

                     # georectified - add grid info
                     hGrid = hGeoRec[:gridRepresentation]
                     gridClass.writeXML(hGrid, outContext)

                     # georectified - transformation parameter availability {Boolean} (required)
                     # not included in mdJson 2.0
                     @xml.tag!('msr:transformationParameterAvailability') do
                        @xml.tag!('gco:Boolean', 'false')
                     end

                     # georectified - checkpoint availability
                     @xml.tag!('msr:checkPointAvailability') do
                        @xml.tag!('gco:Boolean', hGeoRec[:checkPointAvailable])
                     end

                     # georectified - checkpoint description
                     unless hGeoRec[:checkPointDescription].nil?
                        @xml.tag!('msr:checkPointDescription') do
                           @xml.tag!('gco:CharacterString', hGeoRec[:checkPointDescription])
                        end
                     end
                     if hGeoRec[:checkPointDescription].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('msr:checkPointDescription')
                     end

                     # georectified - corner points (required)
                     # note: 2 - 4 points are required, but XSD only allows 1
                     # ... coordinates are flattened into one multi-dimensional point
                     aCoords = hGeoRec[:cornerPoints]
                     unless aCoords.empty?
                        aCoords = aCoords.flatten
                        hPoint = {}
                        hPoint[:type] = 'Point'
                        hPoint[:coordinates] = aCoords
                        @xml.tag!('msr:cornerPoints') do
                           pointClass.writeXML(hPoint, {}, nil)
                        end
                     end
                     if aCoords.empty?
                        @NameSpace.issueWarning(170, 'msr:cornerPoints', 'spatial representation')
                     end

                     # georectified - center point
                     aCoords = hGeoRec[:centerPoint]
                     unless aCoords.empty?
                        hPoint = {}
                        hPoint[:type] = 'Point'
                        hPoint[:coordinates] = aCoords
                        @xml.tag!('msr:centerPoint') do
                           pointClass.writeXML(hPoint, {}, nil)
                        end
                     end
                     if aCoords.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('msr:centerPoint')
                     end

                     # georectified - point in pixel (required)
                     if hGeoRec[:pointInPixel].nil?
                        @NameSpace.issueWarning(171, 'msr:pointInPixel', 'spatial representation')
                     else
                        @xml.tag!('msr:pointInPixel') do
                           @xml.tag!('msr:MD_PixelOrientationCode', hGeoRec[:pointInPixel])
                        end
                     end

                     # georectified - transformation dimension description
                     unless hGeoRec[:transformationDimensionDescription].nil?
                        @xml.tag!('msr:transformationDimensionDescription') do
                           @xml.tag!('gco:CharacterString', hGeoRec[:transformationDimensionDescription])
                        end
                     end
                     if hGeoRec[:transformationDimensionDescription].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('msr:transformationDimensionDescription')
                     end

                     # georectified - transformation dimension mapping
                     unless hGeoRec[:transformationDimensionMapping].nil?
                        @xml.tag!('msr:transformationDimensionMapping') do
                           @xml.tag!('gco:CharacterString', hGeoRec[:transformationDimensionMapping])
                        end
                     end
                     if hGeoRec[:transformationDimensionMapping].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('msr:transformationDimensionMapping')
                     end

                  end # msr:MD_Georectified tag
               end # writeXML
            end # MD_Georectified class

         end
      end
   end
end
