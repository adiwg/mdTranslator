# unpack phone
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-02-19 refactored error and warning messaging
#  Stan Smith 2016-10-02 phone service is now an array rather than creating individual phone records per service
#  Stan Smith 2016-10-02 refactored for mdJson 2.0.0
#  Stan Smith 2015-07-14 refactored to remove global namespace constants
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#  Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#  Stan Smith 2014-12-09 return empty phone object if no phone number
#  Stan Smith 2014-05-14 combine phone service types
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
                     responseObj[:readerExecutionMessages] << 'WARNING: mdJson reader: phone object is empty'
                     return nil
                  end

                  # phone - phoneNumber (required)
                  # return nil if no phone number is provided
                  if hPhone.has_key?('phoneNumber')
                     intPhone[:phoneNumber] = hPhone['phoneNumber']
                  end
                  if hPhone['phoneNumber'].nil? || hPhone['phoneNumber'] == ''
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson reader: phone number is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # phone - phoneName
                  if hPhone.has_key?('phoneName')
                     unless hPhone['phoneName'] == ''
                        intPhone[:phoneName] = hPhone['phoneName']
                     end
                  end

                  # phone - service (recommended)
                  if hPhone.has_key?('service')
                     intPhone[:phoneServiceTypes] = hPhone['service']
                  end
                  if intPhone[:phoneServiceTypes].empty?
                     responseObj[:readerExecutionMessages] << 'WARNING: mdJson reader: phone service type is missing'
                  end

                  return intPhone
               end
            end

         end
      end
   end
end
