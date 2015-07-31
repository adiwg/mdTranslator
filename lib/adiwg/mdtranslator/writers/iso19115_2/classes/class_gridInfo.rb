# ISO <<Class>> MD_GridSpatialRepresentation
# writer output in XML

# History:
# 	Stan Smith 2015-07-30 original script.

require_relative 'class_dimension'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class MD_GridInfo

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hGridInfo)

                        # classes used
                        codelistClass = MD_Codelist.new(@xml, @responseObj)
                        dimClass = MD_Dimension.new(@xml, @responseObj)

                        @xml.tag!('gmd:MD_GridSpatialRepresentation') do

                            # spatial grid information - number of dimensions - required
                            s = hGridInfo[:dimensions]
                            if !s.nil?
                                @xml.tag!('gmd:numberOfDimensions') do
                                    @xml.tag!('gco:Integer', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:numberOfDimensions')
                            end

                            # spatial grid information - axis dimension properties
                            aDims = hGridInfo[:dimensionInfo]
                            if !aDims.empty?
                                aDims.each do |hDimInfo|
                                    @xml.tag!('gmd:axisDimensionProperties') do
                                        dimClass.writeXML(hDimInfo)
                                    end
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:axisDimensionProperties')
                            end

                            # spatial grid information - cell geometry
                            s = hGridInfo[:dimensionGeometry]
                            if !s.nil?
                                @xml.tag!('gmd:cellGeometry') do
                                    codelistClass.writeXML('iso_cellGeometry', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:cellGeometry')
                            end

                            # spatial grid information - transformation parameters availability - required - default false
                            s = hGridInfo[:dimensionTransformParams]
                            @xml.tag!('gmd:transformationParameterAvailability') do
                                if s
                                    @xml.tag!('gco:Boolean', 'true')
                                else
                                    @xml.tag!('gco:Boolean', 'false')
                                end
                            end

                        end

                    end

                end

            end
        end
    end
end
