# ISO <<Class>> Measure
# 19115-2 writer output in XML

# History:
#   Stan Smith 2016-11-22 original script.

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class Measure

                    def initialize(xml, hResponseObj)
                        @xml = xml
                        @hResponseObj = hResponseObj
                    end

                    def writeXML(hResolution)

                        # measure
                        type = hResolution[:type]
                        value = hResolution[:value]
                        uom = hResolution[:unitOfMeasure]

                        if type == 'measure'
                            @xml.tag!('gco:Measure', {'uom'=>uom}, value)
                        end
                        if type == 'distance'
                            @xml.tag!('gco:Distance', {'uom'=>uom}, value)
                        end
                        if type == 'length'
                            @xml.tag!('gco:Length', {'uom'=>uom}, value)
                        end
                        if type == 'angle'
                            @xml.tag!('gco:Angle', {'uom'=>uom}, value)
                        end
                        if type == 'scale'
                            @xml.tag!('gco:Scale', {'uom'=>uom}, value)
                        end

                    end # write XML
                end # CI_Telephone class

            end
        end
    end
end
