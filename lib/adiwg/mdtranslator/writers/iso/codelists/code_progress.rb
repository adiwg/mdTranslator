# ISO <<CodeLists>> gmd:MD_ProgressCode

# from http://mdtranslator.adiwg.org/api/codelists?format=xml
# History:
# 	Stan Smith 2013-08-26 original script
#   Stan Smith 2014-10-15 allow non-ISO codesNames to be rendered
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2014-12-15 replaced NOAA CT_CodelistCatalogue with mdTranslator CT_CodelistCatalogue

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class MD_ProgressCode
                    def initialize(xml)
                        @xml = xml
                    end

                    def writeXML(codeName)

                        case (codeName)
                            when 'completed' then
                                codeID = '001'
                            when 'historicalArchive' then
                                codeID = '002'
                            when 'obsolete' then
                                codeID = '003'
                            when 'onGoing' then
                                codeID = '004'
                            when 'planned' then
                                codeID = '005'
                            when 'required' then
                                codeID = '006'
                            when 'underDevelopment' then
                                codeID = '007'
                            else
                                codeID = 'non-ISO codeName'
                        end

                        # write xml
                        @xml.tag!('gmd:MD_ProgressCode', {:codeList => 'http://mdtranslator.adiwg.org/api/codelists?format=xml#CI_ProgressCode',
                                                          :codeListValue => "#{codeName}",
                                                          :codeSpace => "#{codeID}"})
                    end

                end

            end
        end
    end
end
