# ISO <<Class>> MD_Georectified
# 19115-2 writer output in XML

# History:
# 	Stan Smith 2016-12-08 original script.

require_relative 'class_grid'
require_relative 'class_point'
require_relative 'class_codelist'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class MD_Georectified

                    def initialize(xml, hResponseObj)
                        @xml = xml
                        @hResponseObj = hResponseObj
                    end

                    def writeXML(hGrid)

                        # classes used
                        gridClass = Grid.new(@xml, @hResponseObj)
                        pointClass = Point.new(@xml, @hResponseObj)
                        codelistClass = MD_Codelist.new(@xml, @hResponseObj)

                        @xml.tag!('gmd:MD_Georectified') do

                            # georectified - add grid info
                            gridClass.writeXML(hGrid)

                            # georectified - checkpoint availability
                            s = hGrid[:checkPointAvailable]
                            @xml.tag!('gmd:checkPointAvailability') do
                                @xml.tag!('gco:Boolean', s)
                            end

                            # georectified - checkpoint description
                            s = hGrid[:checkPointDescription]
                            unless s.nil?
                                @xml.tag!('gmd:checkPointDescription') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            end
                            if s.nil? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:checkPointDescription')
                            end

                            # georectified - corner points (required)
                            # note: 2 - 4 points are required, but XSD only allows 1
                            # ... coordinates are flattened into one multi-dimensional point
                            aCoords = hGrid[:cornerPoints]
                            unless aCoords.empty?
                                aCoords = aCoords.flatten
                                hPoint = {}
                                hPoint[:type] = 'Point'
                                hPoint[:coordinates] = aCoords
                                @xml.tag!('gmd:cornerPoints') do
                                    pointClass.writeXML(hPoint, {}, nil)
                                end
                            end
                            if aCoords.empty?
                                @xml.tag!('gmd:cornerPoints', {'gco:nilReason'=>'missing'})
                            end

                            # georectified - center point
                            aCoords = hGrid[:cornerPoints]
                            unless aCoords.empty?
                                hPoint = {}
                                hPoint[:type] = 'Point'
                                hPoint[:coordinates] = aCoords
                                @xml.tag!('gmd:centerPoint') do
                                    pointClass.writeXML(hPoint, {}, nil)
                                end
                            end
                            if aCoords.empty? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:centerPoint')
                            end

                            # georectified - point in pixel (required)
                            s = hGrid[:pointInPixel]
                            if s.nil?
                                @xml.tag!('gmd:pointInPixel', {'gco:nilReason'=>'missing'})
                            else
                                @xml.tag!('gmd:pointInPixel') do
                                    codelistClass.writeXML('gmd', 'iso_pixelOrientationCode', s)
                                end
                            end

                            # georectified - transformation dimension description
                            s = hGrid[:transformationDimensionDescription]
                            unless s.nil?
                                @xml.tag!('gmd:transformationDimensionDescription') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            end
                            if s.nil? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:transformationDimensionDescription')
                            end

                            # georectified - transformation dimension mapping
                            s = hGrid[:transformationDimensionMapping]
                            unless s.nil?
                                @xml.tag!('gmd:transformationDimensionMapping') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            end
                            if s.nil? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:transformationDimensionMapping')
                            end

                        end # gmd:MD_Georectified tag
                    end # writeXML
                end # MD_Georectified class

            end
        end
    end
end
