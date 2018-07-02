# mdJson 2.0 writer - party

# History:
#   Stan Smith 2017-03-18 original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Party

               def self.build(hParty)

                  Jbuilder.new do |json|
                     json.contactId hParty[:contactId]
                     json.organizationMembers hParty[:organizationMembers] unless hParty[:organizationMembers].empty?
                  end

               end # build
            end # Party

         end
      end
   end
end
