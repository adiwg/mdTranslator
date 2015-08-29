# ISO <<Class>> UnitDefinition
# writer output in XML

# History:
# 	Stan Smith 2015-08-27 copied from 19110 writer

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class UnitDefinition

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(unit)

                        # create an identity for the unit
                        @responseObj[:writerMissingIdCount] = @responseObj[:writerMissingIdCount].succ
                        unitID = 'unit' + @responseObj[:writerMissingIdCount]
                        @xml.tag!('gml:UnitDefinition', {'gml:id' => unitID}) do
                            @xml.tag!('gml:identifier', {'codeSpace' => ''}, unit)
                        end

                    end

                end

            end
        end
    end
end
