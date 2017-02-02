# unpack an data entity attribute
# Reader - ADIwg JSON V1 to internal data structure

# History:
#   Stan Smith 2016-10-05 refactored for mdJson 2.0
#   Stan Smith 2015-07-24 added error reporting of missing items
#   Stan Smith 2015-07-14 refactored to remove global namespace constants
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-02-17 added support for attribute aliases
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
# 	Stan Smith 2013-12-01 original script

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module EntityAttribute

                    def self.unpack(hAttribute, responseObj)

                        # return nil object if input is empty
                        if hAttribute.empty?
                            responseObj[:readerExecutionMessages] << 'Entity Attribute object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intAttribute = intMetadataClass.newEntityAttribute

                        # attribute - common name
                        if hAttribute.has_key?('commonName')
                            if hAttribute['commonName'] != ''
                                intAttribute[:attributeName] = hAttribute['commonName']
                            end
                        end

                        # attribute - code name (required)
                        if hAttribute.has_key?('codeName')
                            intAttribute[:attributeCode] = hAttribute['codeName']
                        end
                        if intAttribute[:attributeCode].nil? || intAttribute[:attributeCode] == ''
                            responseObj[:readerExecutionMessages] << 'Data Dictionary attribute code name is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # attribute - alias []
                        if hAttribute.has_key?('alias')
                            hAttribute['alias'].each do |item|
                                if item != ''
                                    intAttribute[:attributeAlias] << item
                                end
                            end
                        end

                        # attribute - definition (required)
                        if hAttribute.has_key?('definition')
                            intAttribute[:attributeDefinition] = hAttribute['definition']
                        end
                        if intAttribute[:attributeDefinition].nil? || intAttribute[:attributeDefinition] == ''
                            responseObj[:readerExecutionMessages] << 'Data Dictionary attribute definition is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # attribute - data type (required)
                        if hAttribute.has_key?('dataType')
                            intAttribute[:dataType] = hAttribute['dataType']
                        end
                        if intAttribute[:dataType].nil? || intAttribute[:dataType] == ''
                            responseObj[:readerExecutionMessages] << 'Data Dictionary attribute data type is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # attribute - minimum cardinality (required)
                        if hAttribute.has_key?('allowNull')
                            if hAttribute['allowNull'] === true
                                intAttribute[:allowNull] = hAttribute['allowNull']
                            end
                        end

                        # attribute - maximum cardinality
                        if hAttribute.has_key?('allowMany')
                            if hAttribute['allowMany'] === true
                                intAttribute[:allowMany] = hAttribute['allowMany']
                            end
                        end

                        # attribute - units of measure
                        if hAttribute.has_key?('units')
                            if hAttribute['units'] != ''
                                intAttribute[:unitOfMeasure] = hAttribute['units']
                            end
                        end

                        # attribute - domain ID
                        if hAttribute.has_key?('domainId')
                            if hAttribute['domainId'] != ''
                                intAttribute[:domainId] = hAttribute['domainId']
                            end
                        end

                        # attribute - minimum value
                        if hAttribute.has_key?('minValue')
                            if hAttribute['minValue'] != ''
                                intAttribute[:minValue] = hAttribute['minValue']
                            end
                        end

                        # attribute - maximum value
                        if hAttribute.has_key?('maxValue')
                            if hAttribute['maxValue'] != ''
                                intAttribute[:maxValue] = hAttribute['maxValue']
                            end
                        end

                        return intAttribute

                    end

                end

            end
        end
    end
end
