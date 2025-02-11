module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_3

                class MI_EnvironmentalRecord
                    def initialize(xml, hResponseObj)
                        @xml = xml
                        @hResponseObj = hResponseObj
                    end

                    def writeXML(hEnvironment)

                        @xml.tag!('mac:MI_EnvironmentalRecord') do
                            unless hEnvironment[:averageAirTemperature].nil?
                                @xml.tag!('mac:averageAirTemperature') do
                                    @xml.tag!('gco:Real', hEnvironment[:averageAirTemperature])
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:averageAirTemperature')
                                end
                            end

                            unless hEnvironment[:maxRelativeHumidity].nil?
                                @xml.tag!('mac:maxRelativeHumidity') do
                                    @xml.tag!('gco:Real', hEnvironment[:maxRelativeHumidity])
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:maxRelativeHumidity')
                                end
                            end

                            unless hEnvironment[:maxAltitude].nil?
                                @xml.tag!('mac:maxAltitude') do
                                    @xml.tag!('gco:Real', hEnvironment[:maxAltitude])
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:maxAltitude')
                                end
                            end

                            unless hEnvironment[:meteorologicalConditions].nil?
                                @xml.tag!('mac:meteorologicalConditions') do
                                    @xml.tag!('gco:CharacterString', hEnvironment[:meteorologicalConditions])
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:meteorologicalConditions')
                                end
                            end

                            unless hEnvironment[:solarAzimuth].nil?
                                @xml.tag!('mac:solarAzimuth') do
                                    @xml.tag!('gco:Real', hEnvironment[:solarAzimuth])
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:solarAzimuth')
                                end
                            end

                            unless hEnvironment[:solarElevation].nil?
                                @xml.tag!('mac:solarElevation') do
                                    @xml.tag!('gco:Real', hEnvironment[:solarElevation])
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:solarElevation')
                                end
                            end
                        end

                    end
                end

            end
        end
    end
end
