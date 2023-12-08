# HTML writer
# duration

# History:
#  Stan Smith 2017-03-27 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Simple_html

            class Html_Duration

               def initialize(html)
                  @html = html
               end

               def writeHtml(hDuration)

                  # duration - years
                  unless hDuration[:years] == 0
                     @html.em('Years: ')
                     @html.text!(hDuration[:years].to_s)
                     @html.br
                  end

                  # duration - months
                  unless hDuration[:months] == 0
                     @html.em('Months: ')
                     @html.text!(hDuration[:months].to_s)
                     @html.br
                  end

                  # duration - days
                  unless hDuration[:days] == 0
                     @html.em('Days: ')
                     @html.text!(hDuration[:days].to_s)
                     @html.br
                  end

                  # duration - hours
                  unless hDuration[:hours] == 0
                     @html.em('Hours: ')
                     @html.text!(hDuration[:hours].to_s)
                     @html.br
                  end

                  # duration - minutes
                  unless hDuration[:minutes] == 0
                     @html.em('Minutes: ')
                     @html.text!(hDuration[:minutes].to_s)
                     @html.br
                  end

                  # duration - seconds
                  unless hDuration[:seconds] == 0
                     @html.em('Seconds: ')
                     @html.text!(hDuration[:seconds].to_s)
                     @html.br
                  end

               end # writeHtml
            end # Html_Duration

         end
      end
   end
end
