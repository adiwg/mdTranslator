# ISO <<Class>> ConventionalUnit
# writer output in XML

# History:
# 	Stan Smith 2014-12-03 original script

class ConventionalUnit

    def initialize(xml)
        @xml = xml
    end

    def writeXML(hConv)

        # create and identity for the unit
        $idCount = $idCount.succ
        unitID = 'unit' + $idCount

        @xml.tag!('gml:ConventionalUnit', {'gml:id' => unitID}) do
            @xml.tag!('gml:identifier', {'codeSpace' => hConv[:codeSpace]}, hConv[:identifier])
            @xml.tag!('gml:name', hConv[:name])
            @xml.tag!('gml:catalogSymbol', hConv[:catalogSymbol])
            @xml.tag!('gml:conversionToPreferredUnit', {'uom' => hConv[:preferredUnit]}) do

                # two methods of conversion are available
                # factor and formula
                if !hConv[:factor].nil?
                    # factor:
                    #    y = factor * x
                    #    y is in preferred units
                    #    x is in provided units
                    #    factor is conversion to preferred units
                    @xml.tag!('gml:factor', hConv[:factor])
                else
                    # formula:
                    #    y = (a + bx) / (c + dx)
                    #    y is in preferred units
                    #    x is in provided units
                    #    a,b,c,d are constants to convert to preferred units
                    @xml.tag!('gml:formula') do
                        @xml.tag!('gml:a', hConv[:a])
                        @xml.tag!('gml:b', hConv[:b])
                        @xml.tag!('gml:c', hConv[:c])
                        @xml.tag!('gml:d', hConv[:d])
                    end
                end

            end
        end

    end

end
