# FGDC <<Class>> DigitalForm
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-01-31 original script

require_relative 'class_transferInfo'
require_relative 'class_onlineOption'
require_relative 'class_offlineOption'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class DigitalFormat

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hTransOpt)

                  # classes used
                  transClass = TransferInformation.new(@xml, @hResponseObj)
                  onClass = OnlineOption.new(@xml, @hResponseObj)
                  offClass = OfflineOption.new(@xml, @hResponseObj)

                  # digital format 6.4.2.1 (digtinfo) - digital transfer information
                  @xml.tag!('digtinfo') do
                     transClass.writeXML(hTransOpt)
                  end

                  # digital format 6.4.2.2 (digtopt) - digital transfer option
                  aOnline = hTransOpt[:onlineOptions]
                  aOffline = hTransOpt[:offlineOptions]
                  unless aOffline.empty? && aOnline.empty?
                     @xml.tag!('digtopt') do

                        # online option 6.4.2.2.1 (onlinopt) - online option
                        aOnline.each do |hOnline|
                           unless hOnline.empty?
                              @xml.tag!('onlinopt') do
                                 onClass.writeXML(hOnline)
                              end
                           end
                        end

                        # offline option 6.4.2.2.2 (offoptn) - offline option
                        aOffline.each do |hOffline|
                           unless hOffline.empty?

                              # skip offlineOptions handled as non-digital media
                              isNonDig = false
                              isNonDig = true unless hOffline[:note].nil?
                              isNonDig = false unless hOffline[:mediumSpecification].empty?
                              isNonDig = false unless hOffline[:density].nil?
                              isNonDig = false unless hOffline[:units].nil?
                              isNonDig = false unless hOffline[:numberOfVolumes].nil?
                              isNonDig = false unless hOffline[:mediumFormat].empty?
                              isNonDig = false unless hOffline[:identifier].empty?
                              unless isNonDig
                                 @xml.tag!('offoptn') do
                                    offClass.writeXML(hOffline)
                                 end
                              end

                           end
                        end

                     end
                  end

               end # writeXML
            end # DigitalFormat

         end
      end
   end
end
