# Reader - fgdc to internal data structure
# unpack fgdc map projection - lambert conformal conic

# History:
#  Stan Smith 2017-10-16 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'projection_common'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module LambertConicProjection

               def self.unpack(xParams, hProjection, hResponseObj)

                  # map projection 4.1.2.1.9 (lambertc) - Lambert Conformal Conic
                  unless xParams.empty?
                     paramCount = 0
                     hProjection[:projection] = 'lambertConic'
                     hProjection[:projectionName] = 'Lambert Conformal Conic'

                     # -> ReferenceSystemParameters.projection.standardParallel1
                     # -> ReferenceSystemParameters.projection.standardParallel2
                     paramCount += ProjectionCommon.unpackStandParallel(xParams, hProjection, hResponseObj)

                     # -> ReferenceSystemParameters.projection.longitudeOfCentralMeridian
                     paramCount += ProjectionCommon.unpackLongCM(xParams, hProjection, hResponseObj)

                     # -> ReferenceSystemParameters.projection.latitudeOfProjectionOrigin
                     paramCount += ProjectionCommon.unpackLatPO(xParams, hProjection, hResponseObj)

                     # -> ReferenceSystemParameters.projection.falseEasting
                     # -> ReferenceSystemParameters.projection.falseNorthing
                     paramCount += ProjectionCommon.unpackFalseNE(xParams, hProjection, hResponseObj)

                     # verify parameter count
                     if paramCount == 6
                        return hProjection
                     else
                        hResponseObj[:readerExecutionMessages] << 'WARNING: Lambert Conformal Conic projection is missing one or more parameters'
                     end
                  end

                  return nil

               end

            end

         end
      end
   end
end
