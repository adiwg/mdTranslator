# Reader - fgdc to internal data structure
# unpack fgdc distribution order process

# History:
#  Stan Smith 2017-09-08 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_digitalForm'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module OrderProcess

               def self.unpack(xOrder, hDistributor, techPre, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hOrder = intMetadataClass.newOrderProcess

                  # distribution 6.4.1 (nondig) - non-digital form
                  # -> place as offline option
                  # -> distribution.distributor.transferOption.offlineOption.note
                  nonDigital = xOrder.xpath('./nondig').text
                  unless nonDigital.empty?
                     hTransfer = intMetadataClass.newTransferOption
                     hOffline = intMetadataClass.newMedium
                     hOffline[:note] = nonDigital
                     hTransfer[:offlineOptions] << hOffline
                     hDistributor[:transferOptions] << hTransfer
                  end

                  # distribution 6.4.2 (digform) - digital form []
                  axDigital = xOrder.xpath('./digform')
                  unless axDigital.empty?
                     axDigital.each do |xDigiForm|
                        hReturn = DigitalForm.unpack(xDigiForm, techPre, hResponseObj)
                        unless hReturn.nil?
                           hDistributor[:transferOptions] << hReturn
                        end
                     end
                  end

                  # error messages
                  if nonDigital.empty? && axDigital.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC standard order process digital/non-digital form is missing'
                  end

                  # distribution 6.4.3 (fees) - fees (required)
                  # -> distribution.distributor.orderProcess.fees
                  fees = xOrder.xpath('./fees').text
                  unless fees.empty?
                     hOrder[:fees] = fees
                  end
                  if fees.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC standard order process fee is missing'
                  end

                  # distribution 6.4.4 (ordering) - ordering information
                  # -> distribution.distributor.orderProcess.orderingInstructions
                  instructions = xOrder.xpath('./ordering').text
                  unless instructions.empty?
                     hOrder[:orderingInstructions] = instructions
                  end

                  # distribution 6.4.5 (turnarnd) - turnaround time
                  # -> distribution.distributor.orderProcess.turnaround
                  turnaround = xOrder.xpath('./turnarnd').text
                  unless turnaround.empty?
                     hOrder[:turnaround] = turnaround
                  end

                  hDistributor[:orderProcess] << hOrder

                  return hDistributor

               end

            end

         end
      end
   end
end
