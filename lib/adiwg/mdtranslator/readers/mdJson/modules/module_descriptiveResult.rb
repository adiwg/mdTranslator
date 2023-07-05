require_relative 'module_scope'

module ADIWG
  module Mdtranslator
    module Readers
      module MdJson

        module DescriptiveResult
          def self.unpack(hResult, responseObj, inContext = nil)
            @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

            if hResult.empty?
              @MessagePath.issueWarning(80, responseObj, inContext)
              return nil
            end

            intMetadataClass = InternalMetadata.new
            intResult = intMetadataClass.newDescriptiveResult

            if hResult.has_key?('dateTime')
              intResult[:dateTime] = hResult['dateTime']
            end

            if hResult.has_key?('scope')
              intResult[:scope] = Scope.unpack(hResult['scope'], responseObj)
            end

            if hResult.has_key?('statement')
              intResult[:statement] = hResult['statement']
            end

            return intResult
          end
        end

      end

    end
  end
end
