# unpack raster information
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2015-07-31 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_resourceIdentifier')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_rasterAttributeGroup')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module RasterInfo

                    def self.unpack(hRasterInfo, responseObj)

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        hRaster = intMetadataClass.newRasterInfo

                        # raster information - raster description
                        if hRasterInfo.has_key?('rasterDescription')
                            s = hRasterInfo['rasterDescription']
                            if s != ''
                                hRaster[:rasterDescription] = s
                            end
                        end

                        # raster information - processing level - identifier
                        if hRasterInfo.has_key?('processingLevel')
                            hProcess = hRasterInfo['processingLevel']
                            if !hProcess.empty?
                                hRaster[:processingLevel] = ResourceIdentifier.unpack(hProcess, responseObj)
                            end
                        end

                        # raster information - elevation angle of illumination
                        if hRasterInfo.has_key?('illuminationElevationAngle')
                            s = hRasterInfo['illuminationElevationAngle']
                            if s != ''
                                hRaster[:illuminationElevationAngle] = s
                            end
                        end

                        # raster information - azimuth of illumination
                        if hRasterInfo.has_key?('illuminationAzimuthAngle')
                            s = hRasterInfo['illuminationAzimuthAngle']
                            if s != ''
                                hRaster[:illuminationAzimuthAngle] = s
                            end
                        end

                        # raster information - image condition
                        if hRasterInfo.has_key?('imagingCondition')
                            s = hRasterInfo['imagingCondition']
                            if s != ''
                                hRaster[:imageCondition] = s
                            end
                        end

                        # raster information - image quality - identifier
                        if hRasterInfo.has_key?('imageQuality')
                            hProcess = hRasterInfo['imageQuality']
                            if !hProcess.empty?
                                hRaster[:imageQuality] = ResourceIdentifier.unpack(hProcess, responseObj)
                            end
                        end

                        # raster information - cloud cover percentage
                        if hRasterInfo.has_key?('cloudCoverPercent')
                            s = hRasterInfo['cloudCoverPercent']
                            if s != ''
                                hRaster[:cloudCoverPercent] = s
                            end
                        end

                        # raster information - compression quality
                        if hRasterInfo.has_key?('compressionQuantity')
                            s = hRasterInfo['compressionQuantity']
                            if s != ''
                                hRaster[:compressionQuality] = s
                            end
                        end

                        # raster information - triangulation information available
                        if hRasterInfo.has_key?('triangulationIndicator')
                            s = hRasterInfo['triangulationIndicator']
                            if s != ''
                                hRaster[:triangulationInfo] = s
                            end
                        end

                        # raster information - radiometric calibration information available
                        if hRasterInfo.has_key?('radiometricCalibrationAvailable')
                            s = hRasterInfo['radiometricCalibrationAvailable']
                            if s != ''
                                hRaster[:radiometricCalibrationInfo] = s
                            end
                        end

                        # raster information - camera calibration information available
                        if hRasterInfo.has_key?('cameraCalibrationAvailable')
                            s = hRasterInfo['cameraCalibrationAvailable']
                            if s != ''
                                hRaster[:cameraCalibrationInfo] = s
                            end
                        end

                        # raster information - film distortion information available
                        if hRasterInfo.has_key?('filmDistortionAvailable')
                            s = hRasterInfo['filmDistortionAvailable']
                            if s != ''
                                hRaster[:filmDistortionInfo] = s
                            end
                        end

                        # raster information - lens distortion information available
                        if hRasterInfo.has_key?('lensDistortionAvailable')
                            s = hRasterInfo['lensDistortionAvailable']
                            if s != ''
                                hRaster[:lensDistortionInfo] = s
                            end
                        end

                        # raster information - raster attribute groups
                        if hRasterInfo.has_key?('attributeGroup')
                            aAttGroup = hRasterInfo['attributeGroup']
                            if !aAttGroup.empty?
                                aAttGroup.each do |hAttGroup|
                                    hRaster[:rasterAttributeGroups] << RasterAttributeGroup.unpack(hAttGroup, responseObj)
                                end
                            end
                        end

                        require 'pp'
                        pp hRaster
                        puts '------------'

                        return hRaster

                    end

                end

            end
        end
    end
end
