# unpack role extent
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2016-10-09 original script

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module RoleParty

                    def self.unpack(hParty, responseObj)

                        # return nil object if input is empty
                        if hParty.empty?
                            responseObj[:readerExecutionMessages] << 'Role Party object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intRoleParty = intMetadataClass.newRoleParty

                        # party - contact ID (required)
                        if hParty.has_key?('contactId')
                            intRoleParty[:contactId] = hParty['contactId']
                        end
                        if intRoleParty[:contactId].nil? || intRoleParty[:contactId] == ''
                            responseObj[:readerExecutionMessages] << 'Role Party contact ID is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # party - contact index, contact type (computed)
                        # return nil if contact ID does not exist in contact array
                        contact = ADIWG::Mdtranslator::Readers::MdJson.findContact(hParty['contactId'])
                        if contact[0].nil?
                            responseObj[:readerExecutionMessages] << "Responsible Party contact ID #{hParty['contactId']} not found"
                            responseObj[:readerExecutionPass] = false
                            return nil
                        else
                            intRoleParty[:contactIndex] = contact[0]
                            intRoleParty[:contactType] = contact[1]
                        end

                        # party - organization members []
                        # organization member contact IDs not found in 'contacts' are reported as warning
                        if intRoleParty[:contactType] == 'organization'
                            if hParty.has_key?('organizationMembers')
                                hParty['organizationMembers'].each do |contactId|
                                    contact = ADIWG::Mdtranslator::Readers::MdJson.findContact(contactId)
                                    if contact[0].nil?
                                        responseObj[:readerExecutionMessages] << "Responsible Party organization member #{contactId} not found"
                                    else
                                        newParty = intMetadataClass.newRoleParty
                                        newParty[:contactId] = contactId
                                        newParty[:contactIndex] = contact[0]
                                        newParty[:contactType] = contact[1]
                                        intRoleParty[:organizationMembers] << newParty
                                    end
                                end
                            end
                        end

                        return intRoleParty

                    end

                end

            end
        end
    end
end
