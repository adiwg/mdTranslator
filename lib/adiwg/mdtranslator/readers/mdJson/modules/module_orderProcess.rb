# unpack order process
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2016-10-21 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_dateTime')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module OrderProcess

                    def self.unpack(hOrder, responseObj)

                        # return nil object if input is empty
                        if hOrder.empty?
                            responseObj[:readerExecutionMessages] << 'Order Process object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intOrder = intMetadataClass.newOrderProcess

                        # order process - fees
                        if hOrder.has_key?('fees')
                            if hOrder['fees'] != ''
                                intOrder[:fees] = hOrder['fees']
                            end
                        end

                        # order process - planned availability
                        if hOrder.has_key?('plannedAvailability')
                            unless hOrder['plannedAvailability'].empty?
                                hDate = DateTime.unpack(hOrder['plannedAvailability'], responseObj)
                                unless hDate.nil?
                                    intOrder[:plannedAvailability] = hDate
                                end
                            end
                        end

                        # order process - ordering instructions
                        if hOrder.has_key?('orderingInstructions')
                            if hOrder['orderingInstructions'] != ''
                                intOrder[:orderingInstructions] = hOrder['orderingInstructions']
                            end
                        end

                        # order process - turnaround
                        if hOrder.has_key?('turnaround')
                            if hOrder['turnaround'] != ''
                                intOrder[:turnaround] = hOrder['turnaround']
                            end
                        end

                        return intOrder
                    end

                end

            end
        end
    end
end
