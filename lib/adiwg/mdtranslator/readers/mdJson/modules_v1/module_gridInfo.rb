# unpack gridInfo
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2015-07-30 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_dimension')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module GridInfo

                    def self.unpack(hGridInfo, responseObj)

                        # return nil object if input is empty
                        intGrid = nil
                        return if hGridInfo.empty?

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intGrid = intMetadataClass.newGridInfo

                        # grid information - number of dimensions
                        if hGridInfo.has_key?('numberOfDimensions')
                            s = hGridInfo['numberOfDimensions']
                            if s != ''
                                intGrid[:dimensions] = s
                            end
                        end

                        # grid information - dimension information
                        if hGridInfo.has_key?('dimension')
                            aDims = hGridInfo['dimension']
                            aDims.each do |hDim|
                                intGrid[:dimensionInfo] << Dimension.unpack(hDim, responseObj)
                            end
                        end

                        # grid information - cell geometry
                        if hGridInfo.has_key?('cellGeometry')
                            s = hGridInfo['cellGeometry']
                            if s != ''
                                intGrid[:dimensionGeometry] = s
                            end
                        end

                        # grid information - are transformation parameters available
                        if hGridInfo.has_key?('transformationParameterAvailability')
                            s = hGridInfo['transformationParameterAvailability']
                            if s != ''
                                intGrid[:dimensionTransformParams] = s
                            end
                        end

                        return intGrid

                    end

                end

            end
        end
    end
end
