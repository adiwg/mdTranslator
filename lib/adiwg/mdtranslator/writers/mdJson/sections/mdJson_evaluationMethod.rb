require 'jbuilder'
require_relative 'mdJson_citation'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson

        module EvaluationMethod

          @Namespace = ADIWG::Mdtranslator::Writers::MdJson

          def self.build(hMethod)
            Jbuilder.new do |json|
              json.type hMethod[:type]
              json.dateTime hMethod[:dateTime]
              json.methodDescription hMethod[:methodDescription]
              json.evaluationProcedure Citation.build(hMethod[:evaluationMethod])
              json.referenceDocument @Namespace.json_map(hMethod[:referenceDocument], Citation)
              json.evaluationMethodType hMethod[:evaluationMethodType]
              json.deductiveSource hMethod[:deductiveSource]
              json.samplingScheme hMethod[:samplingScheme]
              json.lotDescription hMethod[:lotDescription]
              json.samplingRatio hMethod[:samplingRatio]
            end
          end
        end

      end

    end
  end
end
