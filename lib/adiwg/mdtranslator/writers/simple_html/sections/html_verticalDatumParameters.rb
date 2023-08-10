# HTML writer
# spatial reference system vertical datum parameters

# History:
#  Stan Smith 2018-09-26 deprecated verticalDatum.datumName
#  Stan Smith 2017-10-24 original script

require_relative 'html_identifier'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_VerticalDatumParameters

               def initialize(html)
                  @html = html
               end

               def writeHtml(hDatum)

                  # classes used
                  identifierClass = Html_Identifier.new(@html)

                  # vertical datum - is depth system {Boolean}
                  if hDatum[:encodingMethod]
                     @html.text!('Depth System')
                  else
                     @html.text!('Altitude System')
                  end
                  @html.br

                  # vertical datum parameters - vertical datum identifier
                  unless hDatum[:datumIdentifier].empty?
                     @html.details do
                        @html.summary('Vertical Datum Identifier', {'id' => 'datum-identifier', 'class' => 'h5'})
                        @html.section(:class => 'block') do
                           identifierClass.writeHtml(hDatum[:datumIdentifier])
                        end
                     end
                  end

                  # vertical datum - encoding method
                  unless hDatum[:encodingMethod].nil?
                     @html.em('Encoding Method: ')
                     @html.text!(hDatum[:encodingMethod])
                     @html.br
                  end

                  # vertical datum - vertical resolution
                  unless hDatum[:verticalResolution].nil?
                     @html.em('Vertical Resolution: ')
                     @html.text!(hDatum[:verticalResolution].to_s)
                     @html.br
                  end

                  # vertical datum - unit of measure
                  unless hDatum[:unitOfMeasure].nil?
                     @html.em('Unit of Measure: ')
                     @html.text!(hDatum[:unitOfMeasure])
                  end

               end # writeHtml
            end # Html_VerticalDatumParameters

         end
      end
   end
end
