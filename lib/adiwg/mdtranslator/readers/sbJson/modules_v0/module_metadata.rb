require 'uri'
require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_metadataInfo')
require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_resourceInfo')
require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_distributionInfo')
# require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_associatedResource')
require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_additionalDocumentation')
# require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_citation')

module ADIWG
    module Mdtranslator
        module Readers
            module SbJson
                module Metadata
                    def self.unpack(hMetadata, responseObj, intObj)
                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intMetadata = intMetadataClass.newMetadata

                        # metadata - metadataInfo
                        intMetadata[:metadataInfo] = MetadataInfo.unpack(hMetadata, responseObj, intObj)

                        # metadata - resource identification info
                        intMetadata[:resourceInfo] = ResourceInfo.unpack(hMetadata, responseObj, intObj)

                        # metadata - distribution info
                        if hMetadata.key?('webLinks')
                            intMetadata[:distributorInfo] << DistributionInfo.unpack(hMetadata, responseObj, intObj)
                        end

                        # metadata - associated resources
                        # if hMetadata.has_key?('associatedResource')
                        #     aAssocRes = hMetadata['associatedResource']
                        #     unless aAssocRes.empty?
                        #         aAssocRes.each do |hAssocRes|
                        #             intMetadata[:associatedResources] << AssociatedResource.unpack(hAssocRes, responseObj)
                        #         end
                        #     end
                        # end

                        # metadata - additional documents
                        if hMetadata.key?('webLinks')
                            aAddDocs = hMetadata['webLinks']
                            unless aAddDocs.empty?
                                aAddDocs.each do |hAddDoc|
                                    doc = {
                                        'resourceType' => hAddDoc['type'],
                                        'citation' => {
                                            'title' => hAddDoc['title'],
                                            'onlineResource' => [
                                                {
                                                    'uri' => hAddDoc['uri'],
                                                    'protocol' => URI.parse(hAddDoc['uri']).scheme,
                                                    'name' => hAddDoc['title'],
                                                    'function' => hAddDoc['type']
                                                }
                                            ]
                                        }
                                    }
                                    intMetadata[:additionalDocuments] << AdditionalDocumentation.unpack(doc, responseObj)
                                end
                            end
                        end

                        intMetadata
                    end
                end
            end
        end
    end
end
