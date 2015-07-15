# unpack an data entity attribute
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-12-01 original script
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2015-02-17 added support for attribute aliases
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to remove global namespace constants

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module EntityAttribute

                    def self.unpack(hAttribute, responseObj)

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intAttribute = intMetadataClass.newEntityAttribute

                        # attribute - common name
                        if hAttribute.has_key?('commonName')
                            s = hAttribute['commonName']
                            if s != ''
                                intAttribute[:attributeName] = s
                            end
                        end

                        # attribute - code name
                        if hAttribute.has_key?('codeName')
                            s = hAttribute['codeName']
                            if s != ''
                                intAttribute[:attributeCode] = s
                            end
                        end

                        # attribute - alias []
                        if hAttribute.has_key?('alias')
                            a = hAttribute['alias']
                            unless a.empty?
                                intAttribute[:attributeAlias] = a
                            end
                        end

                        # attribute - definition
                        if hAttribute.has_key?('definition')
                            s = hAttribute['definition']
                            if s != ''
                                intAttribute[:attributeDefinition] = s
                            end
                        end

                        # attribute - data type
                        if hAttribute.has_key?('dataType')
                            s = hAttribute['dataType']
                            if s != ''
                                intAttribute[:dataType] = s
                            end
                        end

                        # attribute - required attribute?
                        if hAttribute.has_key?('allowNull')
                            s = hAttribute['allowNull']
                            if s != ''
                                intAttribute[:allowNull] = s
                            end
                        end

                        # attribute - units of measure
                        if hAttribute.has_key?('units')
                            s = hAttribute['units']
                            if s != ''
                                intAttribute[:unitOfMeasure] = s
                            end
                        end

                        # attribute - domain ID
                        if hAttribute.has_key?('domainId')
                            s = hAttribute['domainId']
                            if s != ''
                                intAttribute[:domainId] = s
                            end
                        end

                        # attribute - minimum value
                        if hAttribute.has_key?('minValue')
                            s = hAttribute['minValue']
                            if s != ''
                                intAttribute[:minValue] = s
                            end
                        end

                        # attribute - maximum value
                        if hAttribute.has_key?('maxValue')
                            s = hAttribute['maxValue']
                            if s != ''
                                intAttribute[:maxValue] = s
                            end
                        end

                        return intAttribute

                    end

                end

            end
        end
    end
end
