# ISO <<CodeLists>> gmd:MD_SpatialRepresentationTypeCode

# from http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml
# History:
# 	Stan Smith 2013-10-21 original script
#   Stan Smith 2014-10-15 allow non-ISO codesNames to be rendered

class MD_SpatialRepresentationTypeCode
    def initialize(xml)
        @xml = xml
    end

    def writeXML(codeName)
        case (codeName)
            when 'vector' then
                codeID = '001'
            when 'grid' then
                codeID = '002'
            when 'textTable' then
                codeID = '003'
            when 'tin' then
                codeID = '004'
            when 'stereoModel' then
                codeID = '005'
            when 'video' then
                codeID = '006'
            else
                codeID = 'non-ISO codeName'
        end

        # write xml
        @xml.tag!('gmd:MD_SpatialRepresentationTypeCode', {:codeList => 'http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_SpatialRepresentationTypeCode',
                                                           :codeListValue => "#{codeName}",
                                                           :codeSpace => "#{codeID}"})
    end

end





