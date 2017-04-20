# unpack voucher
# Reader - ADIwg JSON to internal data structure

# History:
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
                            responseObj[:readerExecutionMessages] << 'Voucher object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intVoucher = intMetadataClass.newTaxonVoucher

                        # voucher - specimen
                        if hVoucher.has_key?('specimen')
                            intVoucher[:specimen] = hVoucher['specimen']
                        end
                        if intVoucher[:specimen].nil? || intVoucher[:specimen] == ''
                            responseObj[:readerExecutionMessages] << 'Voucher object is missing specimen'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # voucher - repository
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
                            responseObj[:readerExecutionMessages] << 'Voucher object is missing repository'
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
