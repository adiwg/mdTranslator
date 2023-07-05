require_relative 'module_citation'

module ADIWG
  module Mdtranslator
    module Readers
      module MdJson

        module EvaluationMethod
          def self.unpack(hMethod, responseObj, inContext = nil)

            intMetadataClass = InternalMetadata.new
            intMethod = intMetadataClass.newEvaluationMethod

            # type: nil,
            if hMethod.has_key?('type')
              intMethod[:type] = hMethod['type']
            end

            # dateTime: [],
            if hMethod.has_key?('dateTime')
               intMethod[:dateTime] = hMethod['dateTime']
            end

            # methodDescription: nil,
            if hMethod.has_key?('methodDescription')
             intMethod[:methodDescription] = hMethod['methodDescription']
            end

            # evaluationProcedure: {},
            if hMethod.has_key?('evaluationProcedure')
              intMethod[:evaluationProcedure] = Citation.unpack(hMethod['evaluationProcedure'], responseObj)
            end

            # referenceDocuments: [],
            if hMethod.has_key?('referenceDocuments')

              hMethod['referenceDocuments'].each do |item|
                hReturn = Citation.unpack(item, responseObj)
                unless hReturn.nil?
                  intMethod[:referenceDocuments] << hReturn
                end
              end

              intMethod[:referenceDocuments] = hMethod['referenceDocuments']
            end

            # evaluationMethodType: nil,
            if hMethod.has_key?('evaluationMethodType')
              intMethod[:evaluationMethodType] = hMethod['evaluationMethodType']
            end

            # deductiveSource: nil,
            if hMethod.has_key?('deductiveSource')
              intMethod[:deductiveSource] = hMethod['deductiveSource']
            end

            # samplingScheme: nil,
            if hMethod.has_key?('samplingScheme')
              intMethod[:samplingScheme] = hMethod['samplingScheme']
            end

            # lotDescription: nil,
            if hMethod.has_key?('lotDescription')
              intMethod[:lotDescription] = hMethod['lotDescription']
            end

            # samplingRatio: nil
            if hMethod.has_key?('samplingRatio')
              intMethod[:samplingRatio] = hMethod['samplingRatio']
            end

            return intMethod

          end
        end

      end
    end
  end
end
