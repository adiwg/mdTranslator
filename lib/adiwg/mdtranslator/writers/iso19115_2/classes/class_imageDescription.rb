# ISO <<Class>> MI_ImageDescription
# writer output in XML

# History:
# 	Stan Smith 2015-08-04 original script.

require_relative 'class_codelist'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class MI_ImageDescription

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hImage)

                        # classes used
                        codelistClass = MD_Codelist.new(@xml, @responseObj)

                        @xml.tag!('gmd:MI_ImageDescription') do

                            # image description - attribute description - required
                            s = hImage[:rasterDescription]
                            if s.nil?
                                @xml.tag!('gmd:attributeDescription', {'gco:nilReason' => 'missing'})
                            else
                                @xml.tag!('gmd:attributeDescription') do
                                    @xml.tag!('gco:RecordType', s)
                                end
                            end

                            # image description


                        end

                    end

                end

            end
        end
    end
end
