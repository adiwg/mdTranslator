# ISO <<Class>> CI_Telephone
# 19115-2 writer output in XML

# History:
#  Stan Smith 2016-11-17 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#  Stan Smith 2014-05-14 reorganized for JSON schema 0.4.0
# 	Stan Smith 2013-08-12 original script.

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class CI_Telephone

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(aPhones)

                  # ISO requires phones to be grouped in order (voice, fax)
                  @xml.tag!('gmd:CI_Telephone') do

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
                           @xml.tag!('gmd:voice') do
                              @xml.tag!('gco:CharacterString', s)
                              voiceCount += 1
                           end
                        end
                     end
                     if voiceCount == 0 && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:voice')
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
                           @xml.tag!('gmd:facsimile') do
                              @xml.tag!('gco:CharacterString', s)
                              faxCount += 1
                           end
                        end
                     end
                     if faxCount == 0 && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:facsimile')
                     end

                  end # CI_Telephone tag
               end # write XML
            end # CI_Telephone class

         end
      end
   end
end
