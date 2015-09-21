# unpack distribution info
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-09-23 original script
# 	Stan Smith 2013-11-27 changed to receive single distributor rather than array
# 	Stan Smith 2013-12-18 changed to unpack contact using responsible party
#   Stan Smith 2014-05-02 changed to support responsible party as hash, not array
#   Stan Smith 2014-07-08 resolve require statements using Mdtranslator.reader_module
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to remove global namespace constants
#   Stan Smith 2015-08-24 refactored to normalize module; created new modules for
#   ... distributionOrder, digitalTransferOption, and medium

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_responsibleParty')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_distributionOrder')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_resourceFormat')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_digitalTransferOption')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module DistributionInfo

                    def self.unpack(hDistributor, responseObj)

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intDistributor = intMetadataClass.newDistributor


                        # distributor - distribution contact - required
                        if hDistributor.has_key?('distributorContact')
                            hContact = hDistributor['distributorContact']
                            unless hContact.empty?
                                intDistributor[:distContact] = ResponsibleParty.unpack(hContact, responseObj)
                            else
                                responseObj[:readerExecutionMessages] << 'Distributor contact is empty'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        else
                            responseObj[:readerExecutionMessages] << 'Distributor contact is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # distributor - distribution order process
                        if hDistributor.has_key?('distributionOrderProcess')
                            aDistOrder = hDistributor['distributionOrderProcess']
                            unless aDistOrder.empty?
                                aDistOrder.each do |hDistOrder|
                                    intDistributor[:distOrderProcs] << DistributionOrder.unpack(hDistOrder, responseObj)
                                end
                            end
                        end

                        # distributor - distribution format
                        if hDistributor.has_key?('distributorFormat')
                            aDistFormat = hDistributor['distributorFormat']
                            unless aDistFormat.empty?
                                aDistFormat.each do |hResFormat|
                                    intDistributor[:distFormats] << ResourceFormat.unpack(hResFormat, responseObj)
                                end
                            end
                        end

                        # distributor - distribution transfer options
                        if hDistributor.has_key?('distributorTransferOptions')
                            aDistTransOpt = hDistributor['distributorTransferOptions']
                            unless aDistTransOpt.empty?
                                aDistTransOpt.each do |hDigTranOpt|
                                    intDistributor[:distTransOptions] << DigitalTransOption.unpack(hDigTranOpt, responseObj)
                                end
                            end
                        end

                        return intDistributor
                    end

                end

            end
        end
    end
end
