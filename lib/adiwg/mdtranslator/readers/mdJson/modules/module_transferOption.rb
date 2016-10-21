# unpack transfer option
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2016-10-21 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_medium')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_format')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_onlineResource')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_duration')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module TransferOption

                    def self.unpack(hTransOp, responseObj)

                        # return nil object if input is empty
                        if hTransOp.empty?
                            responseObj[:readerExecutionMessages] << 'Transfer Option object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intTransOpt = intMetadataClass.newTransferOption

                        # transfer option - transfer size
                        if hTransOp.has_key?('transferSize')
                            if hTransOp['transferSize'] != ''
                                intTransOpt[:transferSize] = hTransOp['transferSize']
                            end
                        end

                        # transfer option - transfer units
                        if hTransOp.has_key?('transferUnits')
                            if hTransOp['transferSize'] != ''
                                intTransOpt[:transferUnits] = hTransOp['transferUnits']
                            end
                        end

                        # transfer option - online option [onlineResource]
                        if hTransOp.has_key?('onlineOption')
                            hTransOp['onlineOption'].each do |item|
                                hReturn = OnlineResource.unpack(item, responseObj)
                                unless hReturn.nil?
                                    intTransOpt[:onlineOptions] << hReturn
                                end
                            end
                        end

                        # transfer option - offline option [medium]
                        if hTransOp.has_key?('offlineOption')
                            hTransOp['offlineOption'].each do |item|
                                hReturn = Medium.unpack(item, responseObj)
                                unless hReturn.nil?
                                    intTransOpt[:offlineOptions] << hReturn
                                end
                            end
                        end

                        # transfer option - transferFrequency {duration}
                        if hTransOp.has_key?('transferFrequency')
                            hObject = hTransOp['transferFrequency']
                            unless hObject.empty?
                                hReturn = Duration.unpack(hObject, responseObj)
                                unless hReturn.nil?
                                    intTransOpt[:transferFrequency] = hReturn
                                end
                            end
                        end

                        # transfer option - distribution format [format]
                        if hTransOp.has_key?('distributionFormat')
                            hTransOp['distributionFormat'].each do |item|
                                hReturn = Format.unpack(item, responseObj)
                                unless hReturn.nil?
                                    intTransOpt[:distributionFormats] << hReturn
                                end
                            end
                        end

                        return intTransOpt
                    end

                end

            end
        end
    end
end
