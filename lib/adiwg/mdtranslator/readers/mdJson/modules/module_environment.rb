module ADIWG
    module Mdtranslator
        module Readers
            module MdJson
  
                module Environment
                    def self.unpack(hEnvironment, responseObj, inContext = nil)

                        intMetadataClass = InternalMetadata.new
                        intEnvironment = intMetadataClass.newEnvironment

                        outContext = 'environment'
                        outContext = inContext + ' > ' + outContext unless inContext.nil?

                        if hEnvironment.has_key?('averageAirTemperature')
                            intEnvironment[:averageAirTemperature] = hEnvironment['averageAirTemperature']
                        end

                        if hEnvironment.has_key?('maxRelativeHumidity')
                            intEnvironment[:maxRelativeHumidity] = hEnvironment['maxRelativeHumidity']
                        end

                        if hEnvironment.has_key?('maxAltitude')
                            intEnvironment[:maxAltitude] = hEnvironment['maxAltitude']
                        end

                        if hEnvironment.has_key?('meteorologicalConditions')
                            intEnvironment[:meteorologicalConditions] = hEnvironment['meteorologicalConditions']
                        end

                        if hEnvironment.has_key?('solarAzimuth')
                            intEnvironment[:solarAzimuth] = hEnvironment['solarAzimuth']
                        end

                        if hEnvironment.has_key?('solarElevation')
                            intEnvironment[:solarElevation] = hEnvironment['solarElevation']
                        end

                        intEnvironment

                    end
                end

            end
        end
    end
end