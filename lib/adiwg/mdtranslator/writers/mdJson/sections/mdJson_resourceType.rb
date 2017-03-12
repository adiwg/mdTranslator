# mdJson 2.0 writer - resourceType

# History:
#   Stan Smith 2017-03-11 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module ResourceType

               def self.build(hResType)

                  Jbuilder.new do |json|
                     json.type hResType[:type]
                     json.name hResType[:name]
                  end

               end # build
            end # ResourceType

         end
      end
   end
end
