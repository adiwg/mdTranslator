# ISO <<Class>> image description
# 19115-2 writer output in XML

# History:
#  Stan Smith 2016-11-27 refactored for mdTranslator/mdJson 2.0
# 	Stan Smith 2015-08-27 original script

require_relative 'class_codelist'
require_relative 'class_rsIdentifier'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class MI_ImageDescription

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hCoverage)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                  resIdClass = RS_Identifier.new(@xml, @hResponseObj)

                  hImage = hCoverage[:imageDescription]

                  # image description - illumination elevation angle
                  s = hImage[:illuminationElevationAngle]
                  unless s.nil?
                     @xml.tag!('gmd:illuminationElevationAngle') do
                        @xml.tag!('gco:Real', s)
                     end
                  end
                  if s.nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('gmd:illuminationElevationAngle')
                  end

                  # image description - illumination azimuth angle
                  s = hImage[:illuminationAzimuthAngle]
                  unless s.nil?
                     @xml.tag!('gmd:illuminationAzimuthAngle') do
                        @xml.tag!('gco:Real', s)
                     end
                  end
                  if s.nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('gmd:illuminationAzimuthAngle')
                  end

                  # image description - image condition {MD_ImageConditionCode}
                  s = hImage[:imagingCondition]
                  unless s.nil?
                     @xml.tag!('gmd:imagingCondition') do
                        codelistClass.writeXML('gmd', 'iso_imageCondition', s)
                     end
                  end
                  if s.nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('gmd:imagingCondition')
                  end

                  # image description - image quality code {RS_Identifier}
                  resId = hImage[:imageQualityCode]
                  unless resId.empty?
                     @xml.tag!('gmd:imageQualityCode') do
                        resIdClass.writeXML(resId, 'image quality code')
                     end
                  end
                  if resId.empty? && @hResponseObj[:writerShowTags]
                     @xml.tag!('gmd:imageQualityCode')
                  end

                  # image description - cloud cover percentage
                  s = hImage[:cloudCoverPercent]
                  unless s.nil?
                     @xml.tag!('gmd:cloudCoverPercentage') do
                        @xml.tag!('gco:Real', s)
                     end
                  end
                  if s.nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('gmd:cloudCoverPercentage')
                  end

                  # image description - processing level code (from coverageItem) {RS_Identifier}
                  resId = hCoverage[:processingLevelCode]
                  unless resId.empty?
                     @xml.tag!('gmd:processingLevelCode') do
                        resIdClass.writeXML(resId, 'image processing level code')
                     end
                  end
                  if resId.empty? && @hResponseObj[:writerShowTags]
                     @xml.tag!('gmd:processingLevelCode')
                  end

                  # image description - compression generation quality
                  s = hImage[:compressionQuantity]
                  unless s.nil?
                     @xml.tag!('gmd:compressionGenerationQuantity') do
                        @xml.tag!('gco:Integer', s)
                     end
                  end
                  if s.nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('gmd:compressionGenerationQuantity')
                  end

                  # image description - triangulation indicator
                  s = hImage[:triangulationIndicator]
                  @xml.tag!('gmd:triangulationIndicator') do
                     @xml.tag!('gco:Boolean', s)
                  end

                  # image description - radiometric calibration data availability
                  s = hImage[:radiometricCalibrationAvailable]
                  @xml.tag!('gmd:radiometricCalibrationDataAvailability') do
                     @xml.tag!('gco:Boolean', s)
                  end

                  # image description - camera calibration information availability
                  s = hImage[:cameraCalibrationAvailable]
                  @xml.tag!('gmd:cameraCalibrationInformationAvailability') do
                     @xml.tag!('gco:Boolean', s)
                  end

                  # image description - film distortion information availability
                  s = hImage[:filmDistortionAvailable]
                  @xml.tag!('gmd:filmDistortionInformationAvailability') do
                     @xml.tag!('gco:Boolean', s)
                  end

                  # image description - lens distortion information availability
                  s = hImage[:lensDistortionAvailable]
                  @xml.tag!('gmd:lensDistortionInformationAvailability') do
                     @xml.tag!('gco:Boolean', s)
                  end

               end
            end

         end
      end
   end
end
