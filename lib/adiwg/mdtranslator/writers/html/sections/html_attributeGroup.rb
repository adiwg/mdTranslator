# HTML writer
# attribute group

# History:
#  Stan Smith 2017-04-02 refactored for mdTranslator 2.0
# 	Stan Smith 2015-08-21 original script

require_relative 'html_classedData'
require_relative 'html_sensorInfo'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_AttributeGroup

               def initialize(html)
                  @html = html
               end

               def writeHtml(hGroup)

                  # classes used
                  htmlClassD = MdHtmlClassedData.new(@html)
                  htmlSensor = MdHtmlSensorInfo.new(@html)

                  @html.em('Nothing here yet')

                  # # coverage item - item name
                  # s = hGroup[:itemName]
                  # if !s.nil?
                  #    @html.em('Item name: ')
                  #    @html.text!(s)
                  #    @html.br
                  # end

                  # # coverage item - item type
                  # s = hGroup[:itemType]
                  # if !s.nil?
                  #    @html.em('Item type: ')
                  #    @html.text!(s)
                  #    @html.br
                  # end
                  #
                  # # coverage item - item description
                  # s = hGroup[:itemDescription]
                  # if !s.nil?
                  #    @html.em('Item Description: ')
                  #    @html.text!(s)
                  #    @html.br
                  # end
                  #
                  # # coverage item - min value
                  # s = hGroup[:minValue]
                  # if !s.nil?
                  #    @html.em('Min value: ')
                  #    @html.text!(s.to_s)
                  #    @html.br
                  # end
                  #
                  # # coverage item - max value
                  # s = hGroup[:maxValue]
                  # if !s.nil?
                  #    @html.em('Max value: ')
                  #    @html.text!(s.to_s)
                  #    @html.br
                  # end
                  #
                  # # coverage item - units
                  # s = hGroup[:units]
                  # if !s.nil?
                  #    @html.em('Units: ')
                  #    @html.text!(s)
                  #    @html.br
                  # end
                  #
                  # # coverage item - scale factor
                  # s = hGroup[:scaleFactor]
                  # if !s.nil?
                  #    @html.em('Scale factor: ')
                  #    @html.text!(s.to_s)
                  #    @html.br
                  # end
                  #
                  # # coverage item - offset
                  # s = hGroup[:offset]
                  # if !s.nil?
                  #    @html.em('Offset: ')
                  #    @html.text!(s.to_s)
                  #    @html.br
                  # end
                  #
                  # # coverage item - mean value
                  # s = hGroup[:meanValue]
                  # if !s.nil?
                  #    @html.em('Mean value: ')
                  #    @html.text!(s.to_s)
                  #    @html.br
                  # end
                  #
                  # # coverage item - standard deviation
                  # s = hGroup[:standardDeviation]
                  # if !s.nil?
                  #    @html.em('Standard deviation: ')
                  #    @html.text!(s.to_s)
                  #    @html.br
                  # end
                  #
                  # # coverage item - bits per value
                  # s = hGroup[:bitsPerValue]
                  # if !s.nil?
                  #    @html.em('Bits per value: ')
                  #    @html.text!(s.to_s)
                  #    @html.br
                  # end
                  #
                  # # coverage item - classed data
                  # hClassD= hGroup[:classedData]
                  # if !hClassD.empty?
                  #    @html.em('Classified data items: ')
                  #    @html.section(:class => 'block') do
                  #       htmlClassD.writeHtml(hClassD)
                  #    end
                  # end
                  #
                  # # coverage item - sensor information
                  # hSensor = hGroup[:sensorInfo]
                  # if !hSensor.empty?
                  #    @html.em('Sensor information: ')
                  #    @html.section(:class => 'block') do
                  #       htmlSensor.writeHtml(hSensor)
                  #    end
                  # end

               end # writeHtml
            end # Html_AttributeGroup

         end
      end
   end
end
