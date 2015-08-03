# unpack raster attribute
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2015-08-03 original script

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module RasterAttribute

                    def self.unpack(hRAttribute, responseObj)

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        hRAtt = intMetadataClass.newRasterAttribute

                        # raster attribute - attribute name
                        if hRAttribute.has_key?('attributeName')
                            s = hRAttribute['attributeName']
                            if s != ''
                                hRAtt[:attributeName] = s
                            end
                        end

                        # raster attribute - attribute type
                        if hRAttribute.has_key?('attributeType')
                            s = hRAttribute['attributeType']
                            if s != ''
                                hRAtt[:attributeType] = s
                            end
                        end

                        # raster attribute - attribute description
                        if hRAttribute.has_key?('description')
                            s = hRAttribute['description']
                            if s != ''
                                hRAtt[:attributeDescription] = s
                            end
                        end

                        # raster attribute - number of attribute values
                        if hRAttribute.has_key?('numberOfValues')
                            s = hRAttribute['numberOfValues']
                            if s != ''
                                hRAtt[:numberOfValue] = s
                            end
                        end

                        # raster attribute - maximum attribute values
                        if hRAttribute.has_key?('maxValue')
                            s = hRAttribute['maxValue']
                            if s != ''
                                hRAtt[:maxValue] = s
                            end
                        end

                        # raster attribute - minimum attribute values
                        if hRAttribute.has_key?('minValue')
                            s = hRAttribute['minValue']
                            if s != ''
                                hRAtt[:minValue] = s
                            end
                        end

                        # raster attribute - attribute value units
                        if hRAttribute.has_key?('units')
                            s = hRAttribute['units']
                            if s != ''
                                hRAtt[:units] = s
                            end
                        end

                        return hRAtt

                    end

                end

            end
        end
    end
end
