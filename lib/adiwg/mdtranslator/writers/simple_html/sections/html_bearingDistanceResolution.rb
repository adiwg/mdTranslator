# HTML writer
# bearing distance resolution

# History:
#  Stan Smith 2017-10-20 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_BearingDistanceResolution

               def initialize(html)
                  @html = html
               end

               def writeHtml(hBearRes)

                  # bearing distance resolution - distance resolution
                  unless hBearRes[:distanceResolution].nil?
                     @html.em('Distance Resolution: ')
                     @html.text!(hBearRes[:distanceResolution].to_s)
                     @html.br
                  end

                  # bearing distance resolution - distance unit of measure
                  unless hBearRes[:distanceUnitOfMeasure].nil?
                     @html.em('Distance Unit of Measure: ')
                     @html.text!(hBearRes[:distanceUnitOfMeasure])
                     @html.br
                  end

                  # bearing distance resolution - bearing resolution
                  unless hBearRes[:bearingResolution].nil?
                     @html.em('Bearing Resolution: ')
                     @html.text!(hBearRes[:bearingResolution].to_s)
                     @html.br
                  end

                  # bearing distance resolution - bearing unit of measure
                  unless hBearRes[:bearingUnitOfMeasure].nil?
                     @html.em('Bearing Unit of Measure: ')
                     @html.text!(hBearRes[:bearingUnitOfMeasure])
                     @html.br
                  end

                  # bearing distance resolution - bearing reference direction
                  unless hBearRes[:bearingReferenceDirection].nil?
                     @html.em('Bearing Reference Direction: ')
                     @html.text!(hBearRes[:bearingReferenceDirection])
                     @html.br
                  end

                  # bearing distance resolution - bearing reference meridian
                  unless hBearRes[:bearingReferenceMeridian].nil?
                     @html.em('Bearing Reference Meridian: ')
                     @html.text!(hBearRes[:bearingReferenceMeridian])
                     @html.br
                  end

               end # writeHtml
            end # Html_BearingDistanceResolution

         end
      end
   end
end
