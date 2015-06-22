# unpack metadata information block
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2014-04-24 original script - moved from module_metadata
#   Stan Smith 2014-07-03 resolve require statements using Mdtranslator.reader_module
#   Stan Smith 2014-09-19 changed metadata identifier type resource identifier json 0.8.0
#   Stan Smith 2014-09-19 changed parent metadata identifier type citation json 0.8.0
#   Stan Smith 2014-11-06 removed metadataScope, moved to resourceType under resourceInfo json 0.9.0
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-12 added support for metadataCharacterSet
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)

require $ReaderNS.readerModule('module_responsibleParty')
require $ReaderNS.readerModule('module_dateTime')
require $ReaderNS.readerModule('module_resourceMaintenance')
require $ReaderNS.readerModule('module_metadataExtension')
require $ReaderNS.readerModule('module_resourceIdentifier')
require $ReaderNS.readerModule('module_citation')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module MetadataInfo

                    def self.unpack(hMetadata, responseObj)

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intMetadataInfo = intMetadataClass.newMetadataInfo
                        hMetadataInfo = hMetadata['metadataInfo']

                        # metadata - metadata identifier
                        if hMetadataInfo.has_key?('metadataIdentifier')
                            hMetadataId = hMetadataInfo['metadataIdentifier']
                            unless hMetadataId.empty?
                                intMetadataInfo[:metadataId] = $ReaderNS::ResourceIdentifier.unpack(hMetadataId, responseObj)
                            end
                        end

                        # metadata - parent metadata identifier
                        if hMetadataInfo.has_key?('parentMetadata')
                            hParent = hMetadataInfo['parentMetadata']
                            unless hParent.empty?
                                intMetadataInfo[:parentMetadata] = $ReaderNS::Citation.unpack(hParent, responseObj)
                            end
                        end

                        # metadata - metadata contacts, custodians
                        if hMetadataInfo.has_key?('metadataContact')
                            aCust = hMetadataInfo['metadataContact']
                            unless aCust.empty?
                                aCust.each do |rParty|
                                    intMetadataInfo[:metadataCustodians] << $ReaderNS::ResponsibleParty.unpack(rParty, responseObj)
                                end
                            end
                        end

                        # metadata - creation date
                        if hMetadataInfo.has_key?('metadataCreationDate')
                            s = hMetadataInfo['metadataCreationDate']
                            if s != ''
                                hDateTime = $ReaderNS::DateTime.unpack(s, responseObj)
                                hDateTime[:dateType] = 'publication'
                                intMetadataInfo[:metadataCreateDate] = hDateTime
                            end
                        end

                        # metadata - date of last metadata update
                        if hMetadataInfo.has_key?('metadataLastUpdate')
                            s = hMetadataInfo['metadataLastUpdate']
                            if s != ''
                                hDateTime = $ReaderNS::DateTime.unpack(s, responseObj)
                                hDateTime[:dateType] = 'revision'
                                intMetadataInfo[:metadataUpdateDate] = hDateTime
                            end
                        end

                        # metadata - characterSet - default 'utf8'
                        if hMetadataInfo.has_key?('metadataCharacterSet')
                            s = hMetadataInfo['metadataCharacterSet']
                            if s != ''
                                intMetadataInfo[:metadataCharacterSet] = s
                            end
                        end

                        # metadata - metadata URI
                        if hMetadataInfo.has_key?('metadataUri')
                            s = hMetadataInfo['metadataUri']
                            if s != ''
                                intMetadataInfo[:metadataURI] = s
                            end
                        end

                        # metadata - status
                        if hMetadataInfo.has_key?('metadataStatus')
                            s = hMetadataInfo['metadataStatus']
                            if s != ''
                                intMetadataInfo[:metadataStatus] = s
                            end
                        end

                        # metadata - metadata maintenance info
                        if hMetadataInfo.has_key?('metadataMaintenance')
                            hMetaMaint = hMetadataInfo['metadataMaintenance']
                            unless hMetaMaint.empty?
                                intMetadataInfo[:maintInfo] = $ReaderNS::ResourceMaintenance.unpack(hMetaMaint, responseObj)
                            end
                        end

                        # metadata - extension info - if biological extension
                        if hMetadata.has_key?('resourceInfo')
                            resourceInfo = hMetadata['resourceInfo']
                            if resourceInfo.has_key?('taxonomy')
                                hTaxonomy = resourceInfo['taxonomy']
                                unless hTaxonomy.empty?
                                    intMetadataInfo[:extensions] << $ReaderNS::MetadataExtension.addExtensionISObio(responseObj)
                                end
                            end
                        end

                        return intMetadataInfo

                    end

                end

            end
        end
    end
end
