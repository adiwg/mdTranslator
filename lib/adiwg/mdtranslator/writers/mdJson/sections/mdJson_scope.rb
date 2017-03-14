# mdJson 2.0 writer - scope

# History:
#   Stan Smith 2017-03-12 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

# TODO complete

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Scope

               def self.build(hScope)

                  Jbuilder.new do |json|
                     json.scopeCode hScope[:scopeCode]
                     #json.scopeDescription hScope[:scopeDescriptions]
                     #json.scopeExtent hScope[:extents]
                  end

               end # build
            end # Scope

         end
      end
   end
end
