# HTML writer
# coverage item

# History:
# 	Stan Smith 2015-08-21 original script

require_relative 'html_classedData'
require_relative 'html_sensorInfo'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlCoverageItem
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hCovItem)

                        # classes used
                        htmlClassD = MdHtmlClassedData.new(@html)
                        htmlSensor = MdHtmlSensorInfo.new(@html)

                        # coverage item - item name
                        s = hCovItem[:itemName]
                        if !s.nil?
                            @html.em('Item name: ')
                            @html.text!(s)
                            @html.br
                        end

                        # coverage item - item type
                        s = hCovItem[:itemType]
                        if !s.nil?
                            @html.em('Item type: ')
                            @html.text!(s)
                            @html.br
                        end

                        # coverage item - item description
                        s = hCovItem[:itemDescription]
                        if !s.nil?
                            @html.em('Item Description: ')
                            @html.text!(s)
                            @html.br
                        end

                        # coverage item - min value
                        s = hCovItem[:minValue]
                        if !s.nil?
                            @html.em('Min value: ')
                            @html.text!(s.to_s)
                            @html.br
                        end

                        # coverage item - max value
                        s = hCovItem[:maxValue]
                        if !s.nil?
                            @html.em('Max value: ')
                            @html.text!(s.to_s)
                            @html.br
                        end

                        # coverage item - units
                        s = hCovItem[:units]
                        if !s.nil?
                            @html.em('Units: ')
                            @html.text!(s)
                            @html.br
                        end

                        # coverage item - scale factor
                        s = hCovItem[:scaleFactor]
                        if !s.nil?
                            @html.em('Scale factor: ')
                            @html.text!(s.to_s)
                            @html.br
                        end

                        # coverage item - offset
                        s = hCovItem[:offset]
                        if !s.nil?
                            @html.em('Offset: ')
                            @html.text!(s.to_s)
                            @html.br
                        end

                        # coverage item - mean value
                        s = hCovItem[:meanValue]
                        if !s.nil?
                            @html.em('Mean value: ')
                            @html.text!(s.to_s)
                            @html.br
                        end

                        # coverage item - standard deviation
                        s = hCovItem[:standardDeviation]
                        if !s.nil?
                            @html.em('Standard deviation: ')
                            @html.text!(s.to_s)
                            @html.br
                        end

                        # coverage item - bits per value
                        s = hCovItem[:bitsPerValue]
                        if !s.nil?
                            @html.em('Bits per value: ')
                            @html.text!(s.to_s)
                            @html.br
                        end

                        # coverage item - classed data
                        hClassD= hCovItem[:classedData]
                        if !hClassD.empty?
                            @html.em('Classed data items: ')
                            @html.section(:class=>'block') do
                                htmlClassD.writeHtml(hClassD)
                            end
                        end

                        # coverage item - sensor information
                        hSensor = hCovItem[:sensorInfo]
                        if !hSensor.empty?
                            @html.em('Sensor information: ')
                            @html.section(:class=>'block') do
                                htmlSensor.writeHtml(hSensor)
                            end
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
