# ISO <<CodeLists>> gmd:CI_DateTypeCode

# from http://mdtranslator.adiwg.org/api/codelists?format=xml
# History:
# 	Stan Smith 2013-08-09 original script
#   Stan Smith 2014-10-15 allow non-ISO codesNames to be rendered
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2014-12-15 replaced NOAA CT_CodelistCatalogue with mdTranslator CT_CodelistCatalogue

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class CI_DateTypeCode

                    def initialize(xml)
                        @xml = xml
                    end

                    def writeXML(codeName)
                        case (codeName)
                            when 'creation' then
                                codeID = '001'
                            when 'publication' then
                                codeID = '002'
                            when 'revision' then
                                codeID = '003'
                            else
                                codeID = 'non-ISO codeName'
                        end

                        # write xml
                        @xml.tag!('gmd:CI_DateTypeCode', {:codeList => 'http://mdtranslator.adiwg.org/api/codelists?format=xml#CI_DateTypeCode',
                                                          :codeListValue => "#{codeName}",
                                                          :codeSpace => "#{codeID}"})
                    end

                end

            end
        end
    end
end
