module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module Rights

               def self.build(intObj, accessLevel)
                  resourceInfo = intObj.dig(:metadata, :resourceInfo)
                  constraints = resourceInfo&.dig(:constraints)
                
                  if accessLevel && ["restricted public", "non-public"].include?(accessLevel)
                    constraints&.each do |constraint|
                      if constraint[:type] == "use"
                        statement = constraint.dig(:releasability, :statement)
                        disseminationConstraints = constraint.dig(:releasability, :disseminationConstraint)
                
                        if statement && disseminationConstraints
                          combinedConstraints = disseminationConstraints.join(" ")
                          return "#{statement} #{combinedConstraints}".strip
                        end
                      end
                    end
                  end
                
                  nil
               end                

            end
         end
      end
   end
end
