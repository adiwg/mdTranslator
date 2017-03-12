# unpack address
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2016-10-03 refactored for mdJson 2.0
#   Stan Smith 2015-07-14 refactored to remove global namespace constants
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2014-12-30 refactored
#   ... electronicMailAddresses into internal object
#   Stan Smith 2014-12-19 prevented passing blank deliveryPoints and
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2013-10-21 original script

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

                        # address - address type [adiwg_addressType] (required)
                        if hAddress.has_key?('addressType')
                            hAddress['addressType'].each do |item|
                                if item != ''
                                    intAdd[:addressTypes] << item
                                end
                            end
                        end
                        if intAdd[:addressTypes].empty?
                            responseObj[:readerExecutionMessages] << 'Address Type is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # address - description
                        if hAddress.has_key?('description')
                            if hAddress['description'] != ''
                                intAdd[:description] = hAddress['description']
                            end
                        end

                        # address - delivery point
                        if hAddress.has_key?('deliveryPoint')
                            hAddress['deliveryPoint'].each do |item|
                                if item != ''
                                    intAdd[:deliveryPoints] << item
                                end
                            end
                        end

                        # address - city
                        if hAddress.has_key?('city')
                            if hAddress['city'] != ''
                                intAdd[:city] = hAddress['city']
                            end
                        end

                        # address - admin area
                        if hAddress.has_key?('administrativeArea')
                            if hAddress['administrativeArea'] != ''
                                intAdd[:adminArea] = hAddress['administrativeArea']
                            end
                        end

                        # address - postal code
                        if hAddress.has_key?('postalCode')
                            if hAddress['postalCode'] != ''
                                intAdd[:postalCode] = hAddress['postalCode']
                            end
                        end

                        # address - country
                        if hAddress.has_key?('country')
                            if hAddress['country'] != ''
                                intAdd[:country] = hAddress['country']
                            end
                        end

                        return intAdd

                    end

                end

            end
        end
    end
end
