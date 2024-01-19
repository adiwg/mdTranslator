require_relative 'module_scope'
require_relative 'module_spatialRepresentation'
require_relative 'module_resultFile'

module ADIWG
  module Mdtranslator
    module Readers
      module MdJson

        module CoverageResult
          def self.unpack(hResult, responseObj)

            intMetadataClass = InternalMetadata.new
            intResult = intMetadataClass.newCoverageResult

            # dateTime
            if hResult.has_key?('dateTime')
              intResult[:dateTime] = hResult['dateTime']
            end


            # scope
            if hResult.has_key?('scope')
              intResult[:scope] = Scope.unpack(hResult['scope'], responseObj)
            end


            # spatialRepresentationType
            if hResult.has_key?('spatialRepresentationType')
              intResult[:spatialRepresentationType] = hResult['spatialRepresentationType']
            end


            # spatialRepresentation
            if hResult.has_key?('spatialRepresentation')
              intResult[:spatialRepresentation] = SpatialRepresentation.unpack(hResult['spatialRepresentation'], responseObj)
            end


            # resultContent
            if hResult.has_key?('resultContent')
              intResult[:resultContent] = hResult['resultContent']
            end


            # resourceFormat
            if hResult.has_key?('resourceFormat')
              intResult[:resourceFormat] = hResult['resourceFormat']
            end


            # resultFile
            if hResult.has_key?('resultFile')
              intResult[:resultFile] = ResultFile.unpack(hResult['resultFile'], responseObj)
            end

            return intResult

          end
        end

      end
    end
  end
end
