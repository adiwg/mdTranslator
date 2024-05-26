require 'jbuilder'
require_relative 'mdJson_scope'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson

        module QuantitativeResult
          def self.build(hResult)
            Jbuilder.new do |json|
              json.dateTime hResult[:dateTime] unless hResult[:dateTime].nil?
              json.scope Scope.build(hResult[:scope]) unless hResult[:scope].empty?
              json.name hResult[:name] unless hResult[:name].nil?
              json.value hResult[:values] unless hResult[:values].empty?
              json.valueUnits hResult[:valueUnits] unless hResult[:valueUnits].nil?
              json.valueRecordType hResult[:valueRecordType] unless hResult[:valueRecordType].nil?
            end
          end
        end

      end
    end
  end
end
