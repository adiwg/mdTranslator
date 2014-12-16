# ISO <<Class>> BaseUnit
# writer output in XML

# History:
# 	Stan Smith 2014-12-03 original script
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class BaseUnit

                    def initialize(xml)
                        @xml = xml
                    end

                    def writeXML(hBase)

                        # create and identity for the unit
                        $idCount = $idCount.succ
                        unitID = 'unit' + $idCount
                        @xml.tag!('gml:BaseUnit', {'gml:id' => unitID}) do
                            @xml.tag!('gml:identifier', {'codeSpace' => hBase[:codeSpace]}, hBase[:identifier])
                            @xml.tag!('gml:name', hBase[:name])
                            @xml.tag!('gml:catalogSymbol', hBase[:catalogSymbol])
                            @xml.tag!('gml:unitsSystem', {'xlink:href' => hBase[:unitsSystem]})
                        end

                    end

                end

            end
        end
    end
end
