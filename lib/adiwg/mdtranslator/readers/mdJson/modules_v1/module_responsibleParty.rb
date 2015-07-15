# unpack responsible party
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-08-26 original script
#   Stan Smith 2014-05-28 modified to support JSON schema 0.5.0
#   ... removed resource IDs associated with contact
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2015-01-18 added nil return if hRParty empty
#   Stan Smith 2015-06-12 added check that contactId for responsibleParty
#   ... matches an actual contact in the contact array
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to remove global namespace constants

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module ResponsibleParty

                    def self.unpack(hRParty, responseObj)

                        # return nil object if input is empty
                        intResById = nil
                        return if hRParty.empty?

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intResById = intMetadataClass.newRespParty

                        # responsible party - contact
                        if hRParty.has_key?('contactId')
                            s = hRParty['contactId']
                            if s != ''
                                intResById[:contactId] = s
                                if (!ADIWG::Mdtranslator::Readers::MdJson.findContact(s))
                                    responseObj[:readerExecutionPass] = false
                                    responseObj[:readerExecutionMessages] << "Responsible Party contact ID #{s} does not match with any contact provided\n"
                                end
                            else
                                responseObj[:readerExecutionPass] = false
                                responseObj[:readerExecutionMessages] << 'Responsible Party is missing the contact ID\n'
                            end
                        end

                        # responsible party - role - required
                        if hRParty.has_key?('role')
                            s = hRParty['role']
                            if s != ''
                                intResById[:roleName] = s
                            else
                                responseObj[:readerExecutionPass] = false
                                responseObj[:readerExecutionMessages] << 'Responsible Party is missing the contact role\n'
                            end
                        end

                        return intResById

                    end

                end

            end
        end
    end
end
