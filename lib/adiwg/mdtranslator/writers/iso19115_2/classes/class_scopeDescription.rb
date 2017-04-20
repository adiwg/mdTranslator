# ISO <<Class>> MD_ScopeDimension
# 19115-2 writer output in XML

# History:
#   Stan Smith 2016-12-12 refactored for mdTranslator/mdJson 2.0

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class MD_ScopeDescription

                    def initialize(xml, hResponseObj)
                        @xml = xml
                        @hResponseObj = hResponseObj
                    end

                    def writeXML(hScopeDesc)

                        # scope description - dataset
                        sData = hScopeDesc[:dataset]
                        unless sData.nil?
                            @xml.tag!('gmd:levelDescription') do
                                @xml.tag!('gmd:MD_ScopeDescription') do
                                    @xml.tag!('gmd:dataset') do
                                        @xml.tag!('gco:CharacterString', sData)
                                    end
                                end
                            end
                        end

                        # scope description - other
                        sOther = hScopeDesc[:other]
                        unless sOther.nil?
                            @xml.tag!('gmd:levelDescription') do
                                @xml.tag!('gmd:MD_ScopeDescription') do
                                    @xml.tag!('gmd:other') do
                                        @xml.tag!('gco:CharacterString', sOther)
                                    end
                                end
                            end
                        end

                        # scope description - feature instances (not supported in ISO 19115-2)
                        # scope description - attribute instances (not supported  in ISO 19115-2)

                    end # writeXML
                end # MD_ScopeDescription class

            end
        end
    end
end
