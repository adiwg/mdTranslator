require_relative 'module_scope'

module ADIWG
  module Mdtranslator
    module Readers
      module MdJson

        module QuantitativeResult
          def self.unpack(hResult, responseObj, inContext = nil)
            @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

            if hResult.empty?
              @MessagePath.issueWarning(80, responseObj, inContext)
              return nil
            end

            intMetadataClass = InternalMetadata.new
            intResult = intMetadataClass.newQuantitativeResult

            if hResult.has_key?('dateTime')
              intResult[:dateTime] = hResult['dateTime']
            end

            if hResult.has_key?('scope')
              intResult[:scope] = Scope.unpack(hResult['scope'], responseObj)
            end

            if hResult.has_key?('value')
              intResult[:value] = hResult['value']
            end

            if hResult.has_key?('valueUnits')
              intResult[:valueUnits] = hResult['valueUnits']
            end

            if hResult.has_key?('valueRecordType')
              intResult[:valueRecordType] = hResult['valueRecordType']
            end

            return intResult
          end
        end

      end
    end
  end
end
