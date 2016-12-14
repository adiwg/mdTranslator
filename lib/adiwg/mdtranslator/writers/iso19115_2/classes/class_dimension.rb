# ISO <<Class>> MD_Dimension
# 19115-2 writer output in XML

# History:
#   Stan Smith 2016-11-23 refactored for mdTranslator/mdJson 2.0
# 	Stan Smith 2015-07-30 original script.

require_relative 'class_codelist'
require_relative 'class_measure'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class MD_Dimension

                    def initialize(xml, hResponseObj)
                        @xml = xml
                        @hResponseObj = hResponseObj
                    end

                    def writeXML(hDim)

                        # classes used
                        codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                        measureClass = Measure.new(@xml, @hResponseObj)

                        @xml.tag!('gmd:MD_Dimension') do

                            # dimension information - dimension type code (required)
                            s = hDim[:dimensionType]
                            if s.nil?
                                @xml.tag!('gmd:dimensionName', {'gco:nilReason'=>'missing'})
                            else
                                @xml.tag!('gmd:dimensionName') do
                                    codelistClass.writeXML('iso_dimensionNameType',s)
                                end
                            end

                            # dimension information - dimension size (required)
                            s = hDim[:dimensionSize]
                            if s.nil?
                                @xml.tag!('gmd:dimensionSize', {'gco:nilReason'=>'missing'})
                            else
                                @xml.tag!('gmd:dimensionSize') do
                                    @xml.tag!('gco:Integer',s)
                                end
                            end

                            # dimension information - dimension resolution (required)
                            hMeasure = hDim[:resolution]
                            if hMeasure.empty?
                                @xml.tag!('gmd:resolution', {'gco:nilReason'=>'missing'})
                            else
                                @xml.tag!('gmd:resolution') do
                                    measureClass.writeXML(hMeasure)
                                end
                            end

                        end # MD_Dimension tag
                    end # writeXML
                end # Md_Dimension class

            end
        end
    end
end
