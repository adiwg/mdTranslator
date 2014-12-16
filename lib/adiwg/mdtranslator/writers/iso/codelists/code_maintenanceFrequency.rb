# ISO <<CodeLists>> gmd:MD_MaintenanceFrequencyCode

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

                class MD_MaintenanceFrequencyCode
                    def initialize(xml)
                        @xml = xml
                    end

                    def writeXML(codeName)
                        case (codeName)
                            when 'continual' then
                                codeID = '001'
                            when 'daily' then
                                codeID = '002'
                            when 'weekly' then
                                codeID = '003'
                            when 'fortnightly' then
                                codeID = '004'
                            when 'monthly' then
                                codeID = '005'
                            when 'quarterly' then
                                codeID = '006'
                            when 'biannually' then
                                codeID = '007'
                            when 'annually' then
                                codeID = '008'
                            when 'asNeeded' then
                                codeID = '009'
                            when 'irregular' then
                                codeID = '010'
                            when 'notPlanned' then
                                codeID = '011'
                            when 'unknown' then
                                codeID = '012'
                            else
                                codeID = 'non-ISO codeName'
                        end

                        # write xml
                        @xml.tag!('gmd:MD_MaintenanceFrequencyCode', {:codeList => 'http://mdtranslator.herokuapp.com/api/codelists?format=xml#MD_MaintenanceFrequencyCode',
                                                                      :codeListValue => "#{codeName}",
                                                                      :codeSpace => "#{codeID}"})
                    end

                end

            end
        end
    end
end
