require 'jbuilder'
require_relative 'mdJson_scope'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson

        module QuantitativeResult
          def self.build(hResult)
            Jbuilder.new do |json|
              json.dateTime hResult[:dateTime]
              json.scope Scope.build(hResult[:scope]) if hResult[:scope]
              json.value hResult[:value]
              json.valueUnits hResult[:valueUnits]
              json.valueRecordType hResult[:valueRecordType]
            end
          end
        end

      end
    end
  end
end
