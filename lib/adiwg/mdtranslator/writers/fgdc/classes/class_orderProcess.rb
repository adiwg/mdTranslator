# FGDC <<Class>> OrderProcess
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-01-31 original script

require_relative 'class_digitalForm'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class OrderProcess

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hDistributor)

                  # classes used
                  digiClass = DigitalFormat.new(@xml, @hResponseObj)

                  # for FGDC only the first orderProcess can be accepted because ...
                  # in FGDC transferOptions are children of orderProcess
                  # in mdJson/ISO transferOptions are children of distributor
                  # therefore in FGDC all transferOptions will be collected and mapped to
                  # the first orderProcess and all other orderProcess records will be lost
                  hOrder = hDistributor[:orderProcess][0]
                  aTransfer = hDistributor[:transferOptions]

                  # order process 6.4.1 (nondig) - non-digital form
                  # non-digital are 'offline' transferOptions that have ONLY 'note' populated
                  # if a transferOption is written as non-digital take care not to write again as digital
                  # only one non-digital transfer is allowed per orderProcess
                  doBreak = false
                  aTransfer.each do |hTransOpt|
                     hTransOpt[:offlineOptions].each do |hOffline|
                        isNonDig = false
                        isNonDig = true unless hOffline[:note].nil?
                        isNonDig = false unless hOffline[:mediumSpecification].empty?
                        isNonDig = false unless hOffline[:density].nil?
                        isNonDig = false unless hOffline[:units].nil?
                        isNonDig = false unless hOffline[:numberOfVolumes].nil?
                        isNonDig = false unless hOffline[:mediumFormat].empty?
                        isNonDig = false unless hOffline[:identifier].empty?
                        if isNonDig
                           @xml.tag!('nondig', hOffline[:note])
                           doBreak = true
                        end
                        break if doBreak
                     end
                     break if doBreak
                  end

                  # order process 6.4.2 (digform) - digital form
                  # handles transferOptions for online and offline options
                  aTransfer.each do |hTransOpt|
                     @xml.tag!('digform') do
                        digiClass.writeXML(hTransOpt)
                     end
                  end
                  if aTransfer.empty? && @hResponseObj[:writerShowTags]
                     @xml.tag!('digform')
                  end

                  # order process 6.4.3 (fees) - fees
                  unless hOrder[:fees].nil?
                     @xml.tag!('fees', hOrder[:fees])
                  end
                  if hOrder[:fees].nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('fees')
                  end

                  # order process 6.4.4 (ordering) - order instructions
                  unless hOrder[:orderingInstructions].nil?
                     @xml.tag!('ordering', hOrder[:orderingInstructions])
                  end
                  if hOrder[:orderingInstructions].nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('ordering')
                  end

                  # order process 6.4.5 (turnarnd) - turnaround
                  unless hOrder[:turnaround].nil?
                     @xml.tag!('turnarnd', hOrder[:turnaround])
                  end
                  if hOrder[:turnaround].nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('turnarnd')
                  end

               end # writeXML
            end # OrderProcess

         end
      end
   end
end
