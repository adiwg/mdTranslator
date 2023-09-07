module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module Rights

               def self.build(intObj)
                  resourceInfo = intObj.dig(:metadata, :resourceInfo)
                  constraint = resourceInfo&.dig(:constraint)
                  accessLevel = constraint&.dig(:accessLevel)

                  if accessLevel && ["restricted public", "non-public"].include?(accessLevel)
                    statement = constraint.dig(:releasibility, :statement)
                    disseminationConstraints = constraint.dig(:releasibility, :disseminationConstraint)
                    
                    if disseminationConstraints
                      combinedConstraints = disseminationConstraints.join(" ")
                    end

                    return "#{statement} #{combinedConstraints}".strip
                  end

                  nil
               end

            end
         end
      end
   end
end
