# unpack address
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2016-10-03 original script

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Address

                    def self.unpack(hAddress, responseObj)

                        # return nil object if input is empty
                        if hAddress.empty?
                            responseObj[:readerExecutionMessages] << 'Address object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intAdd = intMetadataClass.newAddress

                        # address - delivery point
                        if hAddress.has_key?('deliveryPoint')
                            aDevPoint = hAddress['deliveryPoint']
                            aDevPoint.each do |addLine|
                                if addLine != ''
                                    intAdd[:deliveryPoints] << addLine
                                end
                            end
                        end

                        # address - city
                        if hAddress.has_key?('city')
                            s = hAddress['city']
                            if s != ''
                                intAdd[:city] = s
                            end
                        end

                        # address - admin area
                        if hAddress.has_key?('administrativeArea')
                            s = hAddress['administrativeArea']
                            if s != ''
                                intAdd[:adminArea] = s
                            end
                        end

                        # address - postal code
                        if hAddress.has_key?('postalCode')
                            s = hAddress['postalCode']
                            if s != ''
                                intAdd[:postalCode] = s
                            end
                        end

                        # address - country
                        if hAddress.has_key?('country')
                            s = hAddress['country']
                            if s != ''
                                intAdd[:country] = s
                            end
                        end

                        # address - email
                        if hAddress.has_key?('electronicMailAddress')
                            eMailList = hAddress['electronicMailAddress']
                            eMailList.each do |email|
                                if email != ''
                                    intAdd[:eMailList] << email
                                end
                            end
                        end

                        return intAdd
                    end

                end

            end
        end
    end
end
