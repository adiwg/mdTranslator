# ISO <<Class>> CI_Address
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-03-18 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class Email

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(aEmail)

                  @xml.tag!('gmd:CI_Address') do

                     unless aEmail.empty?

                        # address - email addresses []
                        aEmail.each do |myEmail|
                           @xml.tag!('cit:electronicMailAddress') do
                              @xml.tag!('gco:CharacterString', myEmail)
                           end
                        end
                        if aEmail.empty? && @hResponseObj[:writerShowTags]
                           @xml.tag!('cit:electronicMailAddress')
                        end

                     end

                  end # CI_Address tag
               end # writeXML
            end # CI_Address class

         end
      end
   end
end
