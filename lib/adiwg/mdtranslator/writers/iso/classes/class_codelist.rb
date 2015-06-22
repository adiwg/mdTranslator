# ISO <<CodeLists>>

# from http://mdtranslator.adiwg.org/api/codelists?format=xml
# History:
# 	Stan Smith 2013-08-09 original script
#   Stan Smith 2014-10-15 allow non-ISO codesNames to be rendered
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2014-12-15 replaced NOAA CT_CodelistCatalogue with mdTranslator CT_CodelistCatalogue
#   Stan Smith 2015-06-11 refactored to use mdCodes gem for codelist contents
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)

require 'adiwg-mdcodes'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class MD_Codelist

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(codeList, codeName)

                        # get requested codelist from the adiwg-mdcodes gem
                        mdCodelist = ADIWG::Mdcodes.getCodelistDetail(codeList, @responseObj)

                        sourceName = mdCodelist['sourceName']
                        codelist = mdCodelist['codelist']
                        codeId = 'user-provided-code'

                        # search the codelist for a matching codeName
                        codelist.each do |code|
                            if code['codeName'] == codeName
                                codeId = code['code']
                                break
                            end
                        end

                        # generate the iso code block
                        @xml.tag!('gmd:' + "#{sourceName}", {:codeList => 'http://mdtranslator.adiwg.org/api/codelists?format=xml#' + "#{sourceName}",
                                                       :codeListValue => "#{codeName}",
                                                       :codeSpace => "#{codeId}"})
                    end

                end

            end
        end
    end
end
