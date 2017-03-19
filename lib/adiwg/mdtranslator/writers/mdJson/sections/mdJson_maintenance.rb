# mdJson 2.0 writer - maintenance

# History:
#   Stan Smith 2017-03-13 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'
require_relative 'mdJson_dateTime'
require_relative 'mdJson_scope'
require_relative 'mdJson_responsibleParty'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Maintenance

               @Namespace = ADIWG::Mdtranslator::Writers::MdJson

               def self.build(hMaint)

                  Jbuilder.new do |json|
                     json.frequency hMaint[:frequency]
                     json.date @Namespace.json_map(hMaint[:dates], DateTime)
                     json.scope @Namespace.json_map(hMaint[:scopes], Scope)
                     json.note hMaint[:notes] unless hMaint[:notes].empty?
                     json.contact @Namespace.json_map(hMaint[:contacts], ResponsibleParty)
                  end

               end # build
            end # Maintenance

         end
      end
   end
end
