# ISO <<CodeLists>> gmd:CI_PresentationForm

# from http://mdtranslator.adiwg.org/api/codelists?format=xml
# History:
# 	Stan Smith 2013-11-20 original script
#   Stan Smith 2014-10-15 allow non-ISO codesNames to be rendered
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2014-12-15 replaced NOAA CT_CodelistCatalogue with mdTranslator CT_CodelistCatalogue

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class CI_PresentationFormCode
                    def initialize(xml)
                        @xml = xml
                    end

                    def writeXML(codeName)
                        case (codeName)
                            when 'documentDigital' then
                                codeID = '001'
                            when 'documentHardcopy' then
                                codeID = '002'
                            when 'imageDigital' then
                                codeID = '003'
                            when 'imageHardcopy' then
                                codeID = '004'
                            when 'mapDigital' then
                                codeID = '005'
                            when 'mapHardcopy' then
                                codeID = '006'
                            when 'modelDigital' then
                                codeID = '007'
                            when 'modelHardcopy' then
                                codeID = '008'
                            when 'profileDigital' then
                                codeID = '009'
                            when 'profileHardcopy' then
                                codeID = '010'
                            when 'tableDigital' then
                                codeID = '011'
                            when 'tableHardcopy' then
                                codeID = '012'
                            when 'videoDigital' then
                                codeID = '013'
                            when 'videoHardcopy' then
                                codeID = '014'
                            else
                                codeID = 'non-ISO codeName'
                        end

                        # write xml
                        @xml.tag!('gmd:CI_PresentationFormCode', {:codeList => 'http://mdtranslator.adiwg.org/api/codelists?format=xml#CI_PresentationFormCode',
                                                                  :codeListValue => "#{codeName}",
                                                                  :codeSpace => "#{codeID}"})
                    end

                end

            end
        end
    end
end






