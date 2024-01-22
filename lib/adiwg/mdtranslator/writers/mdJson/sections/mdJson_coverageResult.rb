require 'jbuilder'
require_relative 'mdJson_scope'
require_relative 'mdJson_spatialRepresentation'
require_relative 'mdJson_resultFile'

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
                json.resultContent hCoverageResult[:resultContent]
                json.resourceFormat hCoverageResult[:resourceFormat]
                json.resultFile ResultFile.build(hCoverageResult[:resultFile]) unless hCoverageResult[:resultFile].nil?
            end
          end
        end

      end
    end
  end
end
