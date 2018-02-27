# Reader - fgdc to internal data structure
# unpack fgdc distribution digital form

# History:
#  Stan Smith 2017-09-08 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_date'
require_relative 'module_transferInfo'
require_relative 'module_onlineOption'
require_relative 'module_offlineOption'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module DigitalForm

               def self.unpack(xDigiForm, techPre, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hTransfer = intMetadataClass.newTransferOption

                  # distribution 6.4.2.1 (digtinfo) - digital transfer information (required)
                  xTranInfo = xDigiForm.xpath('./digtinfo')
                  unless xTranInfo.empty?
                     TransferInfo.unpack(xTranInfo, hTransfer, techPre, hResponseObj)
                  end
                  if xTranInfo.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: order process transfer info is missing'
                  end

                  # distribution 6.4.2.2 (digtopt) - digital transfer option (required)
                  xDigiOption = xDigiForm.xpath('./digtopt')
                  unless xDigiOption.empty?

                     # distribution 6.4.2.2.1 (onlinopt) - online option []
                     axOnlines = xDigiOption.xpath('./onlinopt')
                     unless axOnlines.empty?
                        axOnlines.each do |xOnline|
                           aOnlines = OnlineOption.unpack(xOnline, hResponseObj)
                           aOnlines.each do |hOnline|
                              hTransfer[:onlineOptions] << hOnline
                           end
                        end
                     end

                     # distribution 6.4.2.2.2 (offoptn) - offline option []
                     axOfflines = xDigiOption.xpath('./offoptn')
                     unless axOfflines.empty?
                        axOfflines.each do |xOffline|
                           aOffline = OfflineOption.unpack(xOffline, hResponseObj)
                           aOffline.each do |hOffline|
                              hTransfer[:offlineOptions] << hOffline
                           end
                        end
                     end

                  end
                  if xDigiOption.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: order process transfer option is missing'
                  end

                  return hTransfer

               end
            end

         end
      end
   end
end
