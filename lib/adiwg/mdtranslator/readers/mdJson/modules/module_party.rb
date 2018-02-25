# unpack party
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-02-19 refactored error and warning messaging
# 	Stan Smith 2016-10-09 original script

require_relative 'module_mdJson'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module Party

               def self.unpack(hParty, responseObj)

                  # return nil object if input is empty
                  if hParty.empty?
                     responseObj[:readerExecutionMessages] << 'WARNING: mdJson responsibility party object is empty'
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intParty = intMetadataClass.newParty

                  # party - contact ID (required)
                  if hParty.has_key?('contactId')
                     intParty[:contactId] = hParty['contactId']
                  end
                  if intParty[:contactId].nil? || intParty[:contactId] == ''
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson responsibility party contact ID is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # party - contact index, contact type (computed)
                  # return nil if contact ID does not exist in contact array
                  hContact = MdJson.findContact(hParty['contactId'])
                  if hContact[0].nil?
                     responseObj[:readerExecutionMessages] << "ERROR: mdJson responsibility party contact ID #{hParty['contactId']} not found"
                     responseObj[:readerExecutionPass] = false
                     return nil
                  else
                     intParty[:contactIndex] = hContact[0]
                     intParty[:contactType] = hContact[1]
                  end

                  # party - organization members []
                  # organization member contact IDs not found in 'contacts' are reported as warnings
                  if intParty[:contactType] == 'organization'
                     if hParty.has_key?('organizationMembers')
                        hParty['organizationMembers'].each do |contactId|
                           hContact = MdJson.findContact(contactId)
                           if hContact[0].nil?
                              responseObj[:readerExecutionMessages] << "WARNING: mdJson responsibility party organization member contact ID #{contactId} not found"
                           else
                              newParty = intMetadataClass.newParty
                              newParty[:contactId] = contactId
                              newParty[:contactIndex] = hContact[0]
                              newParty[:contactType] = hContact[1]
                              intParty[:organizationMembers] << newParty
                           end
                        end
                     end
                  end

                  return intParty

               end

            end

         end
      end
   end
end
