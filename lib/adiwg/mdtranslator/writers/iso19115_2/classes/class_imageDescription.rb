# ISO <<Class>> image description
# writer output in XML

# History:
# 	Stan Smith 2015-08-27 original script

require_relative 'class_codelist'
require_relative 'class_resourceIdentifier'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class ImageDescription

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hContent)

                        # classes used
                        codelistClass = MD_Codelist.new(@xml, @responseObj)
                        resIdClass = RS_Identifier.new(@xml, @responseObj)

                        hImage = hContent[:imageInfo]

                        # image description - illumination elevation angle
                        s = hImage[:illuminationElevationAngle]
                        if !s.nil?
                            @xml.tag!('gmd:illuminationElevationAngle') do
                                @xml.tag!('gco:Real', s)
                            end
                        elsif @responseObj[:writerShowTags]
                            @xml.tag!('gmd:illuminationElevationAngle')
                        end

                        # image description - illumination azimuth angle
                        s = hImage[:illuminationAzimuthAngle]
                        if !s.nil?
                            @xml.tag!('gmd:illuminationAzimuthAngle') do
                                @xml.tag!('gco:Real', s)
                            end
                        elsif @responseObj[:writerShowTags]
                            @xml.tag!('gmd:illuminationAzimuthAngle')
                        end

                        # image description - image condition - MD_ImageConditionCode
                        s = hImage[:imageCondition]
                        if !s.nil?
                            @xml.tag!('gmd:imagingCondition') do
                                codelistClass.writeXML('iso_imageCondition',s)
                            end
                        elsif @responseObj[:writerShowTags]
                            @xml.tag!('gmd:imagingCondition')
                        end

                        # image description - image quality code - RS_Identifier
                        resId = hImage[:imageQuality]
                        if !resId.empty?
                            @xml.tag!('gmd:imageQualityCode') do
                                resIdClass.writeXML(resId)
                            end
                        elsif @responseObj[:writerShowTags]
                            @xml.tag!('gmd:imageQualityCode')
                        end

                        # image description - cloud cover percentage
                        s = hImage[:cloudCoverPercent]
                        if !s.nil?
                            @xml.tag!('gmd:cloudCoverPercentage') do
                                @xml.tag!('gco:Real', s)
                            end
                        elsif @responseObj[:writerShowTags]
                            @xml.tag!('gmd:cloudCoverPercentage')
                        end

                        # image description - processing level code (from coverageItem)- RS_Identifier
                        resId = hContent[:processingLevel]
                        if !resId.empty?
                            @xml.tag!('gmd:processingLevelCode') do
                                resIdClass.writeXML(resId)
                            end
                        elsif @responseObj[:writerShowTags]
                            @xml.tag!('gmd:processingLevelCode')
                        end

                        # image description - compression generation quality
                        s = hImage[:compressionQuantity]
                        if !s.nil?
                            @xml.tag!('gmd:compressionGenerationQuantity') do
                                @xml.tag!('gco:Integer', s)
                            end
                        elsif @responseObj[:writerShowTags]
                            @xml.tag!('gmd:compressionGenerationQuantity')
                        end

                        # image description - triangulation indicator
                        s = hImage[:triangulationInfo]
                        if !s.nil?
                            @xml.tag!('gmd:triangulationIndicator') do
                                @xml.tag!('gco:Boolean', s)
                            end
                        elsif @responseObj[:writerShowTags]
                            @xml.tag!('gmd:triangulationIndicator')
                        end

                        # image description - radiometric calibration data availability
                        s = hImage[:radiometricCalibrationInfo]
                        if !s.nil?
                            @xml.tag!('gmd:radiometricCalibrationDataAvailability') do
                                @xml.tag!('gco:Boolean', s)
                            end
                        elsif @responseObj[:writerShowTags]
                            @xml.tag!('gmd:radiometricCalibrationDataAvailability')
                        end

                        # image description - camera calibration information availability
                        s = hImage[:cameraCalibrationInfo]
                        if !s.nil?
                            @xml.tag!('gmd:cameraCalibrationInformationAvailability') do
                                @xml.tag!('gco:Boolean', s)
                            end
                        elsif @responseObj[:writerShowTags]
                            @xml.tag!('gmd:cameraCalibrationInformationAvailability')
                        end

                        # image description - film distortion information availability
                        s = hImage[:filmDistortionInfo]
                        if !s.nil?
                            @xml.tag!('gmd:filmDistortionInformationAvailability') do
                                @xml.tag!('gco:Boolean', s)
                            end
                        elsif @responseObj[:writerShowTags]
                            @xml.tag!('gmd:filmDistortionInformationAvailability')
                        end

                        # image description - lens distortion information availability
                        s = hImage[:lensDistortionInfo]
                        if !s.nil?
                            @xml.tag!('gmd:lensDistortionInformationAvailability') do
                                @xml.tag!('gco:Boolean', s)
                            end
                        elsif @responseObj[:writerShowTags]
                            @xml.tag!('gmd:lensDistortionInformationAvailability')
                        end

                    end

                end

            end
        end
    end
end
