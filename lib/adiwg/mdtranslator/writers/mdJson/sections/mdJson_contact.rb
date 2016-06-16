require 'jbuilder'
require_relative 'mdJson_base'
require_relative 'mdJson_onlineResource'
require_relative 'mdJson_phone'
require_relative 'mdJson_address'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module Contact
          extend MdJson::Base

          def self.build(contact)
            Jbuilder.new do |json|
              # contact
              json.contactId contact[:contactId]
              json.individualName contact[:indName]
              json.organizationName contact[:orgName]
              json.positionName contact[:position]
              json.onlineResource json_map(contact[:onlineRes], OnlineResource)
              json.contactInstructions contact[:contactInstructions]
              json.phoneBook json_map(contact[:phones], Phone)
              json.address Address.build(contact[:address])
            end
          end
        end
      end
    end
  end
end
