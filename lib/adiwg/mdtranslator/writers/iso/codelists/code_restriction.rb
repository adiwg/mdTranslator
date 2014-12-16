# ISO <<CodeLists>> gmd:MD_RestrictionCode

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

                class MD_RestrictionCode
                    def initialize(xml)
                        @xml = xml
                    end

                    def writeXML(codeName)
                        case (codeName)
                            when 'copyright' then
                                codeID = '001'
                            when 'patent' then
                                codeID = '002'
                            when 'patentPending' then
                                codeID = '003'
                            when 'trademark' then
                                codeID = '004'
                            when 'license' then
                                codeID = '005'
                            when 'intellectualPropertyRights' then
                                codeID = '006'
                            when 'restricted' then
                                codeID = '007'
                            when 'otherRestrictions' then
                                codeID = '008'
                            else
                                codeID = 'non-ISO codeName'
                        end

                        # write xml
                        @xml.tag!('gmd:MD_RestrictionCode', {:codeList => 'http://mdtranslator.herokuapp.com/api/codelists?format=xml#MD_RestrictionCode',
                                                             :codeListValue => "#{codeName}",
                                                             :codeSpace => "#{codeID}"})
                    end

                end

            end
        end
    end
end
