# unpack metadata
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-21 refactored error and warning messaging
#  Stan Smith 2016-11-02 original script

require_relative 'module_metadataInfo'
require_relative 'module_resourceInfo'
require_relative 'module_lineage'
require_relative 'module_distribution'
require_relative 'module_associatedResource'
require_relative 'module_additionalDocumentation'
require_relative 'module_funding'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module Metadata

               def self.unpack(hMetadata, responseObj)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hMetadata.empty?
                     @MessagePath.issueWarning(560, responseObj)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intMetadata = intMetadataClass.newMetadata

                  # metadata - metadata info {metadataInfo} (required)
                  if hMetadata.has_key?('metadataInfo')
                     hObject = hMetadata['metadataInfo']
                     unless hObject.empty?
                        hReturn = MetadataInfo.unpack(hObject, responseObj)
                        unless hReturn.nil?
                           intMetadata[:metadataInfo] = hReturn
                        end
                     end
                  end
                  if intMetadata[:metadataInfo].empty?
                     @MessagePath.issueError(561, responseObj)
                  end

                  # metadata - resource info {resourceInfo} (required)
                  if hMetadata.has_key?('resourceInfo')
                     hObject = hMetadata['resourceInfo']
                     unless hObject.empty?
                        hReturn = ResourceInfo.unpack(hObject, responseObj)
                        unless hReturn.nil?
                           intMetadata[:resourceInfo] = hReturn
                        end
                     end
                  end
                  if intMetadata[:resourceInfo].empty?
                     @MessagePath.issueError(562, responseObj)
                  end

                  # metadata - resource lineage [] {lineage}
                  if hMetadata.has_key?('resourceLineage')
                     aItems = hMetadata['resourceLineage']
                     aItems.each do |item|
                        hReturn = ResourceLineage.unpack(item, responseObj)
                        unless hReturn.nil?
                           intMetadata[:lineageInfo] << hReturn
                        end
                     end
                  end

                  # metadata - resource distribution [] {distribution}
                  if hMetadata.has_key?('resourceDistribution')
                     aItems = hMetadata['resourceDistribution']
                     aItems.each do |item|
                        hReturn = Distribution.unpack(item, responseObj)
                        unless hReturn.nil?
                           intMetadata[:distributorInfo] << hReturn
                        end
                     end
                  end

                  # metadata - associated resource [] {associatedResource}
                  if hMetadata.has_key?('associatedResource')
                     aItems = hMetadata['associatedResource']
                     aItems.each do |item|
                        hReturn = AssociatedResource.unpack(item, responseObj)
                        unless hReturn.nil?
                           intMetadata[:associatedResources] << hReturn
                        end
                     end
                  end

                  # metadata - additional resource [] {additionalResource}
                  if hMetadata.has_key?('additionalDocumentation')
                     aItems = hMetadata['additionalDocumentation']
                     aItems.each do |item|
                        hReturn = AdditionalDocumentation.unpack(item, responseObj)
                        unless hReturn.nil?
                           intMetadata[:additionalDocuments] << hReturn
                        end
                     end
                  end

                  # metadata - funding [] {funding}
                  if hMetadata.has_key?('funding')
                     aItems = hMetadata['funding']
                     aItems.each do |item|
                        hReturn = Funding.unpack(item, responseObj)
                        unless hReturn.nil?
                           intMetadata[:funding] << hReturn
                        end
                     end
                  end

                  return intMetadata

               end

            end

         end
      end
   end
end
