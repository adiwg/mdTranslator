require 'jbuilder'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module OnlineResource
          def self.build(intObj)
            Jbuilder.new do |json|
              json.uri intObj[:olResURI]
              json.protocol intObj[:olResProtocol]
              json.name intObj[:olResName]
              json.description intObj[:olResDesc]
              json.function intObj[:olResFunction]
            end
          end
        end
      end
    end
  end
end
