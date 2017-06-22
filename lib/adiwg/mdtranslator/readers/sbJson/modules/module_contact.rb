# unpack contacts
# Reader - ScienceBase JSON to internal data structure

# History:
#   Stan Smith 2016-06-21 original script

require 'uuidtools'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module SbJson

            module Contact

               def self.unpack(hSbJson, aContacts, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  if hSbJson.has_key?('contacts')

                     hSbJson['contacts'].each do |hSbContact|

                        hContact = intMetadataClass.newContact

                        hContact[:contactId] = UUIDTools::UUID.random_create.to_s

                        # contact - contactType (required) [ person | organization ]
                        if hSbContact.has_key?('contactType')
                           if %w(person organization).include?(hSbContact['contactType'])
                              hContact[:isOrganization] = true if hSbContact['contactType'] == 'organization'
                           else
                              hResponseObj[:readerExecutionMessages] << 'Contact contactType must be person or organization'
                              hResponseObj[:readerExecutionPass] = false
                              return nil
                           end
                        end
                        if hSbContact['contactType'].nil? || hSbContact['contactType'] == ''
                           hResponseObj[:readerExecutionMessages] << 'Contact contactType is missing'
                           hResponseObj[:readerExecutionPass] = false
                           return nil
                        end

                        # contact - name (required)
                        if hSbContact.has_key?('name')
                           hContact[:name] = hSbContact['name']
                        end
                        if hSbContact['name'].nil? || hSbContact['name'] == ''
                           hResponseObj[:readerExecutionMessages] << 'Contact name is missing'
                           hResponseObj[:readerExecutionPass] = false
                           return nil
                        end

                        if hSbContact.has_key?('jobTitle')
                           unless hSbContact['jobTitle'].nil? || hSbContact['jobTitle'] == ''
                              hContact[:positionName] = hSbContact['jobTitle']
                           end
                        end

                        # logos
                        if hSbContact.has_key?('logoUrl')
                           unless hSbContact['logoUrl'].nil? || hSbContact['logoUrl'] == ''
                              hGraphic = intMetadataClass.newGraphic
                              hOlRes = intMetadataClass.newOnlineResource
                              hGraphic[:graphicName] = 'logoUrl'
                              hOlRes[:olResURI] = hSbContact['logoUrl']
                              hGraphic[:graphicURI] << hOlRes
                              hContact[:logos] << hGraphic
                           end
                        end
                        if hSbContact.has_key?('smallLogoUrl')
                           unless hSbContact['smallLogoUrl'].nil? || hSbContact['smallLogoUrl'] == ''
                              hGraphic = intMetadataClass.newGraphic
                              hOlRes = intMetadataClass.newOnlineResource
                              hGraphic[:graphicName] = 'smallLogoUrl'
                              hOlRes[:olResURI] = hSbContact['smallLogoUrl']
                              hGraphic[:graphicURI] << hOlRes
                              hContact[:logos] << hGraphic
                           end
                        end

                        # phones
                        if hSbContact.has_key?('officePhone')
                           unless hSbContact['officePhone'].nil? || hSbContact['officePhone'] == ''
                              hPhone = intMetadataClass.newPhone
                              hPhone[:phoneNumber] = hSbContact['officePhone']
                              hPhone[:phoneServiceTypes] << 'voice'
                              hContact[:phones] << hPhone
                           end
                        end
                        if hSbContact.has_key?('faxPhone')
                           unless hSbContact['faxPhone'].nil? || hSbContact['faxPhone'] == ''
                              hPhone = intMetadataClass.newPhone
                              hPhone[:phoneNumber] = hSbContact['faxPhone']
                              hPhone[:phoneServiceTypes] << 'facsimile'
                              hContact[:phones] << hPhone
                           end
                        end
                        if hSbContact.has_key?('ttyPhone')
                           unless hSbContact['ttyPhone'].nil? || hSbContact['ttyPhone'] == ''
                              hPhone = intMetadataClass.newPhone
                              hPhone[:phoneNumber] = hSbContact['ttyPhone']
                              hPhone[:phoneServiceTypes] << 'tty'
                              hContact[:phones] << hPhone
                           end
                        end

                        # address
                        # TODO branch to primary location

                        # email / hours of service / contact instructions
                        if hSbContact.has_key?('email')
                           unless hSbContact['email'].nil? || hSbContact['email'] == ''
                              hContact[:eMailList] << hSbContact['email']
                           end
                        end
                        if hSbContact.has_key?('hours')
                           unless hSbContact['hours'].nil? || hSbContact['hours'] == ''
                              hContact[:hoursOfService] << hSbContact['hours']
                           end
                        end
                        if hSbContact.has_key?('instructions')
                           unless hSbContact['instructions'].nil? || hSbContact['instructions'] == ''
                              hContact[:contactInstructions] = hSbContact['instructions']
                           end
                        end

                        # contact - type (required)
                        if hSbContact.has_key?('type')
                           hContact[:contactType] = hSbContact['type']
                        end
                        if hSbContact['type'].nil? || hSbContact['type'] == ''
                           hResponseObj[:readerExecutionMessages] << 'Contact type is missing'
                           hResponseObj[:readerExecutionPass] = false
                           return nil
                        end

                        # member of organization
                        hContactOrg = {}
                        if hSbContact.has_key?('organization')
                           if hSbContact['organization'].has_key?('displayText')
                              sbText = hSbContact['organization']['displayText']
                              unless sbText.nil? || sbText == ''
                                 hContactOrg = intMetadataClass.newContact
                                 hContactOrg[:contactId] = UUIDTools::UUID.random_create.to_s
                                 hContactOrg[:isOrganization] = true
                                 hContactOrg[:name] = sbText
                                 hContact[:memberOfOrgs] << hContactOrg[:contactId]
                              end
                           end
                        end

                        aContacts << hContact
                        aContacts << hContactOrg unless hContactOrg.empty?

                     end

                  end

                  return aContacts

               end

            end

         end
      end
   end
end