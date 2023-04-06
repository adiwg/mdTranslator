require 'jbuilder'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson

        module QualityMeasure
          def self.build(hQualityMeasure)
            Jbuilder.new do |json|
              json.identifier hQualityMeasure[:identifier]
              json.name hQualityMeasure[:name]
              json.description hQualityMeasure[:description]
            end
          end
        end

      end
    end
  end
end
