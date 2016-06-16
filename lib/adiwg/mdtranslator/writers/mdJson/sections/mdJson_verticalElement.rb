require 'jbuilder'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module VerticalElement
          def self.build(intObj)
            Jbuilder.new do |json|
              json.minimumValue intObj[:minValue]
              json.maximumValue intObj[:maxValue]
              json.verticalCRSTitle intObj[:crsTitle]
              json.verticalCRSUri intObj[:crsURI]
            end
          end
        end
      end
    end
  end
end
