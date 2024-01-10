require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module AccessLevel

               def self.build(intObj)
                  resourceInfo = intObj[:metadata][:resourceInfo]
                  legalConstraints = resourceInfo[:constraints]&.select { |constraint| constraint[:type] == 'legal' }
                  
                  accessLevel = legalConstraints&.detect do |constraint|
                     codes = constraint.dig(:legalConstraint, :accessCodes)
                     codes&.any? { |code| ["public", "restricted public", "non-public"].include?(code) }
                  end&.dig(:legalConstraint, :accessCodes)&.find { |code| ["public", "restricted public", "non-public"].include?(code) }

                  accessLevel ? accessLevel : nil
               end           

            end
         end
      end
   end
end

