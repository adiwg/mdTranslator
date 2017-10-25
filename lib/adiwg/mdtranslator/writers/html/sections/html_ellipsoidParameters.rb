# HTML writer
# spatial reference system ellipsoid parameters

# History:
#  Stan Smith 2017-10-24 original script

require_relative 'html_identifier'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_EllipsoidParameters

               def initialize(html)
                  @html = html
               end

               def writeHtml(hEllipsoid)

                  # classes used
                  identifierClass = Html_Identifier.new(@html)

                  # ellipsoid parameters - ellipsoid name
                  unless hEllipsoid[:ellipsoidName].nil?
                     @html.em('Ellipsoid Name: ')
                     @html.text!(hEllipsoid[:ellipsoidName])
                     @html.br
                  end

                  # ellipsoid parameters - semi-major axis
                  unless hEllipsoid[:semiMajorAxis].nil?
                     @html.em('Semi-major Axis: ')
                     @html.text!(hEllipsoid[:semiMajorAxis].to_s)
                     @html.br
                  end

                  # ellipsoid parameters - axis units
                  unless hEllipsoid[:axisUnits].nil?
                     @html.em('Axis Units: ')
                     @html.text!(hEllipsoid[:axisUnits])
                     @html.br
                  end

                  # ellipsoid parameters - denominator of flattening ratio
                  unless hEllipsoid[:denominatorOfFlatteningRatio].nil?
                     @html.em('Denominator or Flattening Ratio: ')
                     @html.text!(hEllipsoid[:denominatorOfFlatteningRatio].to_s)
                  end

                  # ellipsoid parameters - ellipsoid identifier
                  unless hEllipsoid[:ellipsoidIdentifier].empty?
                     @html.details do
                        @html.summary('Ellipsoid Identifier', {'id' => 'ellipsoid-identifier', 'class' => 'h5'})
                        @html.section(:class => 'block') do
                           identifierClass.writeHtml(hEllipsoid[:ellipsoidIdentifier])
                        end
                     end
                  end

               end # writeHtml
            end # Html_ProjectionParameters

         end
      end
   end
end
