# unpack contacts
# Reader - ScienceBase JSON to internal data structure

# History:
#  Stan Smith 2017-09-13 remove fail restriction on contactType
#  Stan Smith 2016-06-21 original script

require 'uuidtools'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_codelists'

module ADIWG
   module Mdtranslator
      module Readers
         module SbJson

            module Contact

               def self.unpackAddress(hSbPrimary, hAddress)

                  if hSbPrimary.has_key?('line1')
                     unless hSbPrimary['line1'].nil? || hSbPrimary['line1'] == ''
                        hAddress[:deliveryPoints] << hSbPrimary['line1']
                     end
                  end
                  if hSbPrimary.has_key?('line2')
                     unless hSbPrimary['line2'].nil? || hSbPrimary['line2'] == ''
                        hAddress[:deliveryPoints] << hSbPrimary['line2']
                     end
                  end

                  if hSbPrimary.has_key?('city')
                     unless hSbPrimary['city'].nil? || hSbPrimary['city'] == ''
                        hAddress[:city] = hSbPrimary['city']
                     end
                  end
                  if hSbPrimary.has_key?('state')
                     unless hSbPrimary['state'].nil? || hSbPrimary['state'] == ''
                        hAddress[:adminArea] = hSbPrimary['state']
                     end
                  end
                  if hSbPrimary.has_key?('zip')
                     unless hSbPrimary['zip'].nil? || hSbPrimary['zip'] == ''
                        hAddress[:postalCode] = hSbPrimary['zip']
                     end
                  end
                  if hSbPrimary.has_key?('country')
                     unless hSbPrimary['country'].nil? || hSbPrimary['country'] == ''
                        hAddress[:country] = hSbPrimary['country']
                     end
                  end

                  return hAddress

               end

               # find the array pointer and type for a contact
               def self.findContact(contactId, aContacts)

                  contactIndex = nil
                  contactType = nil
                  aContacts.each_with_index do |contact, i|
                     if contact[:contactId] == contactId
                        contactIndex = i
                        if contact[:isOrganization]
                           contactType = 'organization'
                        else
                           contactType = 'individual'
                        end
                     end
                  end
                  return contactIndex, contactType

               end

               def self.unpack(hSbJson, aContacts, hCitation, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  if hSbJson.has_key?('contacts')

                     hSbJson['contacts'].each do |hSbContact|

                        hContact = intMetadataClass.newContact

                        hContact[:contactId] = UUIDTools::UUID.random_create.to_s

                        # contact - contactType [ person | organization ]
                        if hSbContact.has_key?('contactType')
                           if hSbContact['contactType'].nil? || hSbContact['contactType'] == ''
                              hResponseObj[:readerExecutionMessages] << 'Contact contactType is missing'
                              hContact[:isOrganization] = false
                           elsif %w(person organization).include?(hSbContact['contactType'])
                              hContact[:isOrganization] = true if hSbContact['contactType'] == 'organization'
                           else
                              hResponseObj[:readerExecutionMessages] << 'Contact contactType must be person or organization'
                              hResponseObj[:readerExecutionPass] = false
                              return nil
                           end
                        else
                           hResponseObj[:readerExecutionMessages] << 'Contact contactType is missing'
                           hContact[:isOrganization] = false
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

                        # primary location
                        if hSbContact.has_key?('primaryLocation')
                           unless hSbContact['primaryLocation'].empty?

                              hPrimary = hSbContact['primaryLocation']

                              # phones
                              if hPrimary.has_key?('officePhone')
                                 unless hPrimary['officePhone'].nil? || hPrimary['officePhone'] == ''
                                    hPhone = intMetadataClass.newPhone
                                    hPhone[:phoneNumber] = hPrimary['officePhone']
                                    hPhone[:phoneServiceTypes] << 'voice'
                                    hContact[:phones] << hPhone
                                 end
                              end
                              if hPrimary.has_key?('faxPhone')
                                 unless hPrimary['faxPhone'].nil? || hPrimary['faxPhone'] == ''
                                    hPhone = intMetadataClass.newPhone
                                    hPhone[:phoneNumber] = hPrimary['faxPhone']
                                    hPhone[:phoneServiceTypes] << 'facsimile'
                                    hContact[:phones] << hPhone
                                 end
                              end
                              if hPrimary.has_key?('ttyPhone')
                                 unless hPrimary['ttyPhone'].nil? || hPrimary['ttyPhone'] == ''
                                    hPhone = intMetadataClass.newPhone
                                    hPhone[:phoneNumber] = hPrimary['ttyPhone']
                                    hPhone[:phoneServiceTypes] << 'tty'
                                    hContact[:phones] << hPhone
                                 end
                              end

                              # street address
                              if hPrimary.has_key?('streetAddress')
                                 unless hPrimary['streetAddress'].empty?
                                    hAddress = intMetadataClass.newAddress
                                    hAddress[:addressTypes] << 'physical'

                                    if hPrimary.has_key?('name')
                                       unless hPrimary['name'].nil? || hPrimary['name'] == ''
                                          hAddress[:description] = hPrimary['name']
                                       end
                                    end

                                    hContact[:addresses] << unpackAddress(hPrimary['streetAddress'], hAddress)
                                 end
                              end

                              # mailing address
                              if hPrimary.has_key?('mailAddress')
                                 unless hPrimary['mailAddress'].empty?
                                    hAddress = intMetadataClass.newAddress
                                    hAddress[:addressTypes] << 'mailing'

                                    if hPrimary.has_key?('name')
                                       unless hPrimary['name'].nil? || hPrimary['name'] == ''
                                          hAddress[:description] = hPrimary['name']
                                       end
                                    end

                                    hContact[:addresses] << unpackAddress(hPrimary['mailAddress'], hAddress)
                                 end
                              end


                           end
                        end

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

                        # add contact to resource citation
                        hResponsibility = intMetadataClass.newResponsibility
                        roleType = Codelists.codelist_sb2adiwg('role_sb2adiwg', hContact[:contactType])
                        roleType = hContact[:contactType] if roleType.nil?
                        hResponsibility[:roleName] = roleType
                        hParty = intMetadataClass.newParty
                        aReturn = findContact(hContact[:contactId], aContacts)
                        hParty[:contactId] = hContact[:contactId]
                        hParty[:contactIndex] = aReturn[0]
                        hParty[:contactType] = aReturn[1]
                        hResponsibility[:parties] << hParty
                        hCitation[:responsibleParties] << hResponsibility

                     end

                  end

                  return aContacts

               end

            end

         end
      end
   end
end
