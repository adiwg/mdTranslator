# mdJson 2.0 writer - locale

# History:
#   Stan Smith 2017-03-11 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Locale

               def self.build(hLocale)

                  Jbuilder.new do |json|
                     json.language hLocale[:languageCode]
                     json.country hLocale[:countryCode]
                     json.characterSet hLocale[:characterEncoding]
                  end

               end # build
            end # Locale

         end
      end
   end
end
