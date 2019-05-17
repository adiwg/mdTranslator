# ISO <<Class>> MD_Distributor
# 19115-2 writer output in XML

# History:
#  Stan Smith 2018-04-09 add error and warning messaging
#  Stan Smith 2016-12-07 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-09-21 added format from distributorTransferOptions
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#  Stan Smith 2014-07-09 modify require statements to function in RubyGem structure
# 	Stan Smith 2013-09-25 original script

require_relative '../iso19115_2_writer'
require_relative 'class_responsibleParty'
require_relative 'class_orderProcess'
require_relative 'class_format'
require_relative 'class_transferOptions'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class MD_Distributor

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_2
               end

               def writeXML(hDistributor)

                  # classes used
                  partyClass = CI_ResponsibleParty.new(@xml, @hResponseObj)
                  orderClass = MD_StandardOrderProcess.new(@xml, @hResponseObj)
                  formatClass = MD_Format.new(@xml, @hResponseObj)
                  transferClass = MD_DigitalTransferOptions.new(@xml, @hResponseObj)

                  outContext = 'distributor'

                  @xml.tag!('gmd:MD_Distributor') do

                     # distributor - contact (required) {CI_ResponsibleParty}
                     role = 'distributor'
                     hParty = hDistributor[:contact][:parties][0]
                     unless hParty.nil?
                        @xml.tag!('gmd:distributorContact') do
                           partyClass.writeXML(role, hParty, 'distributor')
                        end
                     end
                     if hParty.nil?
                        @NameSpace.issueWarning(90, 'gmd:distributorContact')
                     end

                     # distributor - order process [{MD_StandardOrderProcess}]
                     aDistOrderProc = hDistributor[:orderProcess]
                     aDistOrderProc.each do |hOrder|
                        @xml.tag!('gmd:distributionOrderProcess') do
                           orderClass.writeXML(hOrder)
                        end
                     end
                     if aDistOrderProc.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:distributionOrderProcess')
                     end

                     # distributor - format [{MD_Format}]
                     format = false
                     aOptions = hDistributor[:transferOptions]
                     aOptions.each do |hOption|
                        aFormats = hOption[:distributionFormats]
                        aFormats.each do |hFormat|
                           format = true
                           @xml.tag!('gmd:distributorFormat') do
                              formatClass.writeXML(hFormat, outContext + ' format')
                           end
                        end
                     end
                     if !format && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:distributorFormat')
                     end

                     # distributor - transfer options [{MD_DigitalTransferOptions}]
                     aOptions = hDistributor[:transferOptions]
                     aOptions.each do |hOption|
                        @xml.tag!('gmd:distributorTransferOptions') do
                           transferClass.writeXML(hOption)
                        end
                     end
                     if aOptions.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:distributorTransferOptions')
                     end

                  end # gmd:MD_Distributor tag
               end # writeXML
            end # MD_Distributor class

         end
      end
   end
end
