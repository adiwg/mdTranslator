# unpack maintenance
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2016-10-23 original script

require_relative 'module_date'
require_relative 'module_responsibleParty'
require_relative 'module_scope'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Maintenance

                    def self.unpack(hMaint, responseObj)


                        # return nil object if input is empty
                        if hMaint.empty?
                            responseObj[:readerExecutionMessages] << 'Resource Maintenance object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intMaint = intMetadataClass.newMaintenance

                        # maintenance - frequency (required)
                        if hMaint.has_key?('frequency')
                            intMaint[:frequency] = hMaint['frequency']
                        end
                        if intMaint[:frequency].nil? || intMaint[:frequency] == ''
                            responseObj[:readerExecutionMessages] << 'Resource Maintenance attribute frequency is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # maintenance - date []
                        if hMaint.has_key?('date')
                            aItems = hMaint['date']
                            aItems.each do |item|
                                hReturn = Date.unpack(item, responseObj)
                                unless hReturn.nil?
                                    intMaint[:dates] << hReturn
                                end
                            end
                        end

                        # maintenance - scope []
                        if hMaint.has_key?('scope')
                            aItems = hMaint['scope']
                            aItems.each do |item|
                                hReturn = Scope.unpack(item, responseObj)
                                unless hReturn.nil?
                                    intMaint[:scopes] << hReturn
                                end
                            end
                        end

                        # maintenance - note []
                        if hMaint.has_key?('note')
                            hMaint['note'].each do |item|
                                if item != ''
                                    intMaint[:notes] << item
                                end
                            end
                        end

                        # maintenance - contact []
                        if hMaint.has_key?('contact')
                            aItems = hMaint['contact']
                            aItems.each do |item|
                                hReturn = ResponsibleParty.unpack(item, responseObj)
                                unless hReturn.nil?
                                    intMaint[:contacts] << hReturn
                                end
                            end
                        end

                        return intMaint

                    end

                end

            end
        end
    end
end
