# unpack distributor
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2016-10-21 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_responsibleParty')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_orderProcess')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_transferOption')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Distributor

                    def self.unpack(hDistrib, responseObj)

                        # return nil object if input is empty
                        if hDistrib.empty?
                            responseObj[:readerExecutionMessages] << 'Distributor object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intDistrib = intMetadataClass.newDistributor

                        # distributor - contact {responsibleParty}
                        if hDistrib.has_key?('contact')
                            hObject = hDistrib['contact']
                            unless hObject.empty?
                                hReturn = ResponsibleParty.unpack(hObject, responseObj)
                                unless hReturn.nil?
                                    intDistrib[:contact] = hReturn
                                end
                            end
                        end

                        # distributor - order process [orderProcess]
                        if hDistrib.has_key?('orderProcess')
                            aItems = hDistrib['orderProcess']
                            aItems.each do |item|
                                hReturn = OrderProcess.unpack(item, responseObj)
                                unless hReturn.nil?
                                    intDistrib[:orderProcess] << hReturn
                                end
                            end
                        end

                        # distributor - transfer options [transferOption]
                        if hDistrib.has_key?('transferOptions')
                            aItemss = hDistrib['transferOptions']
                            aItemss.each do |item|
                                hReturn = TransferOption.unpack(item, responseObj)
                                unless hReturn.nil?
                                    intDistrib[:transferOptions] << hReturn
                                end
                            end
                        end

                        return intDistrib
                    end

                end

            end
        end
    end
end
