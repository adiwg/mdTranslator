# unpack address
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-13 refactored error and warning messaging
#  Stan Smith 2016-10-03 refactored for mdJson 2.0
#  Stan Smith 2015-07-14 refactored to remove global namespace constants
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#  Stan Smith 2014-12-30 refactored
#  ... electronicMailAddresses into internal object
#  Stan Smith 2014-12-19 prevented passing blank deliveryPoints and
#  Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#  Stan Smith 2013-10-21 original script

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module Address

               def self.unpack(hAddress, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hAddress.empty?
                     @MessagePath.issueWarning(10, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intAdd = intMetadataClass.newAddress

                  # address - address type [adiwg_addressType] (required)
                  if hAddress.has_key?('addressType')
                     hAddress['addressType'].each do |item|
                        unless item == ''
                           intAdd[:addressTypes] << item
                        end
                     end
                  end
                  if intAdd[:addressTypes].empty?
                     @MessagePath.issueError(11, responseObj, inContext)
                  end

                  # address - description
                  if hAddress.has_key?('description')
                     unless hAddress['description'] == ''
                        intAdd[:description] = hAddress['description']
                     end
                  end

                  # address - delivery point
                  if hAddress.has_key?('deliveryPoint')
                     hAddress['deliveryPoint'].each do |item|
                        unless item == ''
                           intAdd[:deliveryPoints] << item
                        end
                     end
                  end

                  # address - city
                  if hAddress.has_key?('city')
                     unless hAddress['city'] == ''
                        intAdd[:city] = hAddress['city']
                     end
                  end

                  # address - admin area
                  if hAddress.has_key?('administrativeArea')
                     unless hAddress['administrativeArea'] == ''
                        intAdd[:adminArea] = hAddress['administrativeArea']
                     end
                  end

                  # address - postal code
                  if hAddress.has_key?('postalCode')
                     unless hAddress['postalCode'] == ''
                        intAdd[:postalCode] = hAddress['postalCode']
                     end
                  end

                  # address - country
                  if hAddress.has_key?('country')
                     unless hAddress['country'] == ''
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
