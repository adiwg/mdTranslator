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
                  # [need new code under constraints to distinguish 'public', 'restricted public', 'non-public']
                  return 'public'
               end
            end
         end
      end
   end
end
