# HTML writer
# coordinate resolution

# History:
#  Stan Smith 2017-10-20 original script

module ADIWG
   module Mdtranslator
      module Writers
         module SimpleHtml

            class Html_CoordinateResolution

               def initialize(html)
                  @html = html
               end

               def writeHtml(hCoordRes)

                  # coordinate resolution - abscissa
                  unless hCoordRes[:abscissaResolutionX].nil?
                     @html.em('X Resolution (abscissa): ')
                     @html.text!(hCoordRes[:abscissaResolutionX].to_s)
                     @html.br
                  end

                  # coordinate resolution - ordinate
                  unless hCoordRes[:ordinateResolutionY].nil?
                     @html.em('Y Resolution (ordinate): ')
                     @html.text!(hCoordRes[:ordinateResolutionY].to_s)
                     @html.br
                  end

                  # coordinate resolution - unit of measure
                  unless hCoordRes[:unitOfMeasure].nil?
                     @html.em('Units of Measure: ')
                     @html.text!(hCoordRes[:unitOfMeasure])
                     @html.br
                  end

               end # writeHtml
            end # Html_CoordinateResolution

         end
      end
   end
end
