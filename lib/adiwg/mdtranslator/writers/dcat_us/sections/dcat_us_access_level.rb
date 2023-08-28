# dcat_us 1.0 writer

# History:
#  Johnathan Aspinwall 2023-06-22 original script

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
                     constraint.dig(:legalConstraint, :accessCodes)&.any? { |code| ["public", "restricted public", "non-public"].include?(code) }
                  end                   

                  accessLevel ? accessLevel : nil
               end           

            end
         end
      end
   end
end

