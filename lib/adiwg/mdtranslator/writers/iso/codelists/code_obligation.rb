# ISO <<CodeLists>> gmd:MD_ObligationCode
# enumeration

# from http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml

# History:
# 	Stan Smith 2013-10-21 original script

class MD_ObligationCode
    def initialize(xml)
        @xml = xml
    end

    def writeXML(codeName)
        case (codeName)
            when 'mandatory',
                'optional',
                'conditional'
            else
                codeName = 'INVALID OBLIGATION'
        end

        # write xml
        @xml.tag!('gmd:MD_ObligationCode', codeName)
    end

end





