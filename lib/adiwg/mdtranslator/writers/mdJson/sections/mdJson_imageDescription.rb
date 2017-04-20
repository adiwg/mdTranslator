# mdJson 2.0 writer - image description

# History:
#   Stan Smith 2017-03-16 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'
require_relative 'mdJson_identifier'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module ImageDescription

               def self.build(hImage)

                  @Namespace = ADIWG::Mdtranslator::Writers::MdJson

                  Jbuilder.new do |json|
                     json.illuminationElevationAngle hImage[:illuminationElevationAngle]
                     json.illuminationAzimuthAngle hImage[:illuminationAzimuthAngle]
                     json.imagingCondition hImage[:imagingCondition]
                     json.imageQualityCode Identifier.build(hImage[:imageQualityCode]) unless hImage[:imageQualityCode].empty?
                     json.cloudCoverPercent hImage[:cloudCoverPercent]
                     json.compressionQuantity hImage[:compressionQuantity]
                     json.triangulationIndicator hImage[:triangulationIndicator]
                     json.radiometricCalibrationAvailable hImage[:radiometricCalibrationAvailable]
                     json.cameraCalibrationAvailable hImage[:cameraCalibrationAvailable]
                     json.filmDistortionAvailable hImage[:filmDistortionAvailable]
                     json.lensDistortionAvailable hImage[:lensDistortionAvailable]
                  end

               end # build
            end # ImageDescription

         end
      end
   end
end
