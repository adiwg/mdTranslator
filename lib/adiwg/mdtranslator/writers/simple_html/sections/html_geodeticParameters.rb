# HTML writer
# spatial reference system ellipsoid parameters

# History:
#  Stan Smith 2017-10-24 original script

require_relative 'html_identifier'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_GeodeticParameters

               def initialize(html)
                  @html = html
               end

               def writeHtml(hGeodetic)

                  # classes used
                  identifierClass = Html_Identifier.new(@html)

                  # geodetic parameters - datum identifier
                  unless hGeodetic[:datumIdentifier].empty?
                     @html.details do
                        @html.summary('Datum Identifier', {'id' => 'datum-identifier', 'class' => 'h5'})
                        @html.section(:class => 'block') do
                           identifierClass.writeHtml(hGeodetic[:datumIdentifier])
                        end
                     end
                  end

                  # geodetic parameters - ellipsoid identifier
                  unless hGeodetic[:ellipsoidIdentifier].empty?
                     @html.details do
                        @html.summary('Ellipsoid Identifier', {'id' => 'ellipsoid-identifier', 'class' => 'h5'})
                        @html.section(:class => 'block') do
                           identifierClass.writeHtml(hGeodetic[:ellipsoidIdentifier])
                        end
                     end
                  end

                  # geodetic parameters - semi-major axis
                  unless hGeodetic[:semiMajorAxis].nil?
                     @html.em('Semi-major Axis: ')
                     @html.text!(hGeodetic[:semiMajorAxis].to_s)
                     @html.br
                  end

                  # geodetic parameters - axis units
                  unless hGeodetic[:axisUnits].nil?
                     @html.em('Axis Units: ')
                     @html.text!(hGeodetic[:axisUnits])
                     @html.br
                  end

                  # geodetic parameters - denominator of flattening ratio
                  unless hGeodetic[:denominatorOfFlatteningRatio].nil?
                     @html.em('Denominator or Flattening Ratio: ')
                     @html.text!(hGeodetic[:denominatorOfFlatteningRatio].to_s)
                  end

               end # writeHtml
            end # Html_ProjectionParameters

         end
      end
   end
end
