# unpack allocation
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2016-10-30 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_citation')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Allocation

                    def self.unpack(hAlloc, responseObj)

                        # return nil object if input is empty
                        if hAlloc.empty?
                            responseObj[:readerExecutionMessages] << 'Allocation object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intAlloc = intMetadataClass.newAllocation

                        # allocation - amount
                        if hAlloc.has_key?('amount')
                            if hAlloc['amount'] != ''
                                intAlloc[:amount] = hAlloc['amount']
                            end
                        end

                        # allocation - currency
                        if hAlloc.has_key?('currency')
                            if hAlloc['currency'] != ''
                                intAlloc[:currency] = hAlloc['currency']
                            end
                        end

                        # allocation - source
                        if hAlloc.has_key?('source')
                            if hAlloc['source'] != ''
                                intAlloc[:sourceId] = hAlloc['source']
                            end
                        end

                        # allocation - recipient
                        if hAlloc.has_key?('recipient')
                            if hAlloc['recipient'] != ''
                                intAlloc[:recipientId] = hAlloc['recipient']
                            end
                        end

                        # allocation - matching {Boolean}
                        if hAlloc.has_key?('matching')
                            if hAlloc['matching'] === true
                                intAlloc[:matching] = hAlloc['matching']
                            end
                        end

                        # allocation - comment
                        if hAlloc.has_key?('comment')
                            if hAlloc['comment'] != ''
                                intAlloc[:comment] = hAlloc['comment']
                            end
                        end

                        return intAlloc

                    end

                end

            end
        end
    end
end
