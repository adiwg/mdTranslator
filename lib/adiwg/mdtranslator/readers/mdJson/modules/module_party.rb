# unpack party
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-22 refactored error and warning messaging
# 	Stan Smith 2016-10-09 original script

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module Party

               def self.unpack(hParty, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hParty.empty?
                     @MessagePath.issueWarning(620, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intParty = intMetadataClass.newParty

                  # party - contact ID (required)
                  # load party with contact index, contact type, and name
                  # return nil if contact ID does not exist in contact array
                  if hParty.has_key?('contactId')
                     if hParty['contactId'].is_a?(Hash)
                        intParty[:contactId] = hParty['contactId'].transform_keys(&:to_sym)
                        context = hParty['contactId']['identifier']
                     elsif hParty['contactId'].is_a?(String)
                        intParty[:contactId] = hParty['contactId']
                        context = hParty['contactId']
                     end

                     unless intParty[:contactId].nil? || intParty[:contactId] == ''
                        hContact = @MessagePath.findContact(hParty['contactId'])
                        if hContact[0].nil?
                           outContext = 'contact ID ' + context
                           outContext = inContext + ' > ' + outContext unless inContext.nil?
                           @MessagePath.issueError(622, responseObj, outContext)
                        else
                           intParty[:contactIndex] = hContact[0]
                           intParty[:contactType] = hContact[1]
                           intParty[:contactName] = hContact[2]
                        end
                     end
                  end
                  if intParty[:contactId].nil? || intParty[:contactId] == ''
                     @MessagePath.issueError(621, responseObj, inContext)
                  end

                  # party - organization members []
                  # organization member contact IDs not found in 'contacts' are reported as warnings
                  if intParty[:contactType] == 'organization'
                     if hParty.has_key?('organizationMembers')
                        hParty['organizationMembers'].each do |contactId|
                           intParty[:organizationMembers] << contactId
                           hContact = @MessagePath.findContact(contactId)
                           if hContact[0].nil?
                              outContext = 'contact ID ' + contactId
                              outContext = inContext + ' > ' + outContext unless inContext.nil?
                              @MessagePath.issueWarning(623, responseObj, outContext)
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
