require 'jbuilder'
require_relative 'mdJson_identifier'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson

        module QualityMeasure
          def self.build(hQualityMeasure)
            Jbuilder.new do |json|
              json.identifier Identifier.build(hQualityMeasure[:identifier]) unless hQualityMeasure[:identifier].empty?
              json.name hQualityMeasure[:name] unless hQualityMeasure[:name].empty?
              json.description hQualityMeasure[:description] unless hQualityMeasure[:description].nil?
            end
          end
        end

      end
    end
  end
end
