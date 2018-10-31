# Reader - fgdc to internal data structure
# unpack fgdc map projection - stereographic

# History:
#  Stan Smith 2018-10-03 refactor mdJson projection object
#  Stan Smith 2017-10-18 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'projection_common'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module StereographicProjection

               def self.unpack(xParams, hProjection, hResponseObj)

                  # map projection 4.1.2.1.20 (stereo) - Stereographic
                  unless xParams.empty?
                     paramCount = 0

                     # -> ReferenceSystemParameters.projection.longitudeOfProjectionCenter
                     paramCount += ProjectionCommon.unpackLongPC(xParams, hProjection)

                     # -> ReferenceSystemParameters.projection.latitudeOfProjectionCenter
                     paramCount += ProjectionCommon.unpackLatPC(xParams, hProjection)

                     # -> ReferenceSystemParameters.projection.falseEasting
                     # -> ReferenceSystemParameters.projection.falseNorthing
                     paramCount += ProjectionCommon.unpackFalseNE(xParams, hProjection)

                     # verify parameter count
                     if paramCount == 4
                        return hProjection
                     else
                        hResponseObj[:readerExecutionMessages] <<
                           'WARNING: FGDC reader: Stereographic projection is missing one or more parameters'
                     end
                  end

                  return nil

               end

            end

         end
      end
   end
end
