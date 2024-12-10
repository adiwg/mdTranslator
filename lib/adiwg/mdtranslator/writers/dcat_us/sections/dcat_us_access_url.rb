require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module AccessURL

               def self.build(option)
                  option[:olResURI] if option[:olResURI].end_with?('.html')
                end                

            end
         end
      end
   end
end
