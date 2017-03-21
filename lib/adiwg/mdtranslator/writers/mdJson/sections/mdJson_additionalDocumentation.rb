# mdJson 2.0 writer - additional documentation

# History:
#   Stan Smith 2017-03-11 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'
require_relative 'mdJson_resourceType'
require_relative 'mdJson_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module AdditionalDocument

               @Namespace = ADIWG::Mdtranslator::Writers::MdJson

               def self.build(hDocument)

                  Jbuilder.new do |json|
                     json.resourceType @Namespace.json_map(hDocument[:resourceTypes], ResourceType)
                     json.citation @Namespace.json_map(hDocument[:citation], Citation)
                  end

               end # build
            end # AdditionalDocument

         end
      end
   end
end
