# unpack a data dictionary entity
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-12-01 original script
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2015-02-17 add entity aliases
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to remove global namespace constants
#   Stan Smith 2015-07-24 added error reporting of missing items

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_entityIndex')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_entityAttribute')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_entityForeignKey')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Entity

                    def self.unpack(hEntity, responseObj)

                        # return nil object if input is empty
                        intEntity = nil
                        return if hEntity.empty?

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intEntity = intMetadataClass.newEntity

                        # data entity - id
                        if hEntity.has_key?('entityId')
                            s = hEntity['entityId']
                            if s != ''
                                intEntity[:entityId] = s
                            else
                                responseObj[:readerExecutionMessages] << 'Data Dictionary entity ID is missing'
                                responseObj[:readerExecutionPass] = false
                                return nil
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
                            else
                                responseObj[:readerExecutionMessages] << 'Data Dictionary entity code name is missing'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        end

                        # data entity - alias []
                        if hEntity.has_key?('alias')
                            a = hEntity['alias']
                            unless a.empty?
                                intEntity[:entityAlias] = a
                            end
                        end

                        # data entity - definition
                        if hEntity.has_key?('definition')
                            s = hEntity['definition']
                            if s != ''
                                intEntity[:entityDefinition] = s
                            else
                                responseObj[:readerExecutionMessages] << 'Data Dictionary entity definition is missing'
                                responseObj[:readerExecutionPass] = false
                                return nil
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
                                    intEntity[:indexes] << EntityIndex.unpack(hIndex, responseObj)
                                end
                            end
                        end

                        # data entity - attributes []
                        if hEntity.has_key?('attribute')
                            aAttributes = hEntity['attribute']
                            aAttributes.each do |hAttribute|
                                unless hAttribute.empty?
                                    intEntity[:attributes] << EntityAttribute.unpack(hAttribute, responseObj)
                                end
                            end
                        end

                        # data entity - foreign keys []
                        if hEntity.has_key?('foreignKey')
                            aFKeys = hEntity['foreignKey']
                            aFKeys.each do |hFKey|
                                unless hFKey.empty?
                                    intEntity[:foreignKeys] << EntityForeignKey.unpack(hFKey, responseObj)
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
