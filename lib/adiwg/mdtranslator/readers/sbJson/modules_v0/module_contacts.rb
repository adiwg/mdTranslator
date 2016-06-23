require 'uuidtools'

module ADIWG
    module Mdtranslator
        module Readers
            module SbJson
                module Contact
                    def self.unpack(hContact, responseObj)
                        # return nil object if input is empty
                        intCont = nil
                        return if hContact.empty?

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intCont = intMetadataClass.newContact

                        # contact ID - required
                        # SB doesn't provide a contactId, so we create one
                        intCont[:contactId] = UUIDTools::UUID.random_create.to_s
                        hContact['contactId'] = intCont[:contactId]

                        # contact name
                        s = hContact['name']
                        if s != ''
                            if hContact['contactType'] == 'person'
                                intCont[:indName] = s
                                intCont[:orgName] = hContact['organization']['displayText'] unless hContact[:organization].nil?
                            else
                                intCont[:orgName] = s
                            end
                        end

                        # position name
                        if hContact.key?('jobTitle')
                            s = hContact['jobTitle']
                            intCont[:position] = s if s != ''
                        end

                        # SB Role
                        if hContact.key?('type')
                            s = hContact['type']
                            intCont[:primaryRole] = s if s != ''
                        end

                        # contact instructions
                        if hContact.key?('instructions')
                            s = hContact['instructions']
                            intCont[:contactInstructions] = s if s != ''
                        end

                        if hContact.key?('primaryLocation')
                            pl = hContact['primaryLocation']
                            # phones - all service types
                            if pl.key?('officePhone')
                                officePhone = intMetadataClass.newPhone

                                # phone - service
                                officePhone[:phoneServiceType] = 'voice'
                                officePhone[:phoneName] = 'officePhone'
                                officePhone[:phoneNumber] = pl['officePhone']
                                intCont[:phones] << officePhone
                            end
                            if pl.key?('faxPhone')
                                faxPhone = intMetadataClass.newPhone

                                # phone - service
                                faxPhone[:phoneServiceType] = 'fax'
                                faxPhone[:phoneName] = 'faxPhone'
                                faxPhone[:phoneNumber] = pl['faxPhone']
                                intCont[:phones] << faxPhone
                            end

                            # address
                            address = pl['mailAddress']  || pl['streetAddress']
                            unless address.nil?
                                intAdd = intMetadataClass.newAddress

                                # address - delivery point
                                if address.has_key?('line1')
                                  intAdd[:deliveryPoints] << address['line1']
                                end

                                if address.has_key?('line2')
                                  intAdd[:deliveryPoints] << address['line2']
                                end

                                intAdd[:city] = address['city']
                                intAdd[:adminArea] = address['state']
                                intAdd[:postalCode] = address['zip']
                                intAdd[:country] = address['country']

                                if hContact['email']
                                    intAdd[:eMailList] << hContact['email']
                                end

                                intCont[:address] = intAdd
                            end
                        end

                        intCont
                    end

                    def self.setDefaultContacts
                        # add default contacts
                        intMetadataClass = InternalMetadata.new
                        aDefContacts = []

                        #contact for ScienceBase
                        intCont = intMetadataClass.newContact
                        intCont[:contactId] = 'SB'
                        intCont[:orgName] = 'ScienceBase'

                        intOlRes = intMetadataClass.newOnlineResource
                        intOlRes[:olResURI] = 'http://www.sciencebase.gov'
                        intOlRes[:olResName] = 'ScienceBase Homepage'
                        intCont[:onlineRes] << intOlRes

                        intAdd = intMetadataClass.newAddress
                        intAdd[:eMailList] << 'sciencebase@usgs.gov'
                        intCont[:address] = intAdd
                        intCont[:internal] = true

                        aDefContacts << intCont

                        # contact to support doi (digital object identifier)
                        intCont = intMetadataClass.newContact
                        intCont[:contactId] = 'ADIwgDOI'
                        intCont[:orgName] = 'International DOI Foundation (IDF)'

                        intOlRes = intMetadataClass.newOnlineResource
                        intOlRes[:olResURI] = 'http://www.doi.org'
                        intCont[:onlineRes] << intOlRes
                        intCont[:internal] = true

                        aDefContacts << intCont

                        aDefContacts
                    end
                end
            end
        end
    end
end
