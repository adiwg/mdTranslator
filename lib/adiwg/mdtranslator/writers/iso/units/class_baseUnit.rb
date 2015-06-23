# ISO <<Class>> BaseUnit
# writer output in XML

# History:
# 	Stan Smith 2014-12-03 original script
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class BaseUnit

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hBase)

                        # create and identity for the unit
                        @responseObj[:missingIdCount] = @responseObj[:missingIdCount].succ
                        unitID = 'unit' + @responseObj[:missingIdCount]
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
