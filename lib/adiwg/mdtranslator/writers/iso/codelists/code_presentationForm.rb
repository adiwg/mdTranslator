# ISO <<CodeLists>> gmd:CI_PresentationForm

# from http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml
# History:
# 	Stan Smith 2013-11-20 original script
#   Stan Smith 2014-10-15 allow non-ISO codesNames to be rendered

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
        @xml.tag!('gmd:CI_PresentationFormCode', {:codeList => 'http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#CI_PresentationFormCode',
                                                  :codeListValue => "#{codeName}",
                                                  :codeSpace => "#{codeID}"})
    end

end





