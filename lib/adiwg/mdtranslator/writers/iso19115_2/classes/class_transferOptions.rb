# ISO <<Class>> MD_DigitalTransferOptions
# 19115-2 writer output in XML

# History:
#  Stan Smith 2016-12-07 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-09-21 added transfer size
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#  Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
# 	Stan Smith 2013-09-26 original script

require_relative 'class_onlineResource'
require_relative 'class_medium'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class MD_DigitalTransferOptions

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hOption)

                  # classes used
                  olResClass = CI_OnlineResource.new(@xml, @hResponseObj)
                  medClass = MD_Medium.new(@xml, @hResponseObj)

                  outContext = 'transfer option'

                  @xml.tag!('gmd:MD_DigitalTransferOptions') do

                     # digital transfer options - units of distribution
                     s = hOption[:unitsOfDistribution]
                     unless s.nil?
                        @xml.tag!('gmd:unitsOfDistribution') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:unitsOfDistribution')
                     end

                     # digital transfer options - transfer size {MB}
                     s = hOption[:transferSize]
                     unless s.nil?
                        @xml.tag!('gmd:transferSize') do
                           @xml.tag!('gco:Real', s.to_s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:transferSize')
                     end

                     # digital transfer options - online [] {CI_OnlineResource}
                     aOnTranOpts = hOption[:onlineOptions]
                     aOnTranOpts.each do |hOlOption|
                        @xml.tag!('gmd:onLine') do
                           olResClass.writeXML(hOlOption, outContext)
                        end
                     end
                     if aOnTranOpts.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:onLine')
                     end

                     # digital transfer options - offline {MD_Medium}
                     aOffTranOpt = hOption[:offlineOptions]
                     unless aOffTranOpt.empty?
                        hOffTranOpt = aOffTranOpt[0]
                        unless hOffTranOpt.empty?
                           @xml.tag!('gmd:offLine') do
                              medClass.writeXML(hOffTranOpt)
                           end
                        end
                     end
                     if aOffTranOpt.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:offLine')
                     end

                  end # gmd:MD_DigitalTransferOptions tag
               end # writeXML
            end # MD_DigitalTransferOptions class

         end
      end
   end
end
