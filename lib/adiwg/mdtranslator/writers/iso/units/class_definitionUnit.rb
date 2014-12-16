# ISO <<Class>> UnitDefinition
# writer output in XML

# History:
# 	Stan Smith 2014-12-03 original script
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class UnitDefinition

                    def initialize(xml)
                        @xml = xml
                    end

                    def writeXML(unit)

                        # create and identity for the unit
                        $idCount = $idCount.succ
                        unitID = 'unit' + $idCount
                        @xml.tag!('gml:UnitDefinition', {'gml:id' => unitID}) do
                            @xml.tag!('gml:identifier', {'codeSpace' => ''}, unit)
                        end

                    end

                end

            end
        end
    end
end
