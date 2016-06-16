require 'jbuilder'
require_relative 'mdJson_base'
require_relative 'mdJson_responsibleParty'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module Usage
          extend MdJson::Base

          def self.build(intObj)
            Jbuilder.new do |json|
              json.specificUsage intObj[:specificUsage]
              json.userDeterminedLimitation (intObj[:userLimits])
              json.userContactInfo json_map(intObj[:userContacts], ResponsibleParty)
            end
          end
        end
      end
    end
  end
end
