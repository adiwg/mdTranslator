# ISO <<Class>> MD_Vouchers
# 19115-2 writer output in XML

# History:
#  Stan Smith 2018-04-10 add error and warning messaging
#  Stan Smith 2016-12-09 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#  Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
# 	Stan Smith 2013-11-19 original script

require_relative '../iso19115_2_writer'
require_relative 'class_responsibleParty'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class MD_Vouchers

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_2
               end

               def writeXML(hVoucher)

                  # classes used in MD_Vouchers
                  partyClass = CI_ResponsibleParty.new(@xml, @hResponseObj)

                  @xml.tag!('gmd:MD_Vouchers') do

                     # voucher - specimen (required)
                     s = hVoucher[:specimen]
                     if s.nil?
                        @NameSpace.issueWarning(340, 'gmd:specimen')
                     else
                        @xml.tag!('gmd:specimen') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end

                     # voucher - repository (required) {MD_ResponsibleParty}
                     hRParty = hVoucher[:repository]
                     if hRParty.empty?
                        @NameSpace.issueWarning(341, 'gmd:specimen')
                     else
                        role = hRParty[:roleName]
                        hParty = hRParty[:parties][0]
                        @xml.tag!('gmd:reposit') do
                           partyClass.writeXML(role, hParty, 'taxonomic voucher repository')
                        end
                     end

                  end # gmd:MD_Vouchers tag
               end # writeXML
            end # MD_Vouchers class

         end
      end
   end
end
