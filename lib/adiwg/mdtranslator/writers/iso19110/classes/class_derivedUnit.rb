# ISO <<Class>> DerivedUnit
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
