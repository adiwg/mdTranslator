# Reader - fgdc to internal data structure
# unpack fgdc map projection - transverse mercator

# History:
#  Stan Smith 2018-10-03 refactor mdJson projection object
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

                     # -> ReferenceSystemParameters.projection.scaleFactorAtCentralMeridian
                     paramCount += ProjectionCommon.unpackSFCM(xParams, hProjection)

                     # -> ReferenceSystemParameters.projection.longitudeOfCentralMeridian
                     paramCount += ProjectionCommon.unpackLongCM(xParams, hProjection)

                     # -> ReferenceSystemParameters.projection.latitudeOfProjectionOrigin
                     paramCount += ProjectionCommon.unpackLatPO(xParams, hProjection)

                     # -> ReferenceSystemParameters.projection.falseEasting
                     # -> ReferenceSystemParameters.projection.falseNorthing
                     paramCount += ProjectionCommon.unpackFalseNE(xParams, hProjection)

                     if paramCount == 5
                        return hProjection
                     else
                        hResponseObj[:readerExecutionMessages] <<
                           'WARNING: FGDC reader: Transverse Mercator projection is missing one or more parameters'
                     end
                  end

                  return nil

               end

            end

         end
      end
   end
end
