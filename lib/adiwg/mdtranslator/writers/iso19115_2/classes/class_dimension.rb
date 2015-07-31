# ISO <<Class>> MD_Dimension
# writer output in XML

# History:
# 	Stan Smith 2015-07-30 original script.

require_relative 'class_codelist'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class MD_Dimension

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hDim)
                        # classes used
                        codelistClass = MD_Codelist.new(@xml, @responseObj)

                        @xml.tag!('gmd:MD_Dimension') do

                            # dimension information - dimension type code - required
                            s = hDim[:dimensionType]
                            if !s.nil?
                                @xml.tag!('gmd:dimensionName') do
                                    codelistClass.writeXML('iso_dimensionNameType',s)
                                end
                            end

                            # dimension information - dimension size - required
                            s = hDim[:dimensionSize]
                            if !s.nil?
                                @xml.tag!('gmd:dimensionSize') do
                                    @xml.tag!('gco:Integer',s)
                                end
                            end

                            # dimension information - dimension resolution
                            res = hDim[:resolution]
                            resUnit = hDim[:resolutionUnits]
                            if !res.nil?
                                @xml.tag!('gmd:resolution') do
                                    @xml.tag!('gco:Measure', {'uom'=>resUnit}, res)
                                end
                            end

                        end

                    end

                end

            end
        end
    end
end
