# ISO <<CodeLists>>

# from http://mdtranslator.adiwg.org/api/codelists?format=xml
# History:
#  Stan Smith 2016-11-19 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2015-06-11 refactored to use mdCodes gem for codelist contents
#  Stan Smith 2014-12-15 replaced NOAA CT_CodelistCatalogue with mdTranslator CT_CodelistCatalogue
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#  Stan Smith 2014-10-15 allow non-ISO codesNames to be rendered
# 	Stan Smith 2013-08-09 original script

require 'adiwg-mdcodes'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class MD_Codelist

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(codeSpace, codeList, codeName)

                  # get requested codelist from the adiwg-mdcodes gem
                  mdCodelist = ADIWG::Mdcodes.getCodelistDetail(codeList, 'hash')

                  sourceName = mdCodelist['sourceName']
                  codelist = mdCodelist['codelist']
                  codeId = 'userCode'

                  # search the codelist for a matching codeName
                  codelist.each do |code|
                     if code['codeName'] == codeName
                        codeId = code['code']
                        break
                     end
                  end

                  # generate the iso code block
                  @xml.tag!(codeSpace + ':' + "#{sourceName}", {:codeList => 'http://mdtranslator.adiwg.org/api/codelists?format=xml#' + "#{sourceName}",
                                                                :codeListValue => "#{codeName}",
                                                                :codeSpace => "#{codeId}"})
               end

            end

         end
      end
   end
end
