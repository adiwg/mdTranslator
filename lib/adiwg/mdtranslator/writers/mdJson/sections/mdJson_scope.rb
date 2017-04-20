# mdJson 2.0 writer - scope

# History:
#   Stan Smith 2017-03-12 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'
require_relative 'mdJson_scopeDescription'
require_relative 'mdJson_extent'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Scope

               @Namespace = ADIWG::Mdtranslator::Writers::MdJson

               def self.build(hScope)

                  Jbuilder.new do |json|
                     json.scopeCode hScope[:scopeCode]
                     json.scopeDescription @Namespace.json_map(hScope[:scopeDescriptions], ScopeDescription)
                     json.scopeExtent @Namespace.json_map(hScope[:extents], Extent)
                  end

               end # build
            end # Scope

         end
      end
   end
end
