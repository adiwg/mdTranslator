module ADIWG
    module Mdtranslator
        module Writers
            module Simple_html
                class Html_Environment
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hEnvironment)
                        # averageAirTemperature
                        unless hEnvironment[:averageAirTemperature].nil?
                            @html.em('Average Air Temperature: ')
                            @html.text!(hEnvironment[:averageAirTemperature].to_s)
                            @html.br
                        end

                        # maxRelativeHumidity
                        unless hEnvironment[:maxRelativeHumidity].nil?
                            @html.em('Maximum Relative Humidity: ')
                            @html.text!(hEnvironment[:maxRelativeHumidity].to_s)
                            @html.br
                        end

                        # maxAltitude
                        unless hEnvironment[:maxAltitude].nil?
                            @html.em('Maximum Altitude: ')
                            @html.text!(hEnvironment[:maxAltitude].to_s)
                            @html.br
                        end
                        
                        # meteorologicalConditions
                        unless hEnvironment[:meteorologicalConditions].nil?
                            @html.em('Meteorological Conditions: ')
                            @html.text!(hEnvironment[:meteorologicalConditions])
                            @html.br
                        end

                        # solarAzimuth
                        unless hEnvironment[:solarAzimuth].nil?
                            @html.em('Solar Azimuth: ')
                            @html.text!(hEnvironment[:solarAzimuth].to_s)
                            @html.br
                        end

                        # solarElevation
                        unless hEnvironment[:solarElevation].nil?
                            @html.em('Solar Elevation: ')
                            @html.text!(hEnvironment[:solarElevation].to_s)
                            @html.br
                        end
                        
                    end
                end
            end
        end
    end
end