# ISO <<Class>> MD_DigitalTransferOptions
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-04-10 original script

require_relative 'class_onlineResource'
require_relative 'class_medium'
require_relative 'class_format'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class MD_DigitalTransferOptions

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hOption, inContext = nil)

                  # classes used
                  olResClass = CI_OnlineResource.new(@xml, @hResponseObj)
                  mediumClass = MD_Medium.new(@xml, @hResponseObj)
                  formatClass = MD_Format.new(@xml, @hResponseObj)

                  outContext = 'transfer option'
                  outContext = inContext + ' transfer option' unless inContext.nil?

                  @xml.tag!('mrd:MD_DigitalTransferOptions') do

                     # digital transfer options - units of distribution
                     unless hOption[:unitsOfDistribution].nil?
                        @xml.tag!('mrd:unitsOfDistribution') do
                           @xml.tag!('gco:CharacterString', hOption[:unitsOfDistribution])
                        end
                     end
                     if hOption[:unitsOfDistribution].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrd:unitsOfDistribution')
                     end

                     # digital transfer options - transfer size {MB}
                     unless hOption[:transferSize].nil?
                        @xml.tag!('mrd:transferSize') do
                           @xml.tag!('gco:Real', hOption[:transferSize].to_s)
                        end
                     end
                     if hOption[:transferSize].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrd:transferSize')
                     end

                     # digital transfer options - online [] {CI_OnlineResource}
                     aOnlineOps = hOption[:onlineOptions]
                     aOnlineOps.each do |hOlOption|
                        @xml.tag!('mrd:onLine') do
                           olResClass.writeXML(hOlOption, outContext)
                        end
                     end
                     if aOnlineOps.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrd:onLine')
                     end

                     # digital transfer options - offline [] {MD_Medium}
                     aOfflineOps = hOption[:offlineOptions]
                     aOfflineOps.each do |hOffline|
                        @xml.tag!('mrd:offLine') do
                           mediumClass.writeXML(hOffline)
                        end
                     end
                     if aOfflineOps.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrd:offLine')
                     end

                     # digital transfer options - transfer frequency {TM_PeriodDuration}
                     hDuration = hOption[:transferFrequency]
                     unless hDuration.empty?
                        duration = AdiwgDateTimeFun.writeDuration(hDuration)
                        @xml.tag!('mrd:transferFrequency') do
                           @xml.tag!('gco:TM_PeriodDuration', duration)
                        end
                     end
                     if hDuration.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrd:transferFrequency')
                     end

                     # digital transfer options - distribution format [] {MD_Format}
                     aFormats = hOption[:distributionFormats]
                     aFormats.each do |hFormat|
                        @xml.tag!('mrd:distributionFormat') do
                           formatClass.writeXML(hFormat)
                        end
                     end
                     if aFormats.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrd:distributionFormat')
                     end

                  end # mrd:MD_DigitalTransferOptions tag
               end # writeXML
            end # MD_DigitalTransferOptions class

         end
      end
   end
end
