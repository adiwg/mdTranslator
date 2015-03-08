# ISO <<CodeLists>> gmd:MD_MediumFormatCode

# from http://mdtranslator.adiwg.org/api/codelists?format=xml
# History:
# 	Stan Smith 2013-09-24 original script
#   Stan Smith 2014-10-15 allow non-ISO codesNames to be rendered
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2014-12-15 replaced NOAA CT_CodelistCatalogue with mdTranslator CT_CodelistCatalogue

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class MD_MediumFormatCode

                    def initialize(xml)
                        @xml = xml
                    end

                    def writeXML(codeName)
                        case (codeName)
                            when 'cpio' then
                                codeID = '001'
                            when 'tar' then
                                codeID = '002'
                            when 'highSierra' then
                                codeID = '003'
                            when 'iso9660' then
                                codeID = '004'
                            when 'iso9660RockRidge' then
                                codeID = '005'
                            when 'iso9660AppleHFS' then
                                codeID = '006'
                            else
                                codeID = 'non-ISO codeName'
                        end

                        # write xml
                        @xml.tag!('gmd:MD_MediumFormatCode', {:codeList => 'http://mdtranslator.adiwg.org/api/codelists?format=xml#MD_MediumFormatCode',
                                                              :codeListValue => "#{codeName}",
                                                              :codeSpace => "#{codeID}"})
                    end

                end

            end
        end
    end
end
