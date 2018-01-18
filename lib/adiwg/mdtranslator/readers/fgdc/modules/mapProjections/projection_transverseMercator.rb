# Reader - fgdc to internal data structure
# unpack fgdc map projection - transverse mercator

# History:
#  Stan Smith 2017-10-04 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module TransverseMercatorProjection

               def self.unpack(xParams, hProjection, hResponseObj)

                  # map projection 4.1.2.1.21 (transmer) - Transverse Mercator
                  unless xParams.empty?
                     paramCount = 0
                     hProjection[:projection] = 'transverseMercator'
                     hProjection[:projectionName] = 'Transverse Mercator'

                     # -> ReferenceSystemParameters.projection.scaleFactorAtCentralMeridian
                     paramCount += ProjectionCommon.unpackSFCM(xParams, hProjection, hResponseObj)

                     # -> ReferenceSystemParameters.projection.longitudeOfCentralMeridian
                     paramCount += ProjectionCommon.unpackLongCM(xParams, hProjection, hResponseObj)

                     # -> ReferenceSystemParameters.projection.latitudeOfProjectionOrigin
                     paramCount += ProjectionCommon.unpackLatPO(xParams, hProjection, hResponseObj)

                     # -> ReferenceSystemParameters.projection.falseEasting
                     # -> ReferenceSystemParameters.projection.falseNorthing
                     paramCount += ProjectionCommon.unpackFalseNE(xParams, hProjection, hResponseObj)

                     if paramCount == 5
                        return hProjection
                     else
                        hResponseObj[:readerExecutionMessages] << 'transverse mercator projection is missing one or more parameters'
                        return nil
                     end
                  end

                  return nil

               end

            end

         end
      end
   end
end
