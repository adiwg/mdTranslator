# HTML writer
# time interval

# History:
#  Stan Smith 2017-03-27 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_TimeInterval

               def initialize(html)
                  @html = html
               end

               def writeHtml(hInterval)

                  # time interval - interval
                  unless hInterval[:interval].nil?
                     @html.em('Interval: ')
                     @html.text!(hInterval[:interval].to_s)
                     @html.br
                  end

                  # time interval - units
                  unless hInterval[:units].nil?
                     @html.em('Units: ')
                     @html.text!(hInterval[:units])
                     @html.br
                  end

               end # writeHtml
            end # Html_TimeInterval

         end
      end
   end
end
