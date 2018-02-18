# Reader - fgdc to internal data structure
# unpack fgdc map projection - space oblique

# History:
#  Stan Smith 2017-10-18 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'projection_common'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module SpaceObliqueProjection

               def self.unpack(xParams, hProjection, hResponseObj)

                  # map projection 4.1.2.1.19 (spaceobq) - Space Oblique Mercator (Landsat)
                  unless xParams.empty?
                     paramCount = 0
                     hProjection[:projection] = 'spaceOblique'
                     hProjection[:projectionName] = 'Space Oblique Mercator (Landsat)'

                     # -> ReferenceSystemParameters.projection.landsatNumber
                     paramCount += ProjectionCommon.unpackLandSat(xParams, hProjection, hResponseObj)

                     # -> ReferenceSystemParameters.projection.landsatPath
                     paramCount += ProjectionCommon.unpackLandSatPath(xParams, hProjection, hResponseObj)

                     # -> ReferenceSystemParameters.projection.falseEasting
                     # -> ReferenceSystemParameters.projection.falseNorthing
                     paramCount += ProjectionCommon.unpackFalseNE(xParams, hProjection, hResponseObj)

                     # verify parameter count
                     if paramCount == 4
                        return hProjection
                     else
                        hResponseObj[:readerExecutionMessages] << 'WARNING: Space Oblique projection is missing one or more parameters'
                     end
                  end

                  return nil

               end

            end

         end
      end
   end
end
