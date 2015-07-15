# unpack metadata
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-08-22 original script
#   Stan Smith 2013-09-23 added distributor info section
#   Stan Smith 2013-11-26 added metadata maintenance section
#   Stan Smith 2013-11-26 added hierarchy section
#   Stan Smith 2013-11-26 added data quality section
#   Stan Smith 2013-12-27 added parent identifier
#   Stan Smith 2014-04-24 reorganized for json schema 0.3.0
#   Stan Smith 2014-05-02 added associated resources
#   Stan Smith 2014-05-02 added additional documentation
#   Stan Smith 2014-07-03 resolve require statements using Mdtranslator.reader_module
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to remove global namespace constants

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_metadataInfo')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_resourceInfo')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_distributionInfo')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_associatedResource')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_additionalDocumentation')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_citation')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Metadata

                    def self.unpack(hMetadata, responseObj)

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intMetadata = intMetadataClass.newMetadata

                        # metadata - metadataInfo
                        # metadataInfo needs access to resourceInfo to check taxonomy
                        if hMetadata.has_key?('metadataInfo')
                            intMetadata[:metadataInfo] = MetadataInfo.unpack(hMetadata,responseObj)
                        end

                        # metadata - resource identification info
                        if hMetadata.has_key?('resourceInfo')
                            hResourceInfo = hMetadata['resourceInfo']
                            intMetadata[:resourceInfo] = ResourceInfo.unpack(hResourceInfo, responseObj)
                        end

                        # metadata - distribution info
                        if hMetadata.has_key?('distributionInfo')
                            aDistributors = hMetadata['distributionInfo']
                            unless aDistributors.empty?
                                aDistributors.each do |hDistributor|
                                    intMetadata[:distributorInfo] << DistributionInfo.unpack(hDistributor, responseObj)
                                end
                            end
                        end

                        # metadata - associated resources
                        if hMetadata.has_key?('associatedResource')
                            aAssocRes = hMetadata['associatedResource']
                            unless aAssocRes.empty?
                                aAssocRes.each do |hAssocRes|
                                    intMetadata[:associatedResources] << AssociatedResource.unpack(hAssocRes, responseObj)
                                end
                            end
                        end

                        # metadata - additional documents
                        if hMetadata.has_key?('additionalDocumentation')
                            aAddDocs = hMetadata['additionalDocumentation']
                            unless aAddDocs.empty?
                                aAddDocs.each do |hAddDoc|
                                    intMetadata[:additionalDocuments] << AdditionalDocumentation.unpack(hAddDoc, responseObj)
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
