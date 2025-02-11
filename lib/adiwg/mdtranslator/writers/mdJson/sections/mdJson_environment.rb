require 'jbuilder'

module ADIWG
    module Mdtranslator
        module Writers
            module MdJson

                module Environment

                    @Namespace = ADIWG::Mdtranslator::Writers::MdJson

                    def self.build(hEnvironment)

                        Jbuilder.new do |json|
                            json.averageAirTemperature hEnvironment[:averageAirTemperature] unless hEnvironment[:averageAirTemperature].nil?
                            json.maxRelativeHumidity hEnvironment[:maxRelativeHumidity] unless hEnvironment[:maxRelativeHumidity].nil?
                            json.maxAltitude hEnvironment[:maxAltitude] unless hEnvironment[:maxAltitude].nil?
                            json.meteorologicalConditions hEnvironment[:meteorologicalConditions] unless hEnvironment[:meteorologicalConditions].nil?
                            json.solarAzimuth hEnvironment[:solarAzimuth] unless hEnvironment[:solarAzimuth].nil?
                            json.solarElevation hEnvironment[:solarElevation] unless hEnvironment[:solarElevation].nil?
                        end

                    end
                end # Environment
            end
        end
    end
end
