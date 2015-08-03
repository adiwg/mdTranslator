# unpack raster attribute group
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2015-08-03 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_rasterAttribute')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module RasterAttributeGroup

                    def self.unpack(hRasterAttGrp, responseObj)

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        hIntRAGroup = intMetadataClass.newRasterAttributeGroup

                        # raster attribute group - content type
                        if hRasterAttGrp.has_key?('contentType')
                            aConType = hRasterAttGrp['contentType']
                            if !aConType.empty?
                                hIntRAGroup[:rasterAttributeGroupContents] = aConType
                            end
                        end

                        # raster attribute group - attributes
                        if hRasterAttGrp.has_key?('attribute')
                            aAttributes = hRasterAttGrp['attribute']
                            if !aAttributes.empty?
                                aAttributes.each do |hAttribute|
                                    hIntRAGroup[:rasterAttributes] << RasterAttribute.unpack(hAttribute, responseObj)
                                end
                            end
                        end

                        return hIntRAGroup

                    end

                end

            end
        end
    end
end
