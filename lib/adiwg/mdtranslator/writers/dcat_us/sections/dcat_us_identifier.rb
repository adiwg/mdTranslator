# dcat_us 1.0 writer

# History:
#  Johnathan Aspinwall 2023-06-22 original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module Identifier

               def self.build(hIdentifier)
                  Jbuilder.new do |json|
                     json.key hIdentifier[:identifier]
                     json.scheme hIdentifier[:namespace]
                     json.type hIdentifier[:description]
                  end
               end

            end
         end
      end
   end
end
