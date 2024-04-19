module ADIWG
    module Mdtranslator
        module Readers
            module MdJson
  
                module AcqEnvironment
                    def self.unpack(hAcqEnvironment, responseObj, inContext = nil)
                        intAcqEnvironment = intMetadataClass.newEnvironment

                        outContext = 'acquisition environment'
                        outContext = inContext + ' > ' + outContext unless inContext.nil?
                        # {
                        #     averageAirTemperature: nil,
                        #     maxRelativeHumidity: nil,
                        #     maxAltitude: nil,
                        #     meteorologicalConditions: nil
                        # }
                        if hAcqEnvironment.has_key('averageAirTemperature')
                            intAcqEnvironment[:averageAirTemperature] = hAcqEnvironment['averageAirTemperature']
                        end

                        if hAcqEnvironment.has_key('maxRelativeHumidity')
                            intAcqEnvironment[:maxRelativeHumidity] = hAcqEnvironment['maxRelativeHumidity']
                        end

                        if hAcqEnvironment.has_key('maxAltitude')
                            intAcqEnvironment[:maxAltitude] = hAcqEnvironment['maxAltitude']
                        end

                        if hAcqEnvironment.has_key('meteorologicalConditions')
                            intAcqEnvironment[:meteorologicalConditions] = hAcqEnvironment['meteorologicalConditions']
                        end

                        if hAcqEnvironment.has_key('solarAzimuth')
                            intAcqEnvironment[:solarAzimuth] = hAcqEnvironment['solarAzimuth']
                        end

                        if hAcqEnvironment.has_key('solarElevation')
                            intAcqEnvironment[:solarElevation] = hAcqEnvironment['solarElevation']
                        end

                    end
                end

            end
        end
    end
end