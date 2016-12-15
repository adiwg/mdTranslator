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
                            unless s.nil?
                                @xml.tag!('gmd:dimensionName') do
                                    codelistClass.writeXML('iso_dimensionNameType',s)
                                end
                            end
                            if s.nil?
                                @xml.tag!('gmd:dimensionName', {'gco:nilReason'=>'missing'})
                            end

                            # dimension information - dimension size (required)
                            s = hDim[:dimensionSize]
                            unless s.nil?
                                @xml.tag!('gmd:dimensionSize') do
                                    @xml.tag!('gco:Integer',s)
                                end
                            end
                            if s.nil?
                                @xml.tag!('gmd:dimensionSize', {'gco:nilReason'=>'missing'})
                            end

                            # dimension information - dimension resolution (required)
                            hMeasure = hDim[:resolution]
                            unless hMeasure.empty?
                                measureClass.writeXML(hMeasure)
                            end
                            if hMeasure.empty? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:resolution')
                            end

                        end # MD_Dimension tag
                    end # writeXML
                end # Md_Dimension class

            end
        end
    end
end
