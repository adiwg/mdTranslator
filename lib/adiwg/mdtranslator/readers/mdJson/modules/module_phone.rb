# unpack phone
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2016-10-02 phone service is now an array rather than creating individual phone records per service
#   Stan Smith 2016-10-02 refactored for mdJson 2.0.0
#   Stan Smith 2015-07-14 refactored to remove global namespace constants
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2014-12-09 return empty phone object if no phone number
#   Stan Smith 2014-05-14 combine phone service types
# 	Stan Smith 2013-12-16 original script

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Phone

                    def self.unpack(hPhone, responseObj)

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intPhone = intMetadataClass.newPhone

                        if hPhone.empty?
                            responseObj[:readerExecutionMessages] << 'Phone object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # phone - phoneNumber
                        # return nil if no phone number is provided
                        if hPhone.has_key?('phoneNumber')
                            intPhone[:phoneNumber] = hPhone['phoneNumber']
                            if hPhone['phoneNumber'] == ''
                                responseObj[:readerExecutionMessages] << 'Phone object did not provide a phone number'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        else
                            responseObj[:readerExecutionMessages] << 'Phone object did not provide a phone number'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # phone - phoneName
                        if hPhone.has_key?('phoneName')
                            intPhone[:phoneName] = hPhone['phoneName']
                        end

                        # phone - service
                        if hPhone.has_key?('service')
                            intPhone[:phoneServiceTypes] = hPhone['service']
                            if hPhone['service'].length == 0
                                responseObj[:readerExecutionMessages] << 'Phone object did not provide a service'
                                responseObj[:readerExecutionPass] = true
                            end
                        else
                            responseObj[:readerExecutionMessages] << 'Phone object did not provide a service'
                            responseObj[:readerExecutionPass] = true
                        end

                        return intPhone
                    end
                end

            end
        end
    end
end
