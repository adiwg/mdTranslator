# ISO <<Class>> DerivedUnit
# writer output in XML

# History:
# 	Stan Smith 2015-08-27 copied from 19110 writer

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class DerivedUnit

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hDerived)

                        # create and identity for the unit
                        @responseObj[:writerMissingIdCount] = @responseObj[:writerMissingIdCount].succ
                        unitID = 'unit' + @responseObj[:writerMissingIdCount]
                        @xml.tag!('gml:DerivedUnit', {'gml:id' => unitID}) do
                            @xml.tag!('gml:identifier', {'codeSpace' => hDerived[:codeSpace]}, hDerived[:identifier])
                            @xml.tag!('gml:name', hDerived[:name])
                            @xml.tag!('gml:remarks', hDerived[:remarks])
                            @xml.tag!('gml:catalogSymbol', hDerived[:catalogSymbol])
                            aTerms = hDerived[:derivationUnitTerm]
                            aTerms.each do |term|
                                @xml.tag!('gml:derivationUnitTerm', term)
                            end
                        end

                    end

                end

            end
        end
    end
end
