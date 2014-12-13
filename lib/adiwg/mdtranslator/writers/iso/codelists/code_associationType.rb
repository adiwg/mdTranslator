# ISO <<CodeLists>> gmd:MD_ClassificationCode

# from http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml
# History:
# 	Stan Smith 2013-10-21 original script
#   Stan Smith 2014-10-15 allow non-ISO codesNames to be rendered

class DS_AssociationTypeCode
    def initialize(xml)
        @xml = xml
    end

    def writeXML(codeName)
        case (codeName)
            when 'crossReference' then
                codeID = '001'
            when 'largerWorkCitation' then
                codeID = '002'
            when 'partOfSeamlessDatabase' then
                codeID = '003'
            when 'source' then
                codeID = '004'
            when 'stereoMate' then
                codeID = '005'
            else
                codeID = 'non-ISO codeName'
        end

        # write xml
        @xml.tag!('gmd:DS_AssociationTypeCode', {:codeList => 'http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#DS_AssociationTypeCode',
                                                 :codeListValue => "#{codeName}",
                                                 :codeSpace => "#{codeID}"})
    end

end





