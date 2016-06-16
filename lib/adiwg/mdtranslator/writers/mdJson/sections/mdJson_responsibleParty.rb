require 'jbuilder'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module ResponsibleParty
          def self.build(intObj)
            Jbuilder.new do |json|
              json.contactId intObj[:contactId]
              json.role intObj[:roleName]
            end
          end
        end
      end
    end
  end
end
