require 'jbuilder'
require_relative 'mdJson_scope'
require_relative 'mdJson_spatialRepresentation'
require_relative 'mdJson_format'
require_relative 'mdJson_qualityResultFile'
require_relative 'mdJson_coverageDescription'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson

        module CoverageResult
          def self.build(hCoverageResult)
            Jbuilder.new do |json|
                json.dateTime hCoverageResult[:dateTime]
                json.scope Scope.build(hCoverageResult[:scope])
                json.spatialRepresentationType hCoverageResult[:spatialRepresentationType]
                json.spatialRepresentation SpatialRepresentation.build(hCoverageResult[:spatialRepresentation]) unless hCoverageResult[:spatialRepresentation].nil?
                json.resultContentDescription CoverageDescription.build(hCoverageResult[:resultContentDescription]) unless hCoverageResult[:resultContentDescription].nil?
                json.resourceFormat Format.build(hCoverageResult[:resourceFormat]) unless hCoverageResult[:resourceFormat].nil?
                json.resultFile QualityResultFile.build(hCoverageResult[:resultFile]) unless hCoverageResult[:resultFile].nil?
            end
          end
        end

      end
    end
  end
end
