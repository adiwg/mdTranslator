# ISO <<CodeLists>> gmd:MD_SpatialRepresentationTypeCode

# from http://mdtranslator.herokuapp.com/api/codelists?format=xml
# History:
# 	Stan Smith 2013-10-21 original script
#   Stan Smith 2014-10-15 allow non-ISO codesNames to be rendered
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2014-12-15 replaced NOAA CT_CodelistCatalogue with mdTranslator CT_CodelistCatalogue

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class MD_SpatialRepresentationTypeCode
                    def initialize(xml)
                        @xml = xml
                    end

                    def writeXML(codeName)
                        case (codeName)
                            when 'vector' then
                                codeID = '001'
                            when 'grid' then
                                codeID = '002'
                            when 'textTable' then
                                codeID = '003'
                            when 'tin' then
                                codeID = '004'
                            when 'stereoModel' then
                                codeID = '005'
                            when 'video' then
                                codeID = '006'
                            else
                                codeID = 'non-ISO codeName'
                        end

                        # write xml
                        @xml.tag!('gmd:MD_SpatialRepresentationTypeCode', {:codeList => 'http://mdtranslator.herokuapp.com/api/codelists?format=xml#MD_SpatialRepresentationTypeCode',
                                                                           :codeListValue => "#{codeName}",
                                                                           :codeSpace => "#{codeID}"})
                    end

                end

            end
        end
    end
end
