# FGDC <<Class>> Phone
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2017-11-28 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class Phone

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(aPhones)

                  # phone 10.5 (cntvoice) - voice phone [] (required)
                  # <- hPhone[:phoneNumber] where hPhone[:phoneServiceTypes] = 'voice'
                  haveVoice = false
                  aPhones.each do |hPhone|
                     if hPhone[:phoneServiceTypes].include?('voice')
                        unless hPhone[:phoneNumber].nil?
                           @xml.tag!('cntvoice', hPhone[:phoneNumber])
                           haveVoice = true
                        end
                     end
                  end
                  unless haveVoice
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Contact is missing voice phone'
                  end

                  # phone 10.6 (cnttdd) - tty phone []
                  # <- hPhone[:phoneNumber] where hPhone[:phoneServiceTypes] = 'tty'
                  haveTTY = false
                  aPhones.each do |hPhone|
                     if hPhone[:phoneServiceTypes].include?('tty')
                        unless hPhone[:phoneNumber].nil?
                           @xml.tag!('cnttdd', hPhone[:phoneNumber])
                           haveTTY = true
                        end
                     end
                  end
                  if !haveTTY && @hResponseObj[:writerShowTags]
                     @xml.tag!('cnttdd')
                  end

                  # phone 10.7 (cntfax) - fax phone []
                  # <- hPhone[:phoneNumber] where hPhone[:phoneServiceTypes] = ['fax' | 'facsimile']
                  haveFax = false
                  aPhones.each do |hPhone|
                     if hPhone[:phoneServiceTypes].include?('fax') || hPhone[:phoneServiceTypes].include?('facsimile')
                        unless hPhone[:phoneNumber].nil?
                           @xml.tag!('cntfax', hPhone[:phoneNumber])
                           haveFax = true
                        end
                     end
                  end
                  if !haveFax && @hResponseObj[:writerShowTags]
                     @xml.tag!('cntfax')
                  end

               end # writeXML
            end # Phone

         end
      end
   end
end
