# mdJson 2.0 writer - responsible party

# History:
#   Stan Smith 2017-03-11 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'
require_relative 'mdJson_extent'
require_relative 'mdJson_party'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module ResponsibleParty

               @Namespace = ADIWG::Mdtranslator::Writers::MdJson

               def self.build(hResParty)

                  Jbuilder.new do |json|
                     json.role hResParty[:roleName]
                     json.roleExtent @Namespace.json_map(hResParty[:roleExtents], Extent)
                     json.party @Namespace.json_map(hResParty[:parties], Party)
                  end

               end # build
            end # ResponsibleParty

         end
      end
   end
end
