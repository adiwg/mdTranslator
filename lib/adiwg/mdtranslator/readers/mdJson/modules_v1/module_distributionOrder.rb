# unpack distribution order process
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2015-08-24 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_dateTime')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module DistributionOrder

                    def self.unpack(hDistOrder, responseObj)

                        # return nil object if input is empty
                        intDistOrder = nil
                        return if hDistOrder.empty?

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intDistOrder = intMetadataClass.newDistOrder

                        if hDistOrder.has_key?('fees')
                            s = hDistOrder['fees']
                            if s != ''
                                intDistOrder[:fees] = s
                            end
                        end

                        if hDistOrder.has_key?('plannedAvailabilityDateTime')
                            s = hDistOrder['plannedAvailabilityDateTime']
                            if s != ''
                                intDistOrder[:plannedDateTime] = DateTime.unpack(s, responseObj)
                            end
                        end

                        if hDistOrder.has_key?('orderingInstructions')
                            s = hDistOrder['orderingInstructions']
                            if s != ''
                                intDistOrder[:orderInstructions] = s
                            end
                        end

                        if hDistOrder.has_key?('turnaround')
                            s = hDistOrder['turnaround']
                            if s != ''
                                intDistOrder[:turnaround] = s
                            end
                        end

                        return intDistOrder
                    end

                end

            end
        end
    end
end
