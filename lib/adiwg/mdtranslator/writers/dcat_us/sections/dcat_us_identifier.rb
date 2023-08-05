# dcat_us 1.0 writer

# History:
#  Johnathan Aspinwall 2023-06-22 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module Identifier

               def self.build(intObj)
                  intObj.dig(:metadata, :resourceInfo, :citation, :onlineResource, :uri)
                end                
               
            end
         end
      end
   end
end
