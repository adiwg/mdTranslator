# unpack dimension
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2015-07-30 original script

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Dimension

                    def self.unpack(hDimInfo, responseObj)

                        # return nil object if input is empty
                        intDim = nil
                        return if hDimInfo.empty?

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intDim = intMetadataClass.newDimensionInfo

                        # dimension information - type of dimension - required
                        if hDimInfo.has_key?('dimensionType')
                            s = hDimInfo['dimensionType']
                            if s != ''
                                intDim[:dimensionType] = s
                            end
                        end

                        # dimension information - number of elements along the axis - required
                        if hDimInfo.has_key?('dimensionSize')
                            s = hDimInfo['dimensionSize']
                            if s != ''
                                intDim[:dimensionSize] = s
                            end
                        end

                        # dimension information - degree of detail in the grid
                        if hDimInfo.has_key?('resolution')
                            s = hDimInfo['resolution']
                            if s != ''
                                intDim[:resolution] = s
                            end
                        end

                        # dimension information - units for resolutioni
                        if hDimInfo.has_key?('resolutionUnit')
                            s = hDimInfo['resolutionUnit']
                            if s != ''
                                intDim[:resolutionUnits] = s
                            end
                        end

                        # dimension information - title for the axis
                        if hDimInfo.has_key?('dimensionTitle')
                            s = hDimInfo['dimensionTitle']
                            if s != ''
                                intDim[:dimensionTitle] = s
                            end
                        end

                        # dimension information - definition of the title
                        if hDimInfo.has_key?('dimensionDescription')
                            s = hDimInfo['dimensionDescription']
                            if s != ''
                                intDim[:dimensionDescription] = s
                            end
                        end

                        return intDim

                    end

                end

            end
        end
    end
end
