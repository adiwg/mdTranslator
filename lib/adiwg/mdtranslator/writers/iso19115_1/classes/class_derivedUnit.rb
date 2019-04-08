# ISO <<Class>> DerivedUnit
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-04-08 copied from 19115_2 writer

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class DerivedUnit

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hDerived)

                  # create and identity for the unit
                  @hResponseObj[:writerMissingIdCount] = @hResponseObj[:writerMissingIdCount].succ
                  unitID = 'unit' + @hResponseObj[:writerMissingIdCount]
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
