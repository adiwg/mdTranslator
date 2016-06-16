require 'jbuilder'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module DateTime
          def self.build(intObj)
            Jbuilder.new do |json|
              json.date(intObj[:dateTime])
              json.dateType intObj[:dateType]
            end
          end
        end
      end
    end
  end
end
