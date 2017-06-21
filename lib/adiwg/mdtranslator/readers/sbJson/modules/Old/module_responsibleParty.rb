module ADIWG
    module Mdtranslator
        module Readers
            module SbJson

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
                                if (!ADIWG::Mdtranslator::Readers::SbJson.findContact(s))
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
