# ISO <<Class>> MD_Distributor
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-04-09 original script

require_relative '../iso19115_1_writer'
require_relative 'class_responsibility'
require_relative 'class_orderProcess'
require_relative 'class_transferOptions'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class MD_Distributor

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_2
               end

               def writeXML(hDistributor)

                  # classes used
                  responsibilityClass = CI_Responsibility.new(@xml, @hResponseObj)
                  orderClass = MD_StandardOrderProcess.new(@xml, @hResponseObj)
                  transferClass = MD_DigitalTransferOptions.new(@xml, @hResponseObj)

                  @xml.tag!('mrd:MD_Distributor') do

                     # distributor - contact (required) {CI_Responsibility}
                     hContact = hDistributor[:contact]
                     unless hContact.empty?
                        @xml.tag!('mrd:distributorContact') do
                           responsibilityClass.writeXML(hContact, 'distributor')
                        end
                     end
                     if hContact.empty?
                        @NameSpace.issueWarning(90, 'mrd:distributorContact')
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

                     # distributor - format [] {MD_Format}
                     # supported under transfer options

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
