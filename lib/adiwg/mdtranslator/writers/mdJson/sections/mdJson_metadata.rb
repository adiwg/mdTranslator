require 'jbuilder'

require_relative 'mdJson_base'
require_relative 'mdJson_metadataInfo'
require_relative 'mdJson_resourceInfo'
require_relative 'mdJson_distributionInfo'
require_relative 'mdJson_associatedResource'
require_relative 'mdJson_additionalDoc'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module Metadata
          extend MdJson::Base

          def self.build(metadata)
            Jbuilder.new do |json|
              json.metadataInfo MetadataInfo.build(metadata[:metadataInfo])
              json.resourceInfo ResourceInfo.build(metadata[:resourceInfo])
              json.distributionInfo json_map(metadata[:distributorInfo], DistributionInfo)
              json.associatedResource json_map(metadata[:associatedResources], AssociatedResource)
              json.additionalDocumentation json_map(metadata[:additionalDocuments], AdditionalDoc)
            end
          end
        end
      end
    end
  end
end
