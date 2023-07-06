# dcat_us 1.0 writer

# History:
#  Johnathan Aspinwall 2023-07-06 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module Keyword
 
               def self.build(intObj)
                  resourceInfo = intObj[:metadata][:resourceInfo]
                  keywords = resourceInfo[:keywords]

                  unless keywords.empty?
                     return keywords.flat_map { |keyword| keyword[:keywords].map { |kw| kw[:keyword] } }
                  end
                     
                  return []
               end
                
            end
         end
      end
   end
end
 