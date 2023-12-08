# ISO <<CodeLists>>
# 19115-3 writer output in XML

# from http://mdtranslator.adiwg.org/api/codelists?format=xml
# History:
# 	Stan Smith 2019-03-14 original script

require 'adiwg-mdcodes'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

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
