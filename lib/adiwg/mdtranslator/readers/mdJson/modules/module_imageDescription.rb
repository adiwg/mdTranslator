# unpack image description
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-21 refactored error and warning messaging
# 	Stan Smith 2016-10-18 original script

require_relative 'module_identifier'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module ImageDescription

               def self.unpack(hImageInfo, responseObj)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  inContext = 'coverage description'

                  # return nil object if input is empty
                  if hImageInfo.empty?
                     @MessagePath.issueWarning(460, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hImage = intMetadataClass.newImageDescription

                  outContext = inContext + ' image description'

                  # image description - elevation angle of illumination
                  if hImageInfo.has_key?('illuminationElevationAngle')
                     unless hImageInfo['illuminationElevationAngle'] == ''
                        hImage[:illuminationElevationAngle] = hImageInfo['illuminationElevationAngle']
                     end
                  end

                  # image description - azimuth of illumination
                  if hImageInfo.has_key?('illuminationAzimuthAngle')
                     unless hImageInfo['illuminationAzimuthAngle'] == ''
                        hImage[:illuminationAzimuthAngle] = hImageInfo['illuminationAzimuthAngle']
                     end
                  end

                  # image description - image condition
                  if hImageInfo.has_key?('imagingCondition')
                     unless hImageInfo['imagingCondition'] == ''
                        hImage[:imagingCondition] = hImageInfo['imagingCondition']
                     end
                  end

                  # image description - image quality - identifier
                  if hImageInfo.has_key?('imageQualityCode')
                     hObject = hImageInfo['imageQualityCode']
                     unless hObject.empty?
                        hReturn = Identifier.unpack(hObject, responseObj, outContext)
                        unless hReturn.nil?
                           hImage[:imageQualityCode] = hReturn
                        end
                     end
                  end

                  # image description - cloud cover percentage
                  if hImageInfo.has_key?('cloudCoverPercent')
                     unless hImageInfo['cloudCoverPercent'] == ''
                        hImage[:cloudCoverPercent] = hImageInfo['cloudCoverPercent']
                     end
                  end

                  # image description - compression quality
                  if hImageInfo.has_key?('compressionQuantity')
                     unless hImageInfo['compressionQuantity'] == ''
                        hImage[:compressionQuantity] = hImageInfo['compressionQuantity']
                     end
                  end

                  # image description - triangulation information available {Boolean}
                  if hImageInfo.has_key?('triangulationIndicator')
                     if hImageInfo['triangulationIndicator'] === true
                        hImage[:triangulationIndicator] = hImageInfo['triangulationIndicator']
                     end
                  end

                  # image description - radiometric calibration information available {Boolean}
                  if hImageInfo.has_key?('radiometricCalibrationAvailable')
                     if hImageInfo['radiometricCalibrationAvailable'] === true
                        hImage[:radiometricCalibrationAvailable] = hImageInfo['radiometricCalibrationAvailable']
                     end
                  end

                  # image description - camera calibration information available {Boolean}
                  if hImageInfo.has_key?('cameraCalibrationAvailable')
                     if hImageInfo['cameraCalibrationAvailable'] === true
                        hImage[:cameraCalibrationAvailable] = hImageInfo['cameraCalibrationAvailable']
                     end
                  end

                  # image description - film distortion information available {Boolean}
                  if hImageInfo.has_key?('filmDistortionAvailable')
                     if hImageInfo['filmDistortionAvailable'] === true
                        hImage[:filmDistortionAvailable] = hImageInfo['filmDistortionAvailable']
                     end
                  end

                  # image description - lens distortion information available {Boolean}
                  if hImageInfo.has_key?('lensDistortionAvailable')
                     if hImageInfo['lensDistortionAvailable'] === true
                        hImage[:lensDistortionAvailable] = hImageInfo['lensDistortionAvailable']
                     end
                  end

                  return hImage

               end

            end

         end
      end
   end
end
