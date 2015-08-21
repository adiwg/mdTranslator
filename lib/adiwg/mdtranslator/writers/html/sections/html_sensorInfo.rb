# HTML writer
# sensor information

# History:
# 	Stan Smith 2015-08-21 original script

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlSensorInfo
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hSensor)

                        # sensor information - tone gradations
                        s = hSensor[:toneGradations]
                        if !s.nil?
                            @html.em('Number of tone gradations: ')
                            @html.text!(s.to_s)
                            @html.br
                        end

                        # sensor information - sensor min
                        s = hSensor[:sensorMin]
                        if !s.nil?
                            @html.em('Sensor lower limit: ')
                            @html.text!(s.to_s)
                            @html.br
                        end

                        # sensor information - sensor max
                        s = hSensor[:sensorMax]
                        if !s.nil?
                            @html.em('Sensor upper limit: ')
                            @html.text!(s.to_s)
                            @html.br
                        end

                        # sensor information - units
                        s = hSensor[:sensorUnits]
                        if !s.nil?
                            @html.em('Sensor units: ')
                            @html.text!(s.to_s)
                            @html.br
                        end

                        # sensor information - peak response
                        s = hSensor[:sensorPeakResponse]
                        if !s.nil?
                            @html.em('Sensor peak response: ')
                            @html.text!(s.to_s)
                            @html.br
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
