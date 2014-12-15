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

require $ReaderNS.readerModule('module_metadataInfo')
require $ReaderNS.readerModule('module_resourceInfo')
require $ReaderNS.readerModule('module_distributionInfo')
require $ReaderNS.readerModule('module_associatedResource')
require $ReaderNS.readerModule('module_additionalDocumentation')
require $ReaderNS.readerModule('module_citation')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Metadata

                    def self.unpack(hMetadata)

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intMetadata = intMetadataClass.newMetadata

                        # metadata - metadataInfo
                        # metadataInfo needs access to resourceInfo to check taxonomy
                        if hMetadata.has_key?('metadataInfo')
                            intMetadata[:metadataInfo] = $ReaderNS::MetadataInfo.unpack(hMetadata)
                        end

                        # metadata - resource identification info
                        if hMetadata.has_key?('resourceInfo')
                            hResourceInfo = hMetadata['resourceInfo']
                            intMetadata[:resourceInfo] = $ReaderNS::ResourceInfo.unpack(hResourceInfo)
                        end

                        # metadata - distribution info
                        if hMetadata.has_key?('distributionInfo')
                            aDistributors = hMetadata['distributionInfo']
                            unless aDistributors.empty?
                                aDistributors.each do |hDistributor|
                                    intMetadata[:distributorInfo] << $ReaderNS::DistributionInfo.unpack(hDistributor)
                                end
                            end
                        end

                        # metadata - associated resources
                        if hMetadata.has_key?('associatedResource')
                            aAssocRes = hMetadata['associatedResource']
                            unless aAssocRes.empty?
                                aAssocRes.each do |hAssocRes|
                                    intMetadata[:associatedResources] << $ReaderNS::AssociatedResource.unpack(hAssocRes)
                                end
                            end
                        end

                        # metadata - additional documents
                        if hMetadata.has_key?('additionalDocumentation')
                            aAddDocs = hMetadata['additionalDocumentation']
                            unless aAddDocs.empty?
                                aAddDocs.each do |hAddDoc|
                                    intMetadata[:additionalDocuments] << $ReaderNS::AdditionalDocumentation.unpack(hAddDoc)
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
