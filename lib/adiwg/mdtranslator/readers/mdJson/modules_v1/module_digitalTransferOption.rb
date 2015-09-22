# unpack digital transfer option
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2015-08-24 original script
#   Stan Smith 2015-09-18 added distribution formats, transfer size

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_onlineResource')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_medium')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_resourceFormat')

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

                        # distribution transfer options - distribution format []
                        if hDigTranOpt.has_key?('distributorFormat')
                            aDistFormat = hDigTranOpt['distributorFormat']
                            unless aDistFormat.empty?
                                aDistFormat.each do |hResFormat|
                                    intDigitalTran[:distFormats] << ResourceFormat.unpack(hResFormat, responseObj)
                                end
                            end
                        end

                        # distribution transfer options - transfer size
                        if hDigTranOpt.has_key?('transferSize')
                            s = hDigTranOpt['transferSize']
                            if s != ''
                                intDigitalTran[:transferSize] = s
                            end
                        end

                        # distribution transfer options - transfer size units
                        if hDigTranOpt.has_key?('transferSizeUnits')
                            s = hDigTranOpt['transferSizeUnits']
                            if s != ''
                                intDigitalTran[:transferSizeUnits] = s
                            end
                        end

                        # distribution transfer options - online []
                        if hDigTranOpt.has_key?('online')
                            aOnlineOption = hDigTranOpt['online']
                            aOnlineOption.each do |hOlOption|
                                intDigitalTran[:online] << OnlineResource.unpack(hOlOption, responseObj)
                            end
                        end

                        # distribution transfer options - offline
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
