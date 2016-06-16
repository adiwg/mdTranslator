require 'jbuilder'
require_relative 'mdJson_base'
require_relative 'mdJson_onlineResource'
require_relative 'mdJson_format'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module TransferOption
          extend MdJson::Base

          def self.build(intObj)
            Jbuilder.new do |json|
              json.distributorFormat json_map(intObj[:dist], Format)
              json.transferSize intObj[:transferSize]
              json.transferSizeUnits intObj[:transferSizeUnits]
              json.online json_map(intObj[:online], OnlineResource)
              json.offline do
                off = intObj[:offline]
                json.name off[:mediumType]
                json.mediumCapacity off[:mediumCapacity]
                json.mediumCapacityUnits off[:mediumCapacityUnits]
                json.mediumFormat off[:mediumFormat]
                json.mediumNote off[:mediumNote]
              end
            end
          end
        end
      end
    end
  end
end
