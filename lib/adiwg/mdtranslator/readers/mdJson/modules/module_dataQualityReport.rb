require_relative 'module_scope'
require_relative 'module_conformanceResult'
require_relative 'module_descriptiveResult'
require_relative 'module_quantitativeResult'

module ADIWG
  module Mdtranslator
    module Readers
      module MdJson

        module DataQualityReport

          def self.unpack(hReport, responseObj, inContext = nil)
            @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

            outContext = 'Data Quality Report'
            outContext = inContext + ' > ' + outContext unless inContext.nil?

            if hReport.empty?
              @MessagePath.issueWarning(730, responseObj, inContext)
              return nil            
            end

            intMetadataClass = InternalMetadata.new
            intReport = intMetadataClass.newDataQualityReport

            if hReport.has_key?('conformanceResult')
              hReport['conformanceResult'].each do |item|
                hReturn = ConformanceResult.unpack(item, responseObj)

                unless hReturn.nil?
                  intReport[:conformanceResult] << hReturn
                end
              end
            end

            if hReport.has_key?('descriptiveResult')
              hReport['descriptiveResult'].each do |item|
                hReturn = DescriptiveResult.unpack(item, responseObj)

                unless hReturn.nil?
                  intReport[:descriptiveResult] << hReturn

                end
              end
            end

            if hReport.has_key?('qualityMeasure')
              qualityMeasure = hReport['qualityMeasure']
              identifier = qualityMeasure['identifier']
              intReport[:qualityMeasure] = {
                identifier: {
                  identifier: identifier['identifier'],
                  namespace: identifier['namespace'],
                  version: identifier['version'],
                  description: identifier['description']
                },
                name: qualityMeasure['name'],
                description: qualityMeasure['description']
              }
            end

            if hReport.has_key?('quantitativeResult')
              hReport['quantitativeResult'].each do |item|
                hReturn = QuantitativeResult.unpack(item, responseObj)

                unless hReturn.nil?
                  intReport[:quantitativeResult] << hReturn
                end
              end
            end


            return intReport
          end
        end

      end
    end
  end
end
