# unpack voucher
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-27 refactored error and warning messaging
#  Stan Smith 2016-10-21 original script

require_relative 'module_responsibleParty'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module Voucher

               def self.unpack(hVoucher, responseObj)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hVoucher.empty?
                     @MessagePath.issueWarning(940, responseObj)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intVoucher = intMetadataClass.newTaxonVoucher

                  outContext = 'taxon voucher'

                  # voucher - specimen (required)
                  if hVoucher.has_key?('specimen')
                     intVoucher[:specimen] = hVoucher['specimen']
                  end
                  if intVoucher[:specimen].nil? || intVoucher[:specimen] == ''
                     @MessagePath.issueError(941, responseObj)
                  end

                  # voucher - repository (required)
                  if hVoucher.has_key?('repository')
                     hObject = hVoucher['repository']
                     unless hObject.empty?
                        hReturn = ResponsibleParty.unpack(hObject, responseObj, outContext)
                        unless hReturn.nil?
                           intVoucher[:repository] = hReturn
                        end
                     end
                  end
                  if intVoucher[:repository].empty?
                     @MessagePath.issueError(942, responseObj)
                  end

                  return intVoucher

               end

            end

         end
      end
   end
end
