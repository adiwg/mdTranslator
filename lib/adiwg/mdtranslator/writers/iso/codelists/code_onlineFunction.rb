# ISO <<CodeLists>> gmd:CI_OnLineFunctionCode

# from http://mdtranslator.herokuapp.com/api/codelists?format=xml
# History:
# 	Stan Smith 2013-09-26 original script
#   Stan Smith 2014-10-15 allow non-ISO codesNames to be rendered
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2014-12-15 replaced NOAA CT_CodelistCatalogue with mdTranslator CT_CodelistCatalogue

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class CI_OnLineFunctionCode

                    def initialize(xml)
                        @xml = xml
                    end

                    def writeXML(codeName)
                        case (codeName)
                            when 'download' then
                                codeID = '001'
                            when 'information' then
                                codeID = '002'
                            when 'offlineAccess' then
                                codeID = '003'
                            when 'order' then
                                codeID = '004'
                            when 'search' then
                                codeID = '005'
                            else
                                codeID = 'non-ISO codeName'
                        end

                        # write xml
                        @xml.tag!('gmd:CI_OnLineFunctionCode', {:codeList => 'http://mdtranslator.herokuapp.com/api/codelists?format=xml#CI_OnLineFunctionCode',
                                                                :codeListValue => "#{codeName}",
                                                                :codeSpace => "#{codeID}"})
                    end

                end

            end
        end
    end
end
