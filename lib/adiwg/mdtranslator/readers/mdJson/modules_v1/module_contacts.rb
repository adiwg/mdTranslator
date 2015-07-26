# unpack contacts
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-08-20 original script
# 	Stan Smith 2013-09-25 moved onlineResource to new module
# 	Stan Smith 2013-10-21 moved address to new module
#	Stan Smith 2014-04-23 modify for json schema version 0.3.0
#   Stan Smith 2014-04-24 split default contacts to a separate method
#   Stan Smith 2014-05-14 combine phone service types
#   Stan Smith 2014-07-03 added module_path method to support versioning
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2014-12-19 modified to return nil for empty hContact
#   Stan Smith 2014-12-19 added testing and messages for '' and missing contactId
#   Stan Smith 2014-12-19 added testing to not place nil address into internal object
#   Stan Smith 2014-12-30 refactored
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to remove global namespace constants

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_address')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_onlineResource')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_phone')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Contact

                    def self.unpack(hContact, responseObj)

                        # return nil object if input is empty
                        intCont = nil
                        return if hContact.empty?

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intCont = intMetadataClass.newContact

                        # contact ID - required
                        # each contact must have a 'contactId' provided by the user
                        # ... the contactId is used by responsibleParty to reference a contact
                        # ... return nil contact if contactId is '' or missing
                        if hContact.has_key?('contactId')
                            s = hContact['contactId']
                            if s != ''
                                intCont[:contactId] = s
                            else
                                responseObj[:readerExecutionPass] =  false
                                responseObj[:readerExecutionMessages] << 'contact: {contactId: } is blank.'
                                return nil
                            end
                        else
                            responseObj[:readerExecutionPass] =  false
                            responseObj[:readerExecutionMessages] << 'contact: {contactId: } is missing.'
                            return nil
                        end

                        # individual name
                        if hContact.has_key?('individualName')
                            s = hContact['individualName']
                            if s != ''
                                intCont[:indName] = s
                            end
                        end

                        # organization name
                        if hContact.has_key?('organizationName')
                            s = hContact['organizationName']
                            if s != ''
                                intCont[:orgName] = s
                            end
                        end

                        # position name
                        if hContact.has_key?('positionName')
                            s = hContact['positionName']
                            if s != ''
                                intCont[:position] = s
                            end
                        end

                        # online resources
                        if hContact.has_key?('onlineResource')
                            aOlRes = hContact['onlineResource']
                            aOlRes.each do |hOlRes|
                                unless hOlRes.empty?
                                    intCont[:onlineRes] << OnlineResource.unpack(hOlRes, responseObj)
                                end
                            end
                        end

                        # contact instructions
                        if hContact.has_key?('contactInstructions')
                            s = hContact['contactInstructions']
                            if s != ''
                                intCont[:contactInstructions] = s
                            end
                        end

                        # phones - all service types
                        if hContact.has_key?('phoneBook')
                            aPhones = hContact['phoneBook']
                            aPhones.each do |hPhone|
                                intCont[:phones].concat(Phone.unpack(hPhone, responseObj))
                            end
                        end

                        # address
                        if hContact.has_key?('address')
                            conAddress = hContact['address']
                            hAddress = $ReaderNS::Address.unpack(conAddress, responseObj)
                            unless hAddress.nil?
                                intCont[:address] = hAddress
                            end
                        end

                        return intCont
                    end

                    def self.setDefaultContacts()

                        # add default contacts
                        intMetadataClass = InternalMetadata.new
                        aDefContacts = Array.new

                        # contact to support biological extensions
                        intCont = intMetadataClass.newContact
                        intCont[:contactId] = 'ADIwgBio'
                        intCont[:orgName] = 'National Biological Information Infrastructure (NBII)'
                        aDefContacts << intCont

                        # contact to support doi (digital object identifier)
                        intCont = intMetadataClass.newContact
                        intCont[:contactId] = 'ADIwgDOI'
                        intCont[:orgName] = 'International DOI Foundation (IDF)'

                        intOlRes = intMetadataClass.newOnlineResource
                        intOlRes[:olResURI] = 'http://www.doi.org'
                        intCont[:onlineRes] << intOlRes

                        aDefContacts << intCont

                        return aDefContacts

                    end

                end

            end
        end
    end
end