require 'uri'
require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_responsibleParty')

module ADIWG
    module Mdtranslator
        module Readers
            module SbJson
                module DistributionInfo
                    def self.unpack(hDistributor, responseObj, intObj)
                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intDistributor = intMetadataClass.newDistributor

                        # distributor - distribution contact - required
                        # We're just injecting the first SB contact here
                        # with a a role of "distributor", if none just use
                        # the default SB contact
                        aCust = {}
                        dist = intObj[:contacts].find { |c| c[:sbType] == 'Distributor' }

                        unless dist.nil?
                            aCust['contactId'] = dist[:contactId]
                            aCust['role'] = 'distributor'
                        else
                            aCust['contactId'] = 'SB'
                            aCust['role'] = 'distributor'
                        end
                        intDistributor[:distContact] = ResponsibleParty.unpack(aCust, responseObj)

                        # distributor - distribution order process
                        if hDistributor.key?('materialRequestInstructions')
                            aDistOrder = hDistributor['materialRequestInstructions']
                            unless aDistOrder.empty?
                                intDistOrder = intMetadataClass.newDistOrder
                                intDistOrder[:orderInstructions] = hDistributor['materialRequestInstructions']
                                intDistributor[:distOrderProcs] << intDistOrder
                            end
                        end

                        # distributor - distribution transfer options
                        if hDistributor.key?('distributionLinks')
                            aDistTransOpt = hDistributor['distributionLinks']
                            unless aDistTransOpt.empty?
                                options = intMetadataClass.newDigitalTransOption
                                aDistTransOpt.each do |opt|
                                    aOpt = intMetadataClass.newOnlineResource
                                    aOpt[:olResURI] = opt['uri']
                                    aOpt[:olResProtocol] = URI.parse(opt['uri']).scheme
                                    aOpt[:olResName] = opt['title']
                                    aOpt[:olResDesc] = opt['typeLabel']
                                    aOpt[:olResFunction] = 'information'
                                    options[:online] << aOpt
                                end
                                intDistributor[:distTransOptions] << options
                            end
                        end

                        intDistributor
                    end
                end
            end
        end
    end
end
