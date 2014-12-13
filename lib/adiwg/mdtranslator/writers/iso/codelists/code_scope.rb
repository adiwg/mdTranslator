# ISO <<CodeLists>> gmd:MD_ScopeCode

# from http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml
# History:
# 	Stan Smith 2013-08-09 original script
#   Stan Smith 2014-10-15 allow non-ISO codesNames to be rendered

class MD_ScopeCode
    def initialize(xml)
        @xml = xml
    end

    def writeXML(codeName)
        case (codeName)
            when 'attribute' then
                codeID = '001'
            when 'attributeType' then
                codeID = '002'
            when 'collectionHardware' then
                codeID = '003'
            when 'collectionSession' then
                codeID = '004'
            when 'dataset' then
                codeID = '005'
            when 'series' then
                codeID = '006'
            when 'nonGeographicDataset' then
                codeID = '007'
            when 'dimensionGroup' then
                codeID = '008'
            when 'feature' then
                codeID = '009'
            when 'featureType' then
                codeID = '010'
            when 'propertyType' then
                codeID = '011'
            when 'fieldSession' then
                codeID = '012'
            when 'software' then
                codeID = '013'
            when 'service' then
                codeID = '014'
            when 'model' then
                codeID = '015'
            when 'tile' then
                codeID = '016'
            else
                codeID = 'non-ISO codeName'
        end

        # write xml
        @xml.tag!('gmd:MD_ScopeCode', {:codeList => 'http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_ScopeCode',
                                       :codeListValue => "#{codeName}",
                                       :codeSpace => "#{codeID}"})
    end

end





