require_relative 'module_scope'
require_relative 'module_spatialRepresentation'

module ADIWG
  module Mdtranslator
    module Readers
      module MdJson

        module CoverageResult
          def self.unpack(hResult, responseObj, inContext)

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
            # https://github.com/ISO-TC211/XML/blob/master/standards.iso.org/iso/19115/resources/Codelists/gml/MD_SpatialRepresentationTypeCode.xml
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
            resultFile
            if hResult.has_key?('resultFile')
              intResult[:resultFile] = hResult['resultFile']
            end

            return intResult

          end
        end

      end
    end
  end
end
