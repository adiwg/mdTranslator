# Reader - fgdc to internal data structure
# unpack fgdc map projection - miller cylindrical

# History:
#  Stan Smith 2017-10-16 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'projection_common'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module MillerCylinderProjection

               def self.unpack(xParams, hProjection, hResponseObj)

                  # map projection 4.1.2.1.12 (miller) - Miller Cylindrical
                  unless xParams.empty?
                     paramCount = 0
                     hProjection[:projection] = 'miller'
                     hProjection[:projectionName] = 'Miller Cylindrical'

                     # -> ReferenceSystemParameters.projection.longitudeOfCentralMeridian
                     paramCount += ProjectionCommon.unpackLongCM(xParams, hProjection, hResponseObj)

                     # -> ReferenceSystemParameters.projection.falseEasting
                     # -> ReferenceSystemParameters.projection.falseNorthing
                     paramCount += ProjectionCommon.unpackFalseNE(xParams, hProjection, hResponseObj)

                     # verify parameter count
                     if paramCount == 3
                        return hProjection
                     else
                        hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC Miller Cylindrical projection is missing one or more parameters'
                     end
                  end

                  return nil

               end

            end

         end
      end
   end
end
