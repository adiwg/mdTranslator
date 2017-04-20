# mdJson 2.0 writer - metadataRepository

# History:
#   Stan Smith 2017-03-11 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Repository

               def self.build(hRepository)

                  Jbuilder.new do |json|
                     json.repository hRepository[:repository]
                     json.metadataStandard hRepository[:metadataStandard]
                  end

               end # build
            end # Repository

         end
      end
   end
end
