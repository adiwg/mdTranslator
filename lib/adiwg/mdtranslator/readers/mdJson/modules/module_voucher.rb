# unpack voucher
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-02-19 refactored error and warning messaging
#   Stan Smith 2016-10-21 original script

require_relative 'module_responsibleParty'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module Voucher

               def self.unpack(hVoucher, responseObj)

                  # return nil object if input is empty
                  if hVoucher.empty?
                     responseObj[:readerExecutionMessages] << 'WARNING: mdJson reader: voucher object is empty'
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intVoucher = intMetadataClass.newTaxonVoucher

                  # voucher - specimen (required)
                  if hVoucher.has_key?('specimen')
                     intVoucher[:specimen] = hVoucher['specimen']
                  end
                  if intVoucher[:specimen].nil? || intVoucher[:specimen] == ''
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson voucher specimen is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # voucher - repository (required)
                  if hVoucher.has_key?('repository')
                     hObject = hVoucher['repository']
                     unless hObject.empty?
                        hReturn = ResponsibleParty.unpack(hObject, responseObj)
                        unless hReturn.nil?
                           intVoucher[:repository] = hReturn
                        end
                     end
                  end
                  if intVoucher[:repository].empty?
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson voucher repository is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  return intVoucher

               end

            end

         end
      end
   end
end
