# unpack sensor info
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2015-08-19 original script

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module SensorInfo

                    def self.unpack(hSensorInfo, responseObj)

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        hSensor = intMetadataClass.newSensorInfo

                        # sensor info - sensor tone gradation
                        if hSensorInfo.has_key?('toneGradations')
                            s = hSensorInfo['toneGradations']
                            if s != ''
                                hSensor[:toneGradations] = s
                            end
                        end

                        # sensor info - sensor max value
                        if hSensorInfo.has_key?('sensorMax')
                            s = hSensorInfo['sensorMax']
                            if s != ''
                                hSensor[:sensorMax] = s
                            end
                        end

                        # sensor info - sensor minimum value
                        if hSensorInfo.has_key?('sensorMin')
                            s = hSensorInfo['sensorMin']
                            if s != ''
                                hSensor[:sensorMin] = s
                            end
                        end

                        # sensor info - sensor units
                        if hSensorInfo.has_key?('sensorUnits')
                            s = hSensorInfo['sensorUnits']
                            if s != ''
                                hSensor[:sensorUnits] = s
                            end
                        end

                        # sensor info - sensor peak response
                        if hSensorInfo.has_key?('sensorPeakResponse')
                            s = hSensorInfo['sensorPeakResponse']
                            if s != ''
                                hSensor[:sensorPeakResponse] = s
                            end
                        end

                        return hSensor

                    end

                end

            end
        end
    end
end
