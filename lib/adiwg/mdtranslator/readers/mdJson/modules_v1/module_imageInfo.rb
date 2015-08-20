# unpack image information
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2015-08-19 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_resourceIdentifier')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module ImageInfo

                    def self.unpack(hImageInfo, responseObj)

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        hImage = intMetadataClass.newImageInfo

                        # coverage information - elevation angle of illumination
                        if hImageInfo.has_key?('illuminationElevationAngle')
                            s = hImageInfo['illuminationElevationAngle']
                            if s != ''
                                hImage[:illuminationElevationAngle] = s
                            end
                        end

                        # coverage information - azimuth of illumination
                        if hImageInfo.has_key?('illuminationAzimuthAngle')
                            s = hImageInfo['illuminationAzimuthAngle']
                            if s != ''
                                hImage[:illuminationAzimuthAngle] = s
                            end
                        end

                        # coverage information - image condition
                        if hImageInfo.has_key?('imagingCondition')
                            s = hImageInfo['imagingCondition']
                            if s != ''
                                hImage[:imageCondition] = s
                            end
                        end

                        # coverage information - image quality - identifier
                        if hImageInfo.has_key?('imageQuality')
                            hProcess = hImageInfo['imageQuality']
                            if !hProcess.empty?
                                hImage[:imageQuality] = ResourceIdentifier.unpack(hProcess, responseObj)
                            end
                        end

                        # coverage information - cloud cover percentage
                        if hImageInfo.has_key?('cloudCoverPercent')
                            s = hImageInfo['cloudCoverPercent']
                            if s != ''
                                hImage[:cloudCoverPercent] = s
                            end
                        end

                        # coverage information - compression quality
                        if hImageInfo.has_key?('compressionQuantity')
                            s = hImageInfo['compressionQuantity']
                            if s != ''
                                hImage[:compressionQuality] = s
                            end
                        end

                        # coverage information - triangulation information available
                        if hImageInfo.has_key?('triangulationIndicator')
                            s = hImageInfo['triangulationIndicator']
                            if s != ''
                                hImage[:triangulationInfo] = s
                            end
                        end

                        # coverage information - radiometric calibration information available
                        if hImageInfo.has_key?('radiometricCalibrationAvailable')
                            s = hImageInfo['radiometricCalibrationAvailable']
                            if s != ''
                                hImage[:radiometricCalibrationInfo] = s
                            end
                        end

                        # coverage information - camera calibration information available
                        if hImageInfo.has_key?('cameraCalibrationAvailable')
                            s = hImageInfo['cameraCalibrationAvailable']
                            if s != ''
                                hImage[:cameraCalibrationInfo] = s
                            end
                        end

                        # coverage information - film distortion information available
                        if hImageInfo.has_key?('filmDistortionAvailable')
                            s = hImageInfo['filmDistortionAvailable']
                            if s != ''
                                hImage[:filmDistortionInfo] = s
                            end
                        end

                        # coverage information - lens distortion information available
                        if hImageInfo.has_key?('lensDistortionAvailable')
                            s = hImageInfo['lensDistortionAvailable']
                            if s != ''
                                hImage[:lensDistortionInfo] = s
                            end
                        end

                        return hImage

                    end

                end

            end
        end
    end
end
