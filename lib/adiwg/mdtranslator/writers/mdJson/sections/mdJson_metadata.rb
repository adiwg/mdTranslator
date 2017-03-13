# mdJson 2.0 writer - metadata

# History:
#   Stan Smith 2017-03-11 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

# TODO complete

require 'jbuilder'
require_relative 'mdJson_metadataInfo'
require_relative 'mdJson_resourceInfo'
# require_relative 'mdJson_distributionInfo'
# require_relative 'mdJson_associatedResource'
# require_relative 'mdJson_additionalDoc'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Metadata

               def self.build(hMetadata)

                  Jbuilder.new do |json|
                     json.metadataInfo MetadataInfo.build(hMetadata[:metadataInfo])
                     json.resourceInfo ResourceInfo.build(hMetadata[:resourceInfo])
                     # json.distributionInfo json_map(hMetadata[:distributorInfo], DistributionInfo)
                     # json.associatedResource json_map(hMetadata[:associatedResources], AssociatedResource)
                     # json.additionalDocumentation json_map(hMetadata[:additionalDocuments], AdditionalDoc)
                  end

               end # build
            end # Metadata

         end
      end
   end
end
