# unpack contact
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2016-10-23 original script

require_relative 'module_onlineResource'
require_relative 'module_phone'
require_relative 'module_address'
require_relative 'module_graphic'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module Contact

               def self.unpack(hContact, responseObj)


                  # return nil object if input is empty
                  if hContact.empty?
                     responseObj[:readerExecutionMessages] << 'Contact object is empty'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intContact = intMetadataClass.newContact

                  # contact - contact id (required)
                  if hContact.has_key?('contactId')
                     intContact[:contactId] = hContact['contactId']
                  end
                  if intContact[:contactId].nil? || intContact[:contactId] == ''
                     responseObj[:readerExecutionMessages] << 'Contact is missing contactId'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # contact - is organization (required)
                  if hContact.has_key?('isOrganization')
                     if hContact['isOrganization'] === true
                        intContact[:isOrganization] = true
                     end
                  end

                  # contact - position name
                  if hContact.has_key?('positionName')
                     if hContact['positionName'] != ''
                        intContact[:positionName] = hContact['positionName']
                     end
                  end

                  # contact - name (required if ...)
                  # ... isOrganization = true
                  # ... isOrganization = false && positionName = nil
                  if hContact.has_key?('name')
                     if hContact['name'] != ''
                        intContact[:name] = hContact['name']
                     end
                  end
                  if intContact[:name].nil? || intContact[:name] == ''
                     if intContact[:isOrganization] === true
                        responseObj[:readerExecutionMessages] << 'Organization contact is missing name'
                        responseObj[:readerExecutionPass] = false
                        return nil
                     end
                     if intContact[:positionName].nil? || intContact[:positionName] == ''
                        responseObj[:readerExecutionMessages] << 'Individual contact is missing name and position'
                        responseObj[:readerExecutionPass] = false
                        return nil
                     end
                  end

                  # contact - member of organization []
                  if hContact.has_key?('memberOfOrganization')
                     hContact['memberOfOrganization'].each do |item|
                        if item != ''
                           intContact[:memberOfOrgs] << item
                        end
                     end
                  end

                  # contact - logo graphic [graphic]
                  if hContact.has_key?('logoGraphic')
                     aItems = hContact['logoGraphic']
                     aItems.each do |item|
                        hReturn = Graphic.unpack(item, responseObj)
                        unless hReturn.nil?
                           intContact[:logos] << hReturn
                        end
                     end
                  end

                  # contact - phone [phone]
                  if hContact.has_key?('phone')
                     aItems = hContact['phone']
                     aItems.each do |item|
                        hReturn = Phone.unpack(item, responseObj)
                        unless hReturn.nil?
                           intContact[:phones] << hReturn
                        end
                     end
                  end

                  # contact - address [address]
                  if hContact.has_key?('address')
                     aItems = hContact['address']
                     aItems.each do |item|
                        hReturn = Address.unpack(item, responseObj)
                        unless hReturn.nil?
                           intContact[:addresses] << hReturn
                        end
                     end
                  end

                  # contact - electronic mail addresses []
                  if hContact.has_key?('electronicMailAddress')
                     hContact['electronicMailAddress'].each do |item|
                        if item != ''
                           intContact[:eMailList] << item
                        end
                     end
                  end

                  # contact - online resource [onlineResource]
                  if hContact.has_key?('onlineResource')
                     aItems = hContact['onlineResource']
                     aItems.each do |item|
                        hReturn = OnlineResource.unpack(item, responseObj)
                        unless hReturn.nil?
                           intContact[:onlineResources] << hReturn
                        end
                     end
                  end

                  # contact - hours of service []
                  if hContact.has_key?('hoursOfService')
                     hContact['hoursOfService'].each do |item|
                        if item != ''
                           intContact[:hoursOfService] << item
                        end
                     end
                  end

                  # contact - contact instructions
                  if hContact.has_key?('contactInstructions')
                     if hContact['contactInstructions'] != ''
                        intContact[:contactInstructions] = hContact['contactInstructions']
                     end
                  end

                  # contact - contact type
                  if hContact.has_key?('contactType')
                     if hContact['contactType'] != ''
                        intContact[:contactType] = hContact['contactType']
                     end
                  end

                  return intContact

               end

            end

         end
      end
   end
end
