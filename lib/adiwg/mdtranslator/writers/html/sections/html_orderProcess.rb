# HTML writer
# order process

# History:
#  Stan Smith 2017-04-04 refactored for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
# 	Stan Smith 2015-03-27 original script

require_relative 'html_datetime'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_OrderProcess

               def initialize(html)
                  @html = html
               end

               def writeHtml(hOrder)

                  # classes used
                  datetimeClass = Html_Datetime.new(@html)

                  @html.text!('Nothing Here')



                  # # order process - order instructions
                  # s = hOrder[:orderInstructions]
                  # if !s.nil?
                  #    @html.em('Order instructions: ')
                  #    @html.section(:class => 'block') do
                  #       @html.text!(s)
                  #    end
                  # end
                  #
                  # # order process - fees
                  # s = hOrder[:fees]
                  # if !s.nil?
                  #    @html.em('Fees: ')
                  #    @html.text!(s)
                  #    @html.br
                  # end
                  #
                  # # order process - turnaround
                  # s = hOrder[:turnaround]
                  # if !s.nil?
                  #    @html.em('Turnaround: ')
                  #    @html.text!(s)
                  #    @html.br
                  # end
                  #
                  # # order process - planned dateTime
                  # hDatetime = hOrder[:plannedDateTime]
                  # if !hDatetime.empty?
                  #    @html.em('Planned Availability: ')
                  #    datetimeClass.writeHtml(hDatetime)
                  # end

               end # writeHtml
            end # Html_OrderProcess

         end
      end
   end
end
