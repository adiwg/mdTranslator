# mdJson 2.0 writer - scope description

# History:
#   Stan Smith 2017-03-18 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module ScopeDescription

               def self.build(hScopeDesc)

                  Jbuilder.new do |json|
                     json.dataset hScopeDesc[:dataset]
                     json.attributes hScopeDesc[:attributes]
                     json.features hScopeDesc[:features]
                     json.other hScopeDesc[:other]
                  end

               end # build
            end # ScopeDescription

         end
      end
   end
end
