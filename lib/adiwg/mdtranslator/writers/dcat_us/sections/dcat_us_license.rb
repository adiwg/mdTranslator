# dcat_us 1.0 writer

# History:
#  Johnathan Aspinwall 2023-08-26 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module License

               def self.build(intObj)
                  resourceInfo = intObj.dig(:metadata, :resourceInfo)
                  reference = resourceInfo.dig(:constraint, :reference, 0)
                  license = reference || 'https://creativecommons.org/publicdomain/zero/1.0/'
                  license
               end

            end
         end
      end
   end
end
