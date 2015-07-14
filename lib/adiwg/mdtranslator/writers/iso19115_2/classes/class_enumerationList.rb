# ISO <<CodeLists>> Enumerations

# from http://mdtranslator.adiwg.org/api/codelists?format=xml
# History:
# 	Stan Smith 2013-08-09 original script
#   Stan Smith 2014-10-15 allow non-ISO codesNames to be rendered
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2014-12-15 replaced NOAA CT_CodelistCatalogue with mdTranslator CT_CodelistCatalogue
#   Stan Smith 2015-06-12 refactored to use mdCodes gem for codelist contents
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS

require 'adiwg-mdcodes'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class MD_EnumerationList

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(codeList, codeName)

                        # get requested codelist from the adiwg-mdcodes gem
                        mdCodelist = ADIWG::Mdcodes.getCodelistDetail(codeList)

                        sourceName = mdCodelist['sourceName']
                        codelist = mdCodelist['codelist']

                        # search the codelist for a matching codeName
                        # only valid enumeration values can be written in ISO
                        codelist.each do |code|
                            if code['codeName'] == codeName
                                @xml.tag!('gmd:' + "#{sourceName}", codeName)
                                break
                            end
                        end

                    end

                end

            end
        end
    end
end
