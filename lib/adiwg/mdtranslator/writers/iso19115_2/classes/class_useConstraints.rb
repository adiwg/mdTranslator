# ISO <<Class>> MD_Constraints
# 19115-2 writer output in XML

# History:
#  Stan Smith 2016-12-13 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
# 	Stan Smith 2013-10-31 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class MD_Constraints

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hConstraint)

                  @xml.tag!('gmd:MD_Constraints') do

                     # use constraints - use limitation []
                     aCons = hConstraint[:useLimitation]
                     aCons.each do |useCon|
                        @xml.tag!('gmd:useLimitation') do
                           @xml.tag!('gco:CharacterString', useCon)
                        end
                     end
                     if aCons.empty?
                        @xml.tag!('gmd:useLimitation') && @hResponseObj[:writerShowTags]
                     end

                  end # gmd:MD_Constraints tag
               end # writeXML
            end # MD_Constraints class

         end
      end
   end
end
