# unpack funding
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2016-10-30 original script

require_relative 'module_allocation'
require_relative 'module_timePeriod'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Funding

                    def self.unpack(hFunding, responseObj)

                        # return nil object if input is empty
                        if hFunding.empty?
                            responseObj[:readerExecutionMessages] << 'Funding object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intFunding = intMetadataClass.newFunding

                        # funding - allocation []
                        if hFunding.has_key?('allocation')
                            aItems = hFunding['allocation']
                            aItems.each do |item|
                                hReturn = Allocation.unpack(item, responseObj)
                                unless hReturn.nil?
                                    intFunding[:allocations] << hReturn
                                end
                            end
                        end

                        # funding - timePeriod
                        if hFunding.has_key?('timePeriod')
                            hObject = hFunding['timePeriod']
                            unless hObject.empty?
                                hReturn = TimePeriod.unpack(hObject, responseObj)
                                unless hReturn.nil?
                                    intFunding[:timePeriod] = hReturn
                                end
                            end
                        end

                        if intFunding[:allocations].empty? && intFunding[:timePeriod].empty?
                            responseObj[:readerExecutionMessages] << 'Funding must have either an allocation or timePeriod'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        return intFunding

                    end

                end

            end
        end
    end
end
