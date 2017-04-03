# HTML writer
# attribute

# History:
#  Stan Smith 2017-04-02 original script

require_relative 'html_classedData'
require_relative 'html_sensorInfo'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_Attribute

               def initialize(html)
                  @html = html
               end

               def writeHtml(hAttribute)
                  # classes used
                  htmlClassD = MdHtmlClassedData.new(@html)
                  htmlSensor = MdHtmlSensorInfo.new(@html)

                  @html.em('Nothing here yet')

                  # # coverage item - item name
                  # s = hAttribute[:itemName]
                  # if !s.nil?
                  #    @html.em('Item name: ')
                  #    @html.text!(s)
                  #    @html.br
                  # end

                  # # coverage item - item type
                  # s = hAttribute[:itemType]
                  # if !s.nil?
                  #    @html.em('Item type: ')
                  #    @html.text!(s)
                  #    @html.br
                  # end
                  #
                  # # coverage item - item description
                  # s = hAttribute[:itemDescription]
                  # if !s.nil?
                  #    @html.em('Item Description: ')
                  #    @html.text!(s)
                  #    @html.br
                  # end
                  #
                  # # coverage item - min value
                  # s = hAttribute[:minValue]
                  # if !s.nil?
                  #    @html.em('Min value: ')
                  #    @html.text!(s.to_s)
                  #    @html.br
                  # end
                  #
                  # # coverage item - max value
                  # s = hAttribute[:maxValue]
                  # if !s.nil?
                  #    @html.em('Max value: ')
                  #    @html.text!(s.to_s)
                  #    @html.br
                  # end
                  #
                  # # coverage item - units
                  # s = hAttribute[:units]
                  # if !s.nil?
                  #    @html.em('Units: ')
                  #    @html.text!(s)
                  #    @html.br
                  # end
                  #
                  # # coverage item - scale factor
                  # s = hAttribute[:scaleFactor]
                  # if !s.nil?
                  #    @html.em('Scale factor: ')
                  #    @html.text!(s.to_s)
                  #    @html.br
                  # end
                  #
                  # # coverage item - offset
                  # s = hAttribute[:offset]
                  # if !s.nil?
                  #    @html.em('Offset: ')
                  #    @html.text!(s.to_s)
                  #    @html.br
                  # end
                  #
                  # # coverage item - mean value
                  # s = hAttribute[:meanValue]
                  # if !s.nil?
                  #    @html.em('Mean value: ')
                  #    @html.text!(s.to_s)
                  #    @html.br
                  # end
                  #
                  # # coverage item - standard deviation
                  # s = hAttribute[:standardDeviation]
                  # if !s.nil?
                  #    @html.em('Standard deviation: ')
                  #    @html.text!(s.to_s)
                  #    @html.br
                  # end
                  #
                  # # coverage item - bits per value
                  # s = hAttribute[:bitsPerValue]
                  # if !s.nil?
                  #    @html.em('Bits per value: ')
                  #    @html.text!(s.to_s)
                  #    @html.br
                  # end
                  #
                  # # coverage item - classed data
                  # hClassD= hAttribute[:classedData]
                  # if !hClassD.empty?
                  #    @html.em('Classified data items: ')
                  #    @html.section(:class => 'block') do
                  #       htmlClassD.writeHtml(hClassD)
                  #    end
                  # end
                  #
                  # # coverage item - sensor information
                  # hSensor = hAttribute[:sensorInfo]
                  # if !hSensor.empty?
                  #    @html.em('Sensor information: ')
                  #    @html.section(:class => 'block') do
                  #       htmlSensor.writeHtml(hSensor)
                  #    end
                  # end

               end # writeHtml
            end # Html_Attribute

         end
      end
   end
end
