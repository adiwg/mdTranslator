# Reader - fgdc to internal data structure
# unpack fgdc contact

# History:
#  Stan Smith 2017-11-27 add support for 'memberOfOrgs'
#  Stan Smith 2017-08-25 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_fgdc'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module Contact

               def self.add_phone(hContact, number, type)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  # test if phone number already exists for this contact
                  hPhone = intMetadataClass.newPhone
                  newPhone = true
                  hContact[:phones].each do |hOld|
                     if hOld[:phoneNumber] == number
                        newPhone = false
                        hPhone = hOld
                     end
                  end
                  if newPhone
                     hContact[:phones] << hPhone
                  end
                  hPhone[:phoneNumber] = number
                  unless hPhone[:phoneServiceTypes].include?(type)
                     hPhone[:phoneServiceTypes] << type
                  end

               end

               def self.unpack(xContact, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  # contact 10 (cntinfo) - contact information
                  contactType = nil
                  personName = ''
                  orgName = ''
                  personId = nil
                  orgId = nil
                  xContactInfo = xContact.xpath('./cntinfo')
                  unless xContactInfo.empty?

                     # contact 10.1 (cntperp) - contact person primary
                     xPerson = xContactInfo.xpath('./cntperp')
                     unless xPerson.empty?
                        contactType = 'person'

                        # person primary 10.1.1 (cntper) - name of person
                        # person primary 10.1.2 (cntorg) - name of organization
                        personName = xPerson.xpath('./cntper').text
                        orgName = xPerson.xpath('./cntorg').text

                     end

                     # contact 10.2 (cntorgp) - contact organization primary
                     xOrg = xContactInfo.xpath('./cntorgp')
                     unless xOrg.empty?
                        contactType = 'organization'

                        # organization primary 10.1.1 (cntper) - name of person
                        # organization primary 10.1.2 (cntorg) - name of organization
                        personName = xOrg.xpath('./cntper').text
                        orgName = xOrg.xpath('./cntorg').text

                     end

                     # error handling
                     if contactType.nil?
                        hResponseObj[:readerExecutionMessages] << 'ERROR: FGDC contact is neither person or organization'
                        return nil
                     end
                     if contactType == 'person' && personName == ''
                        hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: contact person name is missing'
                     end
                     if contactType == 'organization' && orgName == ''
                        hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: contact organization name is missing'
                     end

                     # add new contacts to contact array
                     unless contactType.nil?
                        personId = Fgdc.add_contact(personName, false) unless personName.empty?
                        orgId = Fgdc.add_contact(orgName, true) unless orgName.empty?
                        hContact = Fgdc.get_contact_by_id(personId) if contactType == 'person'
                        hContact = Fgdc.get_contact_by_id(orgId) if contactType == 'organization'

                        # CAUTION: the contact being processed may have been added previously.
                        # check that addresses, phones, emails, org members, hours of service
                        # were not previous defined for this contact.

                        # contact - member of organization
                        if contactType == 'person'
                           unless orgId.nil?
                              unless hContact.include?(orgId)
                                 hContact[:memberOfOrgs] << orgId
                              end
                           end
                        end

                        # contact 10.3 (cntpos) - contact position
                        position = xContactInfo.xpath('./cntpos').text
                        if contactType == 'person'
                           hContact[:positionName] = position
                        end

                        # contact 10.4 (cntaddr) - contact address [] (required)
                        axAddress = xContactInfo.xpath('./cntaddr')
                        unless axAddress.empty?
                           axAddress.each do |xAddress|
                              hAddress = intMetadataClass.newAddress

                              # address 10.4.1 (addrtype) - address type (required)
                              addType = xAddress.xpath('./addrtype').text
                              hAddress[:addressTypes] << addType unless addType.empty?
                              if addType.empty?
                                 hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: contact address type is missing'
                              end

                              # address 10.4.2 (address) - address lines []
                              axAddLines = xAddress.xpath('./address')
                              unless axAddLines.empty?
                                 axAddLines.each do |xLine|
                                    addLine = xLine.text
                                    hAddress[:deliveryPoints] << addLine unless addLine.empty?
                                 end
                              end

                              # address 10.4.3 (city) - city (required)
                              city = xAddress.xpath('./city').text
                              hAddress[:city] = city unless city.empty?
                              if city.empty?
                                 hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: contact address city is missing'
                              end

                              # address 10.4.4 (state) - state (required)
                              state = xAddress.xpath('./state').text
                              hAddress[:adminArea] = state unless state.empty?
                              if state.empty?
                                 hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: contact address state is missing'
                              end

                              # address 10.4.5 (postal) - postal code (required)
                              postal = xAddress.xpath('./postal').text
                              hAddress[:postalCode] = postal unless postal.empty?
                              if postal.empty?
                                 hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: contact address zip code is missing'
                              end

                              # address 10.4.6 (country) - country
                              country = xAddress.xpath('./country').text
                              hAddress[:country] = country unless country.empty?

                              # test if new address before adding to contact
                              saveAddress = true
                              hContact[:addresses].each do |hOld|
                                 isSame = true
                                 isSame = false unless hAddress[:deliveryPoints].length == hOld[:deliveryPoints].length
                                 if hAddress[:deliveryPoints].length == hOld[:deliveryPoints].length
                                    (1..hAddress[:deliveryPoints].length).each do |x|
                                       isSame = false unless hAddress[:deliveryPoints][x] == hOld[:deliveryPoints][x]
                                    end
                                 end
                                 isSame = false unless hAddress[:city] == hOld[:city]
                                 isSame = false unless hAddress[:adminArea] == hOld[:adminArea]
                                 isSame = false unless hAddress[:postalCode] == hOld[:postalCode]
                                 isSame = false unless hAddress[:country] == hOld[:country]
                                 if isSame
                                    saveAddress = false
                                    break
                                 end
                              end

                              hContact[:addresses] << hAddress if saveAddress

                           end
                        end
                        if axAddress.empty?
                           hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: contact address is missing'
                        end

                        # contact 10.5 (cntvoice) - contact voice phone number [] (required)
                        axVoice = xContactInfo.xpath('./cntvoice')
                        unless axVoice.empty?
                           axVoice.each do |xPhone|
                              phone = xPhone.text
                              unless phone.empty?
                                 add_phone(hContact, phone, 'voice')
                              end
                           end
                        end
                        if axVoice.empty?
                           hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: contact voice phone is missing'
                        end

                        # contact 10.6 (cnttdd) - contact TDD/TTY phone number []
                        axTDD = xContactInfo.xpath('./cnttdd')
                        unless axTDD.empty?
                           axTDD.each do |xPhone|
                              phone = xPhone.text
                              unless phone.empty?
                                 add_phone(hContact, phone, 'tty')
                              end
                           end
                        end

                        # contact 10.7 (cntfax) - contact fax phone number []
                        axFax = xContactInfo.xpath('./cntfax')
                        unless axFax.empty?
                           axFax.each do |xPhone|
                              phone = xPhone.text
                              unless phone.empty?
                                 add_phone(hContact, phone, 'facsimile')
                              end
                           end
                        end

                        # contact 10.8 (cntemail) - contact email address []
                        axEmail = xContactInfo.xpath('./cntemail')
                        unless axEmail.empty?
                           axEmail.each do |xEmail|
                              email = xEmail.text
                              unless email.empty?
                                 unless hContact[:eMailList].include?(email)
                                    hContact[:eMailList] << email
                                 end
                              end
                           end
                        end

                        # contact 10.9 (hours) - hours of service
                        hours = xContactInfo.xpath('./hours').text
                        unless hours.empty?
                           unless hContact[:hoursOfService].include?(hours)
                              hContact[:hoursOfService] << hours
                           end
                        end

                        # contact 10.10 (cntinst) - contact instructions
                        instruct = xContactInfo.xpath('./cntinst').text
                        hContact[:contactInstructions] = instruct unless instruct.empty?

                        Fgdc.set_contact(hContact)

                        # setup responsibility object
                        # let routine that called this module set responsibility roleName
                        hResponsibility = intMetadataClass.newResponsibility
                        hParty = intMetadataClass.newParty
                        hParty[:contactId] = hContact[:contactId]
                        aContact = Fgdc.find_contact_by_id(hContact[:contactId])
                        hParty[:contactIndex] = aContact[0]
                        hParty[:contactType] = aContact[1]
                        hResponsibility[:parties] << hParty

                        return hResponsibility

                     end
                  end

                  return nil

               end

            end

         end
      end
   end
end
