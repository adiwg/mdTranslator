require 'jbuilder'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module SpatialReference
          def self.build(intObj)
            Jbuilder.new do |json|
              json.name(intObj[:sRNames])
              json.epsgNumber(intObj[:sREPSGs])
              json.wkt(intObj[:sRWKTs])
            end
          end
        end
      end
    end
  end
end
