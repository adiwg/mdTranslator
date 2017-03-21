# mdJson 2.0 writer - associated resource

# History:
#   Stan Smith 2017-03-20 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'
require_relative 'mdJson_resourceType'
require_relative 'mdJson_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module AssociatedResource

               @Namespace = ADIWG::Mdtranslator::Writers::MdJson

               def self.build(hResource)

                  Jbuilder.new do |json|
                     json.associationType hResource[:associationType]
                     json.initiativeType hResource[:initiativeType]
                     json.resourceType @Namespace.json_map(hResource[:resourceTypes], ResourceType)
                     json.resourceCitation Citation.build(hResource[:resourceCitation]) unless hResource[:resourceCitation].empty?
                     json.metadataCitation Citation.build(hResource[:metadataCitation]) unless hResource[:metadataCitation].empty?
                  end

               end # build
            end # Associated Resource

         end
      end
   end
end
