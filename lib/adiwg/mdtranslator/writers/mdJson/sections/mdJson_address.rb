require 'jbuilder'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module Address
          def self.build(intObj)
            Jbuilder.new do |json|
              json.deliveryPoint(intObj[:deliveryPoints])
              json.protocol intObj[:city]
              json.name intObj[:adminArea]
              json.description intObj[:postalCode]
              json.function intObj[:country]
              json.electronicMailAddress(intObj[:eMailList])
            end
          end
        end
      end
    end
  end
end
