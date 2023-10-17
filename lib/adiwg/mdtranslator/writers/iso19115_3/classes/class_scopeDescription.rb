# ISO <<Class>> MD_ScopeDimension
# 19115-3 writer output in XML

# History:
#  Stan Smith 2019-03-16 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class MD_ScopeDescription

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hScopeDesc)

                  # these scope description types not implemented -----------------------------
                  # featureInstances (not supported in mdJson)
                  # attributeInstances (not supported in mdJson)

                  # scope description - dataset
                  unless hScopeDesc[:dataset].nil?
                     @xml.tag!('mcc:levelDescription') do
                        @xml.tag!('mcc:MD_ScopeDescription') do
                           @xml.tag!('mcc:dataset') do
                              @xml.tag!('gco:CharacterString', hScopeDesc[:dataset])
                           end
                        end
                     end
                  end

                  # scope description - attributes
                  unless hScopeDesc[:attributes].nil?
                     @xml.tag!('mcc:levelDescription') do
                        @xml.tag!('mcc:MD_ScopeDescription') do
                           @xml.tag!('mcc:attributes') do
                              @xml.tag!('gco:CharacterString', hScopeDesc[:attributes])
                           end
                        end
                     end
                  end

                  # scope description - features
                  unless hScopeDesc[:features].nil?
                     @xml.tag!('mcc:levelDescription') do
                        @xml.tag!('mcc:MD_ScopeDescription') do
                           @xml.tag!('mcc:features') do
                              @xml.tag!('gco:CharacterString', hScopeDesc[:features])
                           end
                        end
                     end
                  end

                  # scope description - other
                  unless hScopeDesc[:other].nil?
                     @xml.tag!('mcc:levelDescription') do
                        @xml.tag!('mcc:MD_ScopeDescription') do
                           @xml.tag!('mcc:other') do
                              @xml.tag!('gco:CharacterString', hScopeDesc[:other])
                           end
                        end
                     end
                  end

               end # writeXML
            end # MD_ScopeDescription class

         end
      end
   end
end
