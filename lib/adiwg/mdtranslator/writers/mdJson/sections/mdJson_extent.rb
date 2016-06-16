require 'jbuilder'
require_relative 'mdJson_base'
require_relative 'mdJson_geographicElement'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module Extent
          extend MdJson::Base

          def self.build(intObj)
            Jbuilder.new do |json|
              json.description intObj[:extDesc]
              json.geographicElement(intObj[:extGeoElements]) do |ge|
                json.merge! GeographicElement.build(ge)
              end unless intObj[:extGeoElements].empty?
              json.temporalElement TemporalElement.build(intObj[:extTempElements])
              json.verticalElement json_map(intObj[:extVertElements], VerticalElement)
            end
          end
        end
      end
    end
  end
end
