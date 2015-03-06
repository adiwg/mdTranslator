# ISO <<CodeLists>> gmd:MD_ObligationCode
# enumeration

# from http://mdtranslator.adiwg.org/api/codelists?format=xml

# History:
# 	Stan Smith 2013-10-21 original script
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2014-12-15 replaced NOAA CT_CodelistCatalogue with mdTranslator CT_CodelistCatalogue

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

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

            end
        end
    end
end
