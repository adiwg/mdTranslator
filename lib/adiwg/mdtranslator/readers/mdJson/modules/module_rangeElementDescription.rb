# unpack range element description

module ADIWG
  module Mdtranslator
    module Readers
      module MdJson

        module RangeElementDescription

          def self.unpack(hRangeElementDescription, responseObj, inContext = nil)
            @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

            outContext = 'range element description'
            outContext = inContext + ' > ' + outContext unless inContext.nil?

            intRangeElementDescription = {}

            if hRangeElementDescription.has_key?('name')
              intRangeElementDescription[:name] = hRangeElementDescription['name']
            end

            if hRangeElementDescription.has_key?('definition')
              intRangeElementDescription[:definition] = hRangeElementDescription['definition']
            end

            if hRangeElementDescription.has_key?('rangeElements')
              intRangeElementDescription[:rangeElements] = hRangeElementDescription['rangeElements']
            end

            return intRangeElementDescription

          end

        end
      end
    end
  end
end
