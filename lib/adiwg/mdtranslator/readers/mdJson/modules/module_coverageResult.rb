require_relative 'module_scope'
require_relative 'module_spatialRepresentation'
require_relative 'module_qualityResultFile'
require_relative 'module_format'
require_relative 'module_coverageDescription'

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
            if hResult.has_key?('resultContentDescription')
              intResult[:resultContentDescription] = CoverageDescription.unpack(hResult['resultContentDescription'], responseObj)
            end


            # resourceFormat
            if hResult.has_key?('resourceFormat')
              intResult[:resourceFormat] = Format.unpack(hResult['resourceFormat'], responseObj)
            end


            # resultFile
            if hResult.has_key?('resultFile')
              intResult[:resultFile] = QualiltyResultFile.unpack(hResult['resultFile'], responseObj)
            end

            return intResult

          end
        end

      end
    end
  end
end
