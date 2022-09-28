require_relative 'module_scope'
require_relative 'module_citation'

module ADIWG
  module Mdtranslator
    module Readers
      module MdJson

        module ConformanceResult

          def self.unpack(hConformanceResult, responseObj, inContext = nil)

            intMetadataClass = InternalMetadata.new
            intConformanceResult = intMetadataClass.newConformanceResult

            # dateTime
            if hConformanceResult.has_key?('dateTime')
              intConformanceResult[:dateTime] = hConformanceResult['dateTime']
            end

            # scope
            if hConformanceResult.has_key?('scope')
              intConformanceResult[:scope] = Scope.unpack(hConformanceResult['scope'], responseObj)
            end

            #specification
            if hConformanceResult.has_key?('specification')
              intConformanceResult[:specification] = Citation.unpack(hConformanceResult['specification'], responseObj)
            end

            # explanation
            if hConformanceResult.has_key?('explanation')
              intConformanceResult[:explanation] = hConformanceResult['explanation']
            end

            # pass
            if hConformanceResult.has_key?('pass')
              intConformanceResult[:pass] = hConformanceResult['pass']
            end

            return intConformanceResult
          end

        end

      end
    end
  end
end
