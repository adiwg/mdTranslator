# unpack dataQuality
# Reader - ADIwg JSON to internal data structure

require_relative 'module_scope'

module ADIWG
  module Mdtranslator
    module Readers
      module MdJson

        module DataQuality

          def self.unpack(hDataQuality, responseObj)
            @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

            if hDataQuality.empty?
              @MessagePath.issueWarning(300, responseObj)
              return nil
            end

            intMetadataClass = InternalMetadata.new
            intDataQuality = intMetadataClass.newDataQuality

            outContext = 'dataQuality'

            if hDataQuality.has_key?('scope')
              hObject = hDataQuality['scope']
              unless hObject.empty?
                hReturn = Scope.unpack(hObject, responseObj)
                unless hReturn.nil?
                  intDataQuality[:scope] = hReturn
                end
              end
            end

            return intDataQuality

          end

        end
        
      end
    end
  end
end
