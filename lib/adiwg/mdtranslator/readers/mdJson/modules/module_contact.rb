# unpack contact
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-17 refactored error and warning messaging
#  Stan Smith 2016-10-23 original script

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

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hContact.empty?
                     @MessagePath.issueWarning(100, responseObj)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intContact = intMetadataClass.newContact

                  outContext = nil

                  # contact - contact id (required)
                  if hContact.has_key?('contactId')
                     if hContact['contactId'].is_a?(Hash)
                        outContext = 'contact ID ' + hContact['contactId']['identifier']
                        intContact[:contactId] = hContact['contactId'].transform_keys(&:to_sym)
                     elsif hContact['contactId'].is_a?(String)
                        outContext = 'contact ID ' + hContact['contactId']
                        intContact[:contactId] = hContact['contactId']
                     end
                  end
                  if intContact[:contactId].nil? || intContact[:contactId] == ''
                     @MessagePath.issueError(101, responseObj)
                  end

                  # contact - is organization (required)
                  if hContact.has_key?('isOrganization')
                     if hContact['isOrganization'] === true
                        intContact[:isOrganization] = true
                     end
                  end

                  # contact - position name
                  if hContact.has_key?('positionName')
                     unless hContact['positionName'] == ''
                        intContact[:positionName] = hContact['positionName']
                     end
                  end

                  # contact - name (required if ...)
                  # ... isOrganization = true
                  # ... isOrganization = false && positionName = nil
                  if hContact.has_key?('name')
                     unless hContact['name'] == ''
                        intContact[:name] = hContact['name']
                     end
                  end
                  if intContact[:name].nil? || intContact[:name] == ''
                     if intContact[:isOrganization] === true
                        @MessagePath.issueError(102, responseObj, outContext)
                     else
                        if intContact[:positionName].nil? || intContact[:positionName] == ''
                           @MessagePath.issueError(103, responseObj, outContext)
                        end
                     end
                  end

                  # contact - member of organization []
                  if hContact.has_key?('memberOfOrganization')
                     hContact['memberOfOrganization'].each do |item|
                        unless item == ''
                           intContact[:memberOfOrgs] << item
                        end
                     end
                  end

                  # contact - logo graphic [graphic]
                  if hContact.has_key?('logoGraphic')
                     aItems = hContact['logoGraphic']
                     aItems.each do |item|
                        hReturn = Graphic.unpack(item, responseObj, outContext)
                        unless hReturn.nil?
                           intContact[:logos] << hReturn
                        end
                     end
                  end

                  # contact - phone [phone]
                  if hContact.has_key?('phone')
                     aItems = hContact['phone']
                     aItems.each do |item|
                        hReturn = Phone.unpack(item, responseObj, outContext)
                        unless hReturn.nil?
                           intContact[:phones] << hReturn
                        end
                     end
                  end

                  # contact - address [address]
                  if hContact.has_key?('address')
                     aItems = hContact['address']
                     aItems.each do |item|
                        hReturn = Address.unpack(item, responseObj, outContext)
                        unless hReturn.nil?
                           intContact[:addresses] << hReturn
                        end
                     end
                  end

                  # contact - electronic mail addresses []
                  if hContact.has_key?('electronicMailAddress')
                     hContact['electronicMailAddress'].each do |item|
                        unless item == ''
                           intContact[:eMailList] << item
                        end
                     end
                  end

                  # contact - online resource [onlineResource]
                  if hContact.has_key?('onlineResource')
                     aItems = hContact['onlineResource']
                     aItems.each do |item|
                        hReturn = OnlineResource.unpack(item, responseObj, outContext)
                        unless hReturn.nil?
                           intContact[:onlineResources] << hReturn
                        end
                     end
                  end

                  # contact - hours of service []
                  if hContact.has_key?('hoursOfService')
                     hContact['hoursOfService'].each do |item|
                        unless item == ''
                           intContact[:hoursOfService] << item
                        end
                     end
                  end

                  # contact - contact instructions
                  if hContact.has_key?('contactInstructions')
                     unless hContact['contactInstructions'] == ''
                        intContact[:contactInstructions] = hContact['contactInstructions']
                     end
                  end

                  # contact - contact type
                  if hContact.has_key?('contactType')
                     unless hContact['contactType'] == ''
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
