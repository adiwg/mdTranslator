# ISO <<CodeLists>> Enumerations
# 19115-2 writer output in XML

# History:
#  Stan Smith 2016-12-12 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#  Stan Smith 2015-06-12 refactored to use mdCodes gem for codelist contents
#  Stan Smith 2014-12-15 replaced NOAA CT_CodelistCatalogue with mdTranslator CT_CodelistCatalogue
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#  Stan Smith 2014-10-15 allow non-ISO codesNames to be rendered
# 	Stan Smith 2013-08-09 original script

require 'adiwg-mdcodes'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class MD_EnumerationList

               def initialize(xml, responseObj)
                  @xml = xml
                  @hResponseObj = responseObj
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

               end # writeXML
            end # MD_EnumerationList class

         end
      end
   end
end
