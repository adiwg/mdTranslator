# Reader - fgdc to internal data structure
# unpack fgdc map projection - sinusoidal

# History:
#  Stan Smith 2017-10-18 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'projection_common'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module SinusoidalProjection

               def self.unpack(xParams, hProjection, hResponseObj)

                  # map projection 4.1.2.1.18 (sinusoid) - Sinusoidal
                  unless xParams.empty?
                     paramCount = 0
                     hProjection[:projection] = 'sinusoidal'
                     hProjection[:projectionName] = 'Sinusoidal'

                     # -> ReferenceSystemParameters.projection.longitudeOfCentralMeridian
                     paramCount += ProjectionCommon.unpackLongCM(xParams, hProjection, hResponseObj)

                     # -> ReferenceSystemParameters.projection.falseEasting
                     # -> ReferenceSystemParameters.projection.falseNorthing
                     paramCount += ProjectionCommon.unpackFalseNE(xParams, hProjection, hResponseObj)

                     # verify parameter count
                     if paramCount == 3
                        return hProjection
                     else
                        hResponseObj[:readerExecutionMessages] << 'sinusoidal projection is missing one or more parameters'
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
