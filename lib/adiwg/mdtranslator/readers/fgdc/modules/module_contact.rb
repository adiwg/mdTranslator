# Reader - fgdc to internal data structure
# unpack fgdc contact

# History:
#  Stan Smith 2017-08-25 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_fgdc'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module Contact

               def self.unpack(xContact, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  # contact 10 (cntinfo) - contact information
                  contactType = nil
                  personName = ''
                  orgName = ''
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
                        return nil if personName.empty?

                     end

                     # contact 10.2 (cntorgp) - contact organization primary
                     xOrg = xContactInfo.xpath('./cntorgp')
                     unless xOrg.empty?
                        contactType = 'organization'

                        # organization primary 10.1.1 (cntper) - name of person
                        # organization primary 10.1.2 (cntorg) - name of organization
                        personName = xOrg.xpath('./cntper').text
                        orgName = xOrg.xpath('./cntorg').text
                        return nil if orgName.empty?

                     end

                     # add new contacts to contact array
                     unless contactType.nil?
                        personId = Fgdc.add_contact(personName, false) unless personName.empty?
                        orgId = Fgdc.add_contact(orgName, true) unless orgName.empty?
                        hContact = Fgdc.get_contact_by_id(personId) if contactType == 'person'
                        hContact = Fgdc.get_contact_by_id(orgId) if contactType == 'organization'

                        # contact 10.3 (cntpos) - contact position
                        position = xContactInfo.xpath('./cntpos').text
                        if contactType == 'person'
                           hContact[:positionName] = position
                        end

                        # contact 10.4 (cntaddr) - contact address []
                        axAddress = xContactInfo.xpath('./cntaddr')
                        unless axAddress.empty?
                           axAddress.each do |xAddress|
                              hAddress = intMetadataClass.newAddress

                              # address 10.4.1 (addrtype) - address type
                              addType = xAddress.xpath('./addrtype').text
                              hAddress[:addressTypes] << addType unless addType.empty?

                              # address 10.4.2 (address) - address lines []
                              axAddLines = xAddress.xpath('./address')
                              unless axAddLines.empty?
                                 axAddLines.each do |xLine|
                                    addLine = xLine.text
                                    hAddress[:deliveryPoints] << addLine unless addLine.empty?
                                 end
                              end

                              # address 10.4.3 (city) - city
                              city = xAddress.xpath('./city').text
                              hAddress[:city] = city unless city.empty?

                              # address 10.4.4 (state) - state or province
                              state = xAddress.xpath('./state').text
                              hAddress[:adminArea] = state unless state.empty?

                              # address 10.4.5 (postal) - postal code
                              postal = xAddress.xpath('./postal').text
                              hAddress[:postalCode] = postal unless postal.empty?

                              # address 10.4.6 (country) - country
                              country = xAddress.xpath('./country').text
                              hAddress[:country] = country unless country.empty?

                              hContact[:addresses] << hAddress

                           end
                        end

                        # contact 10.5 (cntvoice) - contact voice phone number []
                        axVoice = xContactInfo.xpath('./cntvoice')
                        unless axVoice.empty?
                           axVoice.each do |xPhone|
                              phone = xPhone.text
                              unless phone.empty?
                                 hPhone = intMetadataClass.newPhone
                                 hPhone[:phoneNumber] = phone
                                 hPhone[:phoneServiceTypes] << 'voice'
                                 hContact[:phones] << hPhone
                              end
                           end
                        end

                        # contact 10.6 (cnttdd) - contact TDD/TTY phone number []
                        axTDD = xContactInfo.xpath('./cnttdd')
                        unless axTDD.empty?
                           axTDD.each do |xPhone|
                              phone = xPhone.text
                              unless phone.empty?
                                 hPhone = intMetadataClass.newPhone
                                 hPhone[:phoneNumber] = phone
                                 hPhone[:phoneServiceTypes] << 'tty'
                                 hContact[:phones] << hPhone
                              end
                           end
                        end

                        # contact 10.7 (cntfax) - contact fax phone number []
                        axFax = xContactInfo.xpath('./cntfax')
                        unless axFax.empty?
                           axFax.each do |xPhone|
                              phone = xPhone.text
                              unless phone.empty?
                                 hPhone = intMetadataClass.newPhone
                                 hPhone[:phoneNumber] = phone
                                 hPhone[:phoneServiceTypes] << 'facsimile'
                                 hContact[:phones] << hPhone
                              end
                           end
                        end

                        # contact 10.8 (cntemail) - contact email address []
                        axEmail = xContactInfo.xpath('./cntemail')
                        unless axEmail.empty?
                           axEmail.each do |xEmail|
                              email = xEmail.text
                              unless email.empty?
                                 hContact[:eMailList] << email
                              end
                           end
                        end

                        # contact 10.9 (hours) - hours of service
                        hours = xContactInfo.xpath('./hours').text
                        hContact[:hoursOfService] << hours unless hours.empty?

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
