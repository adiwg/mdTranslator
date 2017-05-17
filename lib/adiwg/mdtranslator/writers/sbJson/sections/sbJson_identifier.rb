# sbJson 1.0 writer

# History:
#  Stan Smith 2017-05-16 refactored for mdTranslator 2.0
#  Json Bradley original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

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
