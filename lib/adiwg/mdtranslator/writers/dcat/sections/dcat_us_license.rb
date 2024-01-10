module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module License

               def self.build(intObj)
                  resourceInfo = intObj.dig(:metadata, :resourceInfo)
                  title = resourceInfo.dig(:constraints, 0, :reference, 0, :title)
                  license = title || 'https://creativecommons.org/publicdomain/zero/1.0/'
                  license
               end

            end
         end
      end
   end
end
