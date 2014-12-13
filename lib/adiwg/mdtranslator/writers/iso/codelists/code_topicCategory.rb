# ISO <<CodeLists>> gmd:MD_TopicCategoryCode
# Enumeration

# from http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml
# History:
# 	Stan Smith 2013-10-21 original script

class MD_TopicCategoryCode
    def initialize(xml)
        @xml = xml
    end

    def writeXML(codeName)
        case (codeName)
            when 'farming',
                'biota',
                'boundaries',
                'climatologyMeteorologyAtmosphere',
                'economy',
                'elevation',
                'environment',
                'geoscientificInformation',
                'health',
                'imageryBaseMapsEarthCover',
                'intelligenceMilitary',
                'inlandWaters',
                'location',
                'oceans',
                'planningCadastre',
                'society',
                'structure',
                'transportation',
                'utilitiesCommunication'
            else
                # topics not in the standard ISO list will not pass validation
                # the domain is validated by the XSD
                # this codelist cannot be extended
                return
        end

        # write xml
        @xml.tag!('gmd:MD_TopicCategoryCode', codeName)
    end

end





