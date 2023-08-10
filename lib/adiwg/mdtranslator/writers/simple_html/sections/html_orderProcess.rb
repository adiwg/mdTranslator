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
         module Simple_html

            class Html_OrderProcess

               def initialize(html)
                  @html = html
               end

               def writeHtml(hOrder)

                  # classes used
                  datetimeClass = Html_Datetime.new(@html)

                  # order process - order instructions
                  unless hOrder[:orderingInstructions].nil?
                     @html.em('Order instructions: ')
                     @html.div(:class => 'block') do
                        @html.text!(hOrder[:orderingInstructions])
                     end
                  end

                  # order process - fees
                  unless hOrder[:fees].nil?
                     @html.em('Fees: ')
                     @html.text!(hOrder[:fees])
                     @html.br
                  end

                  # order process - turnaround
                  unless hOrder[:turnaround].nil?
                     @html.em('Turnaround: ')
                     @html.text!(hOrder[:turnaround])
                     @html.br
                  end

                  # order process - planned dateTime
                  unless hOrder[:plannedAvailability].empty?
                     @html.em('Planned Availability: ')
                     dateStr = datetimeClass.writeHtml(hOrder[:plannedAvailability])
                     @html.text!(dateStr)
                  end

               end # writeHtml
            end # Html_OrderProcess

         end
      end
   end
end
