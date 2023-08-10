# HTML writer
# measure

# History:
#  Stan Smith 2017-03-28 original script

module ADIWG
   module Mdtranslator
      module Writers
         module SimpleHtml

            class Html_Measure

               def initialize(html)
                  @html = html
               end

               def writeHtml(hMeasure)

                  # measure - type
                  unless hMeasure[:type].nil?
                     @html.em('Type: ')
                     @html.text!(hMeasure[:type])
                     @html.br
                  end

                  # measure - value
                  unless hMeasure[:value].nil?
                     @html.em('Value: ')
                     @html.text!(hMeasure[:value].to_s)
                     @html.br
                  end

                  # measure - unit of measure
                  unless hMeasure[:unitOfMeasure].nil?
                     @html.em('Units: ')
                     @html.text!(hMeasure[:unitOfMeasure])
                     @html.br
                  end

               end # writeHtml
            end # Html_Measure

         end
      end
   end
end
