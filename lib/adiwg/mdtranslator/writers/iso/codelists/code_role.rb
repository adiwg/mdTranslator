# ISO <<CodeLists>> gmd:CI_RoleCode

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

                class CI_RoleCode
                    def initialize(xml)
                        @xml = xml
                    end

                    def writeXML(codeName)

                        case (codeName)
                            when 'resourceProvider' then
                                codeID = '001'
                            when 'custodian' then
                                codeID = '002'
                            when 'owner' then
                                codeID = '003'
                            when 'user' then
                                codeID = '004'
                            when 'distributor' then
                                codeID = '005'
                            when 'originator' then
                                codeID = '006'
                            when 'pointOfContact' then
                                codeID = '007'
                            when 'principalInvestigator' then
                                codeID = '008'
                            when 'processor' then
                                codeID = '009'
                            when 'publisher' then
                                codeID = '010'
                            when 'author' then
                                codeID = '011'
                            else
                                codeID = 'non-ISO codeName'
                        end

                        # write xml
                        @xml.tag!('gmd:CI_RoleCode', {:codeList => 'http://mdtranslator.adiwg.org/api/codelists?format=xml#CI_RoleCode',
                                                      :codeListValue => "#{codeName}",
                                                      :codeSpace => "#{codeID}"})
                    end

                end

            end
        end
    end
end
