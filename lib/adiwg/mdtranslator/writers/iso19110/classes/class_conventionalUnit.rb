# ISO <<Class>> ConventionalUnit
# writer output in XML

# History:
# 	Stan Smith 2014-12-03 original script
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19110

                class ConventionalUnit

                    def initialize(xml, responseObj)
                        @xml = xml
                        @hResponseObj = responseObj
                    end

                    def writeXML(hConv)

                        # create and identity for the unit
                        @hResponseObj[:writerMissingIdCount] = @hResponseObj[:writerMissingIdCount].succ
                        unitID = 'unit' + @hResponseObj[:writerMissingIdCount]

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

            end
        end
    end
end
