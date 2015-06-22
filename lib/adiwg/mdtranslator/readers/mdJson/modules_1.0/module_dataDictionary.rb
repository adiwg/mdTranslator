# unpack a data dictionary
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2014-12-01 original script
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)

require $ReaderNS.readerModule('module_dictionaryInfo')
require $ReaderNS.readerModule('module_domain')
require $ReaderNS.readerModule('module_entity')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module DataDictionary

                    def self.unpack(hDictionary, responseObj)

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intDict = intMetadataClass.newDataDictionary

                        unless hDictionary.empty?

                            # data dictionary - dictionary information
                            if hDictionary.has_key?('dictionaryInfo')
                                hDictInfo = hDictionary['dictionaryInfo']
                                intDict[:dictionaryInfo] = $ReaderNS::DictionaryInfo.unpack(hDictInfo, responseObj)
                            end

                            # data dictionary - domains
                            if hDictionary.has_key?('domain')
                                aDomains = hDictionary['domain']
                                aDomains.each do |hDomain|
                                    unless hDomain.empty?
                                        intDict[:domains] << $ReaderNS::Domain.unpack(hDomain, responseObj)
                                    end
                                end
                            end

                            # data dictionary - entity
                            if hDictionary.has_key?('entity')
                                aEntities = hDictionary['entity']
                                aEntities.each do |hEntity|
                                    unless hEntity.empty?
                                        intDict[:entities] << $ReaderNS::Entity.unpack(hEntity, responseObj)
                                    end
                                end
                            end

                            return intDict

                        end

                    end

                end
            end
        end
    end
end