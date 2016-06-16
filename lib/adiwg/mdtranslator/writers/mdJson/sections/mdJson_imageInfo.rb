require 'jbuilder'
require_relative 'mdJson_resourceIdentifier'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module ImageInfo
          def self.build(intObj)
            Jbuilder.new do |json|
              json.illuminationElevationAngle intObj[:illuminationElevationAngle]
              json.illuminationAzimuthAngle intObj[:illuminationAzimuthAngle]
              json.imagingCondition intObj[:imagingCondition]
              json.imageQuality ResourceIdentifier.build(intObj[:imageQuality]) unless intObj[:imageQuality].empty?
              json.cloudCoverPercent intObj[:cloudCoverPercent]
              json.compressionQuantity intObj[:coverageDescription]
              json.triangulationIndicator intObj[:triangulationInfo]
              json.radiometricCalibrationAvailable intObj[:radiometricCalibrationInfo]
              json.cameraCalibrationAvailable intObj[:cameraCalibrationInfo]
              json.filmDistortionAvailable intObj[:filmDistortionInfo]
              json.lensDistortionAvailable intObj[:lensDistortionInfo]
            end
          end
        end
      end
    end
  end
end
