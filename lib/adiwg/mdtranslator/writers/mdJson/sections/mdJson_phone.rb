# mdJson 2.0 writer - phone

# History:
#   Stan Smith 2017-03-12 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Phone

               def self.build(hPhone)

                  Jbuilder.new do |json|
                     json.phoneName hPhone[:phoneName]
                     json.phoneNumber hPhone[:phoneNumber]
                     json.service hPhone[:phoneServiceTypes] unless hPhone[:phoneServiceTypes].empty?
                  end

               end # build
            end # Phone

         end
      end
   end
end
