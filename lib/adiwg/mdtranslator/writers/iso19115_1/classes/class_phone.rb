# ISO <<Class>> CI_Telephone
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-03-18 original script.

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class CI_Telephone

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(aPhones)

                  @xml.tag!('cit:CI_Telephone') do

                     # voice phones
                     voiceCount = 0
                     aPhones.each do |hPhone|
                        if hPhone[:phoneServiceTypes].empty?
                           hPhone[:phoneServiceTypes] << 'voice'
                        end
                        if hPhone[:phoneServiceTypes].include?('voice')
                           pName = hPhone[:phoneName]
                           pNumber = hPhone[:phoneNumber]
                           if pName.nil?
                              s = pNumber
                           else
                              s = pName + ': ' + pNumber
                           end
                           @xml.tag!('cit:voice') do
                              @xml.tag!('gco:CharacterString', s)
                              voiceCount += 1
                           end
                        end
                     end
                     if voiceCount == 0 && @hResponseObj[:writerShowTags]
                        @xml.tag!('cit:voice')
                     end

                     # fax phones
                     faxCount = 0
                     aPhones.each do |hPhone|
                        if hPhone[:phoneServiceTypes].include?('fax') ||
                           hPhone[:phoneServiceTypes].include?('facsimile')
                           pName = hPhone[:phoneName]
                           pNumber = hPhone[:phoneNumber]
                           if pName.nil?
                              s = pNumber
                           else
                              s = pName + ': ' + pNumber
                           end
                           @xml.tag!('cit:facsimile') do
                              @xml.tag!('gco:CharacterString', s)
                              faxCount += 1
                           end
                        end
                     end
                     if faxCount == 0 && @hResponseObj[:writerShowTags]
                        @xml.tag!('cit:facsimile')
                     end

                  end # CI_Telephone tag
               end # write XML
            end # CI_Telephone class

         end
      end
   end
end
