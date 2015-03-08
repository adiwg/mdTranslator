# ISO <<CodeLists>> gmd:DS_InitiativeTypeCode

# from http://mdtranslator.adiwg.org/api/codelists?format=xml
# History:
# 	Stan Smith 2014-05-21 original script
#   Stan Smith 2014-10-15 allow non-ISO codesNames to be rendered
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2014-12-15 replaced NOAA CT_CodelistCatalogue with mdTranslator CT_CodelistCatalogue

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class DS_InitiativeTypeCode
                    def initialize(xml)
                        @xml = xml
                    end

                    def writeXML(codeName)
                        case (codeName)
                            when 'campaign' then
                                codeID = '001'
                            when 'collection' then
                                codeID = '002'
                            when 'exercise' then
                                codeID = '003'
                            when 'experiment' then
                                codeID = '004'
                            when 'investigation' then
                                codeID = '005'
                            else
                                codeID = 'non-ISO codeName'
                        end

                        # write xml
                        @xml.tag!('gmd:DS_InitiativeTypeCode', {:codeList => 'http://mdtranslator.adiwg.org/api/codelists?format=xml#DS_InitiativeTypeCode',
                                                                :codeListValue => "#{codeName}",
                                                                :codeSpace => "#{codeID}"})
                    end

                end

            end
        end
    end
end
