require 'jbuilder'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module Constraint
          def self.build(use, legal, security)
            Jbuilder.new do |json|
              json.useLimitation(use)
              json.legalConstraint(legal) do |lg|
                json.accessConstraint(lg[:accessCodes])
                json.useConstraint(lg[:useCodes])
                json.otherConstraint(lg[:otherCons])
              end
              json.securityConstraint(security) do |sc|
                json.classification sc[:classCode]
                json.userNote sc[:userNote]
                json.classificationSystem sc[:classSystem]
                json.handlingDescription sc[:handlingDesc]
              end
            end
          end
        end
      end
    end
  end
end
