# unpack dataQuality
# Reader - ADIwg JSON to internal data structure

require_relative 'module_scope'
require_relative 'module_dataQualityReport'
require_relative 'module_citation'

module ADIWG
  module Mdtranslator
    module Readers
      module MdJson

        module DataQuality

          def self.unpack(hDataQuality, responseObj, inContext = nil)
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

            if hDataQuality.has_key?('standaloneQualityReport')
              hObject = hDataQuality['standaloneQualityReport']
              unless hObject.empty?
                intDataQuality[:standaloneReport] = {}
                intDataQuality[:standaloneReport][:abstract] = hObject["abstract"]

                unless hObject["reportReference"].nil? || hObject["reportReference"].empty?
                  intDataQuality[:standaloneReport][:reportReference] = Citation.unpack(hObject["reportReference"], responseObj, inContext)
                end
              end
            end

            if hDataQuality.has_key?('report')
              hDataQuality['report'].each do |item|
                report = DataQualityReport.unpack(item, responseObj, inContext)

                unless report.nil?
                  intDataQuality[:report] << report
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
