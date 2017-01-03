# ISO <<Class>> MD_GridSpatialRepresentation
# 19115-2 writer output in XML

# History:
# 	Stan Smith 2016-12-08 original script.

require_relative 'class_dimension'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class Grid

                    def initialize(xml, hResponseObj)
                        @xml = xml
                        @hResponseObj = hResponseObj
                    end

                    def writeXML(hGrid)

                        # classes used
                        codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                        dimClass = MD_Dimension.new(@xml, @hResponseObj)


                        # grid - number of dimensions (required)
                        s = hGrid[:numberOfDimensions]
                        unless s.nil?
                            @xml.tag!('gmd:numberOfDimensions') do
                                @xml.tag!('gco:Integer', s.to_s)
                            end
                        end
                        if s.nil?
                            @xml.tag!('gmd:numberOfDimensions', {'gco:nilReason'=>'missing'})
                        end

                        # grid - axis dimension properties [{MD_Dimension}]
                        aDims = hGrid[:dimension]
                        aDims.each do |hDimension|
                            @xml.tag!('gmd:axisDimensionProperties') do
                                dimClass.writeXML(hDimension)
                            end
                        end
                        if aDims.empty? && @hResponseObj[:writerShowTags]
                            @xml.tag!('gmd:axisDimensionProperties')
                        end

                        # grid - cell geometry (required)
                        s = hGrid[:cellGeometry]
                        unless s.nil?
                            @xml.tag!('gmd:cellGeometry') do
                                codelistClass.writeXML('gmd', 'iso_cellGeometry', s)
                            end
                        end
                        if s.nil?
                            @xml.tag!('gmd:cellGeometry', {'gco:nilReason'=>'missing'})
                        end

                        # grid - transformation parameters availability (required)
                        s = hGrid[:transformParamsAvailability]
                        @xml.tag!('gmd:transformationParameterAvailability') do
                            @xml.tag!('gco:Boolean', s)
                        end

                    end # writeXML
                end # Grid class

            end
        end
    end
end
