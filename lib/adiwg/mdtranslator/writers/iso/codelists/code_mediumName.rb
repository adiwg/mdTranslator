# ISO <<CodeLists>> gmd:MD_MediumNameCode

# from http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml
# History:
# 	Stan Smith 2013-09-24 original script
#   Stan Smith 2014-10-15 allow non-ISO codesNames to be rendered

class MD_MediumNameCode

    def initialize(xml)
        @xml = xml
    end

    def writeXML(codeName)
        case (codeName)
            when 'cdRom' then
                codeID = '001'
            when 'dvd' then
                codeID = '002'
            when 'dvdRom' then
                codeID = '003'
            when '3halfInchFloppy' then
                codeID = '004'
            when '5quarterInchFloppy' then
                codeID = '005'
            when '7trackTape' then
                codeID = '006'
            when '9trackTape' then
                codeID = '007'
            when '3480Cartridge' then
                codeID = '008'
            when '3490Cartridge' then
                codeID = '009'
            when '3580Cartridge' then
                codeID = '010'
            when '4mmCartridgeTape' then
                codeID = '011'
            when '8mmCartridgeTape' then
                codeID = '012'
            when '1quarterInchCartridgeTape' then
                codeID = '013'
            when 'digitalLinearTape' then
                codeID = '014'
            when 'online' then
                codeID = '015'
            when 'satellite' then
                codeID = '016'
            when 'telephoneLink' then
                codeID = '017'
            when 'hardcopy' then
                codeID = '018'
            else
                codeID = 'non-ISO codeName'
        end

        # write xml
        @xml.tag!('gmd:MD_MediumNameCode', {:codeList => 'http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_MediumNameCode',
                                            :codeListValue => "#{codeName}",
                                            :codeSpace => "#{codeID}"})
    end

end