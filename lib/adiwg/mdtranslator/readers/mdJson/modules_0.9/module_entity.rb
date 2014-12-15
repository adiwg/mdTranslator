# unpack a data dictionary entity
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-12-01 original script
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers

require $ReaderNS.readerModule('module_entityIndex')
require $ReaderNS.readerModule('module_entityAttribute')
require $ReaderNS.readerModule('module_entityForeignKey')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Entity

                    def self.unpack(hEntity)

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intEntity = intMetadataClass.newEntity

                        # data entity - id
                        if hEntity.has_key?('entityId')
                            s = hEntity['entityId']
                            if s != ''
                                intEntity[:entityId] = s
                            end
                        end

                        # data entity - name
                        if hEntity.has_key?('commonName')
                            s = hEntity['commonName']
                            if s != ''
                                intEntity[:entityName] = s
                            end
                        end

                        # data entity - code
                        if hEntity.has_key?('codeName')
                            s = hEntity['codeName']
                            if s != ''
                                intEntity[:entityCode] = s
                            end
                        end

                        # data entity - definition
                        if hEntity.has_key?('definition')
                            s = hEntity['definition']
                            if s != ''
                                intEntity[:entityDefinition] = s
                            end
                        end

                        # data entity - primary key
                        if hEntity.has_key?('primaryKeyAttributeCodeName')
                            aKeyAttributes = hEntity['primaryKeyAttributeCodeName']
                            unless aKeyAttributes.empty?
                                intEntity[:primaryKey] = aKeyAttributes
                            end
                        end

                        # data entity - indexes []
                        if hEntity.has_key?('index')
                            aIndexes = hEntity['index']
                            aIndexes.each do |hIndex|
                                unless hIndex.empty?
                                    intEntity[:indexes] << $ReaderNS::EntityIndex.unpack(hIndex)
                                end
                            end
                        end

                        # data entity - attributes []
                        if hEntity.has_key?('attribute')
                            aAttributes = hEntity['attribute']
                            aAttributes.each do |hAttribute|
                                unless hAttribute.empty?
                                    intEntity[:attributes] << $ReaderNS::EntityAttribute.unpack(hAttribute)
                                end
                            end
                        end

                        # data entity - foreign keys []
                        if hEntity.has_key?('foreignKey')
                            aFKeys = hEntity['foreignKey']
                            aFKeys.each do |hFKey|
                                unless hFKey.empty?
                                    intEntity[:foreignKeys] << $ReaderNS::EntityForeignKey.unpack(hFKey)
                                end
                            end
                        end

                        return intEntity
                    end

                end

            end
        end
    end
end
