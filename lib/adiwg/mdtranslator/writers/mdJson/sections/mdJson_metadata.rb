# mdJson 2.0 writer - metadata

# History:
#   Stan Smith 2017-03-11 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

# TODO complete

require 'jbuilder'
require_relative 'mdJson_metadataInfo'
require_relative 'mdJson_resourceInfo'
require_relative 'mdJson_lineageInfo'
require_relative 'mdJson_distribution'
require_relative 'mdJson_associatedResource'
require_relative 'mdJson_additionalDocumentation'
require_relative 'mdJson_funding'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Metadata

               @Namespace = ADIWG::Mdtranslator::Writers::MdJson

               def self.build(hMetadata)

                  Jbuilder.new do |json|
                     json.metadataInfo MetadataInfo.build(hMetadata[:metadataInfo])
                     json.resourceInfo ResourceInfo.build(hMetadata[:resourceInfo])
                     json.resourceLineage @Namespace.json_map(hMetadata[:lineageInfo], LineageInfo)
                     json.resourceDistribution @Namespace.json_map(hMetadata[:distributorInfo], Distribution)
                     json.associatedResource @Namespace.json_map(hMetadata[:associatedResources], AssociatedResource)
                     json.additionalDocumentation @Namespace.json_map(hMetadata[:additionalDocuments], AdditionalDocument)
                     json.funding @Namespace.json_map(hMetadata[:funding], Funding)
                  end

               end # build
            end # Metadata

         end
      end
   end
end
