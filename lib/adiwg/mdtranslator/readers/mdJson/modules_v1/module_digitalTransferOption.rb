# unpack digital transfer option
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2015-08-24 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_onlineResource')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_medium')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module DigitalTransOption

                    def self.unpack(hDigTranOpt, responseObj)

                        # return nil object if input is empty
                        intDigitalTran = nil
                        return if hDigTranOpt.empty?

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intDigitalTran = intMetadataClass.newDigitalTransOption

                        # distributor - distribution transfer options
                        if hDigTranOpt.has_key?('online')
                            aOnlineOption = hDigTranOpt['online']
                            aOnlineOption.each do |hOlOption|
                                intDigitalTran[:online] << OnlineResource.unpack(hOlOption, responseObj)
                            end
                        end

                        if hDigTranOpt.has_key?('offline')
                            hOfflOption = hDigTranOpt['offline']
                            if !hOfflOption.empty?
                                intDigitalTran[:offline] = Medium.unpack(hOfflOption, responseObj)

                            end
                        end

                        return intDigitalTran
                    end

                end

            end
        end
    end
end
