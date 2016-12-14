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

                        @xml.tag!('gmd:MD_ScopeDescription') do

                            type = hScopeDesc[:type]
                            tag = nil

                            # scope description - attributes
                            # scope description - features
                            # scope description - feature instances (not supported)
                            # scope description - attribute instances (not supported)
                            # scope description - dataset
                            # scope description - other
                            case type
                                when 'attribute'
                                    tag = 'gmd:attributes'
                                when 'feature'
                                    tag = 'gmd:features'
                                when 'dataset'
                                    tag = 'gmd:dataset'
                                when 'other'
                                    tag = 'gmd:other'
                            end

                            unless tag.nil?
                                s = hScopeDesc[:description]
                                unless s.nil?
                                    @xml.tag!(tag, s)
                                end
                            end

                        end # gmd:MD_ScopeDescription tag
                    end # writeXML
                end # MD_ScopeDescription class

            end
        end
    end
end
