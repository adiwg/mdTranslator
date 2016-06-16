require 'jbuilder'
require_relative 'mdJson_base'
require_relative 'mdJson_responsibleParty'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module ResourceMaintenance
          extend MdJson::Base
          
          def self.build(intObj)
            Jbuilder.new do |json|
              json.maintenanceFrequency intObj[:maintFreq]
              json.maintenanceNote (intObj[:maintNotes])
              json.maintenanceContact json_map(intObj[:maintContacts], ResponsibleParty)
            end
          end
        end
      end
    end
  end
end
